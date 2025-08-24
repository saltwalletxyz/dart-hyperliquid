import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';

/// Production-grade structured logging system
class StructuredLogger {
  final Logger _logger;
  final String _serviceName;
  final String _version;
  final Map<String, dynamic> _globalContext = {};

  // Log configuration
  bool _enableFileLogging = false;
  bool _enableStructuredOutput = true;
  String? _logFilePath;
  IOSink? _logFile;

  StructuredLogger({
    required String serviceName,
    required String version,
    Level logLevel = Level.info,
    bool enableFileLogging = false,
    String? logFilePath,
    bool enableStructuredOutput = true,
  })  : _serviceName = serviceName,
        _version = version,
        _enableFileLogging = enableFileLogging,
        _logFilePath = logFilePath,
        _enableStructuredOutput = enableStructuredOutput,
        _logger = Logger(
          level: logLevel,
          printer: enableStructuredOutput
              ? _StructuredPrinter(serviceName, version)
              : PrettyPrinter(methodCount: 0, noBoxingByDefault: true),
        ) {
    _initializeFileLogging();
    _setGlobalContext();
  }

  /// Initialize file logging if enabled
  void _initializeFileLogging() {
    if (_enableFileLogging && _logFilePath != null) {
      try {
        final file = File(_logFilePath!);
        _logFile = file.openWrite(mode: FileMode.append);
        info('File logging initialized', {'logFile': _logFilePath});
      } catch (e) {
        _logger.e('Failed to initialize file logging: $e');
      }
    }
  }

  /// Set global context information
  void _setGlobalContext() {
    _globalContext.addAll({
      'service': _serviceName,
      'version': _version,
      'pid': pid,
      'hostname': Platform.localHostname,
      'platform': Platform.operatingSystem,
    });
  }

  /// Add global context that will be included in all log messages
  void addGlobalContext(Map<String, dynamic> context) {
    _globalContext.addAll(context);
  }

  /// Remove global context
  void removeGlobalContext(String key) {
    _globalContext.remove(key);
  }

  /// Log with trace level
  void trace(String message, [Map<String, dynamic>? context]) {
    _log(Level.trace, message, context);
  }

  /// Log with debug level
  void debug(String message, [Map<String, dynamic>? context]) {
    _log(Level.debug, message, context);
  }

  /// Log with info level
  void info(String message, [Map<String, dynamic>? context]) {
    _log(Level.info, message, context);
  }

  /// Log with warning level
  void warning(String message, [Map<String, dynamic>? context]) {
    _log(Level.warning, message, context);
  }

  /// Log with error level
  void error(String message, [dynamic error, StackTrace? stackTrace, Map<String, dynamic>? context]) {
    final errorContext = <String, dynamic>{
      if (context != null) ...context,
      if (error != null) 'error': error.toString(),
      if (stackTrace != null) 'stackTrace': stackTrace.toString(),
    };
    _log(Level.error, message, errorContext);
  }

  /// Log with fatal level
  void fatal(String message, [dynamic error, StackTrace? stackTrace, Map<String, dynamic>? context]) {
    final errorContext = <String, dynamic>{
      if (context != null) ...context,
      if (error != null) 'error': error.toString(),
      if (stackTrace != null) 'stackTrace': stackTrace.toString(),
    };
    _log(Level.fatal, message, errorContext);
  }

  /// Log API request
  void logApiRequest(
    String method,
    String url, {
    Map<String, String>? headers,
    String? body,
    int? statusCode,
    Duration? duration,
    Map<String, dynamic>? context,
  }) {
    final requestContext = <String, dynamic>{
      'type': 'api_request',
      'method': method,
      'url': url,
      if (headers != null) 'headers': _sanitizeHeaders(headers),
      if (body != null) 'bodySize': body.length,
      if (statusCode != null) 'statusCode': statusCode,
      if (duration != null) 'durationMs': duration.inMilliseconds,
      if (context != null) ...context,
    };

    final level = _getLogLevelForStatusCode(statusCode);
    _log(level, 'API Request: $method $url', requestContext);
  }

  /// Log WebSocket event
  void logWebSocketEvent(
    String event, {
    String? channel,
    Map<String, dynamic>? data,
    Map<String, dynamic>? context,
  }) {
    final wsContext = <String, dynamic>{
      'type': 'websocket_event',
      'event': event,
      if (channel != null) 'channel': channel,
      if (data != null) 'dataSize': data.length,
      if (context != null) ...context,
    };

    info('WebSocket Event: $event', wsContext);
  }

  /// Log trading operation
  void logTradingOperation(
    String operation, {
    String? symbol,
    double? amount,
    double? price,
    String? orderId,
    String? status,
    Map<String, dynamic>? context,
  }) {
    final tradingContext = <String, dynamic>{
      'type': 'trading_operation',
      'operation': operation,
      if (symbol != null) 'symbol': symbol,
      if (amount != null) 'amount': amount,
      if (price != null) 'price': price,
      if (orderId != null) 'orderId': orderId,
      if (status != null) 'status': status,
      if (context != null) ...context,
    };

    info('Trading Operation: $operation', tradingContext);
  }

  /// Log security event
  void logSecurityEvent(
    String event, {
    String? severity,
    String? source,
    Map<String, dynamic>? context,
  }) {
    final securityContext = <String, dynamic>{
      'type': 'security_event',
      'event': event,
      if (severity != null) 'severity': severity,
      if (source != null) 'source': source,
      if (context != null) ...context,
    };

    final level = severity == 'critical' ? Level.fatal : Level.warning;
    _log(level, 'Security Event: $event', securityContext);
  }

  /// Log performance metric
  void logPerformance(
    String operation,
    Duration duration, {
    bool? success,
    Map<String, dynamic>? metrics,
    Map<String, dynamic>? context,
  }) {
    final perfContext = <String, dynamic>{
      'type': 'performance',
      'operation': operation,
      'durationMs': duration.inMilliseconds,
      if (success != null) 'success': success,
      if (metrics != null) ...metrics,
      if (context != null) ...context,
    };

    debug('Performance: $operation', perfContext);
  }

  /// Internal logging method
  void _log(Level level, String message, [Map<String, dynamic>? context]) {
    final logContext = <String, dynamic>{
      ..._globalContext,
      if (context != null) ...context,
      'timestamp': DateTime.now().toUtc().toIso8601String(),
    };

    if (_enableStructuredOutput) {
      _logger.log(level, message, error: logContext);
    } else {
      _logger.log(level, message);
    }

    // Write to file if enabled
    if (_logFile != null) {
      _writeToFile(level, message, logContext);
    }
  }

  /// Write structured log to file
  void _writeToFile(Level level, String message, Map<String, dynamic> context) {
    try {
      final logEntry = {
        'level': level.name,
        'message': message,
        ...context,
      };

      _logFile!.writeln(jsonEncode(logEntry));
    } catch (e) {
      _logger.e('Failed to write to log file: $e');
    }
  }

  /// Sanitize headers for logging (remove sensitive data)
  Map<String, String> _sanitizeHeaders(Map<String, String> headers) {
    final sanitized = <String, String>{};

    for (final entry in headers.entries) {
      final key = entry.key.toLowerCase();
      if (key.contains('authorization') || key.contains('cookie') || key.contains('token') || key.contains('key')) {
        sanitized[entry.key] = '[REDACTED]';
      } else {
        sanitized[entry.key] = entry.value;
      }
    }

    return sanitized;
  }

  /// Get appropriate log level for HTTP status code
  Level _getLogLevelForStatusCode(int? statusCode) {
    if (statusCode == null) return Level.info;

    if (statusCode >= 500) return Level.error;
    if (statusCode >= 400) return Level.warning;
    return Level.info;
  }

  /// Close logger and cleanup resources
  void close() {
    _logFile?.close();
    _logFile = null;
  }
}

/// Custom printer for structured logging
class _StructuredPrinter extends LogPrinter {
  final String serviceName;
  final String version;

  _StructuredPrinter(this.serviceName, this.version);

  @override
  List<String> log(LogEvent event) {
    final context = event.error as Map<String, dynamic>?;

    final logEntry = {
      'timestamp': DateTime.now().toUtc().toIso8601String(),
      'level': event.level.name.toUpperCase(),
      'service': serviceName,
      'version': version,
      'message': event.message,
      if (context != null) ...context,
    };

    return [jsonEncode(logEntry)];
  }
}

/// Log level extensions
extension LogLevelExtension on Level {
  String get name {
    switch (this) {
      case Level.trace:
        return 'trace';
      case Level.debug:
        return 'debug';
      case Level.info:
        return 'info';
      case Level.warning:
        return 'warning';
      case Level.error:
        return 'error';
      case Level.fatal:
        return 'fatal';
      default:
        return 'unknown';
    }
  }
}
