import 'dart:async';
import 'dart:io';
import 'package:logger/logger.dart';

/// Production-grade error handling and recovery system
class ErrorHandler {
  final Logger _logger = Logger();
  final List<ErrorEvent> _errorHistory = [];
  final int _maxErrorHistory = 1000;

  // Error recovery configuration
  final Map<Type, ErrorRecoveryStrategy> _recoveryStrategies = {};
  bool _enableAutoRecovery = true;
  int _maxRetryAttempts = 3;
  Duration _baseRetryDelay = const Duration(seconds: 1);

  // Error monitoring
  final Map<String, int> _errorCounts = {};
  final Map<String, DateTime> _lastErrorTimes = {};

  ErrorHandler({
    bool enableAutoRecovery = true,
    int maxRetryAttempts = 3,
    Duration baseRetryDelay = const Duration(seconds: 1),
  })  : _enableAutoRecovery = enableAutoRecovery,
        _maxRetryAttempts = maxRetryAttempts,
        _baseRetryDelay = baseRetryDelay {
    _setupDefaultRecoveryStrategies();
    _logger.i('ErrorHandler initialized - autoRecovery: $_enableAutoRecovery, maxRetries: $_maxRetryAttempts');
  }

  /// Handle an error with automatic recovery
  Future<T?> handleError<T>(
    String operation,
    Future<T> Function() action, {
    ErrorSeverity severity = ErrorSeverity.error,
    Map<String, dynamic>? context,
    bool enableRetry = true,
    int? maxRetries,
    Duration? retryDelay,
  }) async {
    final actualMaxRetries = maxRetries ?? _maxRetryAttempts;
    final actualRetryDelay = retryDelay ?? _baseRetryDelay;

    for (int attempt = 1; attempt <= actualMaxRetries + 1; attempt++) {
      try {
        final result = await action();

        // Log successful recovery if this was a retry
        if (attempt > 1) {
          _logger.i('Operation "$operation" succeeded after ${attempt - 1} retries');
        }

        return result;
      } catch (error, stackTrace) {
        final isLastAttempt = attempt > actualMaxRetries;

        // Create error event
        final errorEvent = ErrorEvent(
          operation: operation,
          error: error,
          stackTrace: stackTrace,
          severity: severity,
          context: context ?? {},
          timestamp: DateTime.now(),
          attempt: attempt,
          maxAttempts: actualMaxRetries + 1,
        );

        // Log the error
        await _logError(errorEvent);

        // Add to error history
        _addToErrorHistory(errorEvent);

        // Update error statistics
        _updateErrorStats(operation, error);

        // If this is the last attempt or retry is disabled, throw the error
        if (isLastAttempt || !enableRetry || !_enableAutoRecovery) {
          _logger.e('Operation "$operation" failed after $attempt attempts');
          rethrow;
        }

        // Apply recovery strategy if available
        final recoveryStrategy = _getRecoveryStrategy(error.runtimeType);
        if (recoveryStrategy != null) {
          try {
            await recoveryStrategy.recover(errorEvent);
            _logger.i('Applied recovery strategy for ${error.runtimeType}');
          } catch (recoveryError) {
            _logger.w('Recovery strategy failed: $recoveryError');
          }
        }

        // Wait before retry with exponential backoff
        final delay = Duration(
          milliseconds: (actualRetryDelay.inMilliseconds * (attempt * attempt)).clamp(
            actualRetryDelay.inMilliseconds,
            30000, // Max 30 seconds
          ),
        );

        _logger.w('Retrying operation "$operation" in ${delay.inMilliseconds}ms (attempt $attempt/${actualMaxRetries + 1})');
        await Future<void>.delayed(delay);
      }
    }

    return null; // Should never reach here
  }

  /// Handle an error without retry
  Future<void> logError(
    String operation,
    dynamic error,
    StackTrace stackTrace, {
    ErrorSeverity severity = ErrorSeverity.error,
    Map<String, dynamic>? context,
  }) async {
    final errorEvent = ErrorEvent(
      operation: operation,
      error: error,
      stackTrace: stackTrace,
      severity: severity,
      context: context ?? {},
      timestamp: DateTime.now(),
      attempt: 1,
      maxAttempts: 1,
    );

    await _logError(errorEvent);
    _addToErrorHistory(errorEvent);
    _updateErrorStats(operation, error);
  }

  /// Register a custom recovery strategy
  void registerRecoveryStrategy<T>(ErrorRecoveryStrategy strategy) {
    _recoveryStrategies[T] = strategy;
    _logger.d('Registered recovery strategy for ${T.toString()}');
  }

  /// Get error statistics
  Map<String, dynamic> getErrorStats() {
    final now = DateTime.now();
    final recentErrors = _errorHistory.where((e) => now.difference(e.timestamp).inHours < 24).length;

    return {
      'totalErrors': _errorHistory.length,
      'recentErrors24h': recentErrors,
      'errorCounts': Map<String, int>.from(_errorCounts),
      'lastErrorTimes': _lastErrorTimes.map((k, v) => MapEntry(k, v.toIso8601String())),
      'autoRecoveryEnabled': _enableAutoRecovery,
      'maxRetryAttempts': _maxRetryAttempts,
    };
  }

  /// Get recent error events
  List<ErrorEvent> getRecentErrors([int? limit]) {
    final errors = _errorHistory.reversed.toList();
    return limit != null ? errors.take(limit).toList() : errors;
  }

  /// Clear error history
  void clearErrorHistory() {
    _errorHistory.clear();
    _errorCounts.clear();
    _lastErrorTimes.clear();
    _logger.i('Error history cleared');
  }

  /// Update error handling configuration
  void updateConfiguration({
    bool? enableAutoRecovery,
    int? maxRetryAttempts,
    Duration? baseRetryDelay,
  }) {
    if (enableAutoRecovery != null) _enableAutoRecovery = enableAutoRecovery;
    if (maxRetryAttempts != null) _maxRetryAttempts = maxRetryAttempts;
    if (baseRetryDelay != null) _baseRetryDelay = baseRetryDelay;

    _logger.i('Error handler configuration updated');
  }

  /// Log error event
  Future<void> _logError(ErrorEvent errorEvent) async {
    final errorType = errorEvent.error.runtimeType.toString();
    final message = 'Operation "${errorEvent.operation}" failed: ${errorEvent.error}';

    switch (errorEvent.severity) {
      case ErrorSeverity.critical:
        _logger.f('CRITICAL: $message');
        break;
      case ErrorSeverity.error:
        _logger.e('ERROR: $message');
        break;
      case ErrorSeverity.warning:
        _logger.w('WARNING: $message');
        break;
      case ErrorSeverity.info:
        _logger.i('INFO: $message');
        break;
    }

    // Log additional context if available
    if (errorEvent.context.isNotEmpty) {
      _logger.d('Error context: ${errorEvent.context}');
    }
  }

  /// Add error to history
  void _addToErrorHistory(ErrorEvent errorEvent) {
    _errorHistory.add(errorEvent);

    // Limit history size
    if (_errorHistory.length > _maxErrorHistory) {
      _errorHistory.removeAt(0);
    }
  }

  /// Update error statistics
  void _updateErrorStats(String operation, dynamic error) {
    final errorKey = '${operation}:${error.runtimeType}';
    _errorCounts[errorKey] = (_errorCounts[errorKey] ?? 0) + 1;
    _lastErrorTimes[errorKey] = DateTime.now();
  }

  /// Get recovery strategy for error type
  ErrorRecoveryStrategy? _getRecoveryStrategy(Type errorType) {
    return _recoveryStrategies[errorType];
  }

  /// Setup default recovery strategies
  void _setupDefaultRecoveryStrategies() {
    // Network error recovery
    registerRecoveryStrategy<SocketException>(NetworkErrorRecoveryStrategy());
    registerRecoveryStrategy<TimeoutException>(TimeoutErrorRecoveryStrategy());
    registerRecoveryStrategy<HttpException>(HttpErrorRecoveryStrategy());

    _logger.d('Default recovery strategies registered');
  }
}

/// Error event for tracking and analysis
class ErrorEvent {
  final String operation;
  final dynamic error;
  final StackTrace stackTrace;
  final ErrorSeverity severity;
  final Map<String, dynamic> context;
  final DateTime timestamp;
  final int attempt;
  final int maxAttempts;

  ErrorEvent({
    required this.operation,
    required this.error,
    required this.stackTrace,
    required this.severity,
    required this.context,
    required this.timestamp,
    required this.attempt,
    required this.maxAttempts,
  });

  @override
  String toString() => '${timestamp.toIso8601String()} [$severity] $operation: $error (attempt $attempt/$maxAttempts)';
}

/// Error severity levels
enum ErrorSeverity {
  critical,
  error,
  warning,
  info,
}

/// Abstract base class for error recovery strategies
abstract class ErrorRecoveryStrategy {
  Future<void> recover(ErrorEvent errorEvent);
}

/// Network error recovery strategy
class NetworkErrorRecoveryStrategy extends ErrorRecoveryStrategy {
  @override
  Future<void> recover(ErrorEvent errorEvent) async {
    // Wait a bit longer for network issues
    await Future<void>.delayed(const Duration(seconds: 2));
  }
}

/// Timeout error recovery strategy
class TimeoutErrorRecoveryStrategy extends ErrorRecoveryStrategy {
  @override
  Future<void> recover(ErrorEvent errorEvent) async {
    // Increase timeout for next attempt (implementation specific)
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }
}

/// HTTP error recovery strategy
class HttpErrorRecoveryStrategy extends ErrorRecoveryStrategy {
  @override
  Future<void> recover(ErrorEvent errorEvent) async {
    // Check if it's a rate limit error and wait accordingly
    if (errorEvent.error.toString().contains('429')) {
      await Future<void>.delayed(const Duration(seconds: 5));
    } else {
      await Future<void>.delayed(const Duration(seconds: 1));
    }
  }
}
