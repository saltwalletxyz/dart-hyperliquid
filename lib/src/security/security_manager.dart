import 'dart:async';
import 'dart:collection';
import 'package:logger/logger.dart';
import 'security_validator.dart';

/// Production-grade security manager for the Hyperliquid SDK
class SecurityManager {
  final Logger _logger = Logger();
  
  // Rate limiting
  final Queue<DateTime> _apiCalls = Queue<DateTime>();
  final int _rateLimitWindow = 60; // seconds
  final int _maxCallsPerWindow = 1200;
  
  // Security monitoring
  final List<SecurityEvent> _securityEvents = [];
  final int _maxSecurityEvents = 1000;
  
  // Security configuration
  bool _strictValidation = true;
  bool _logSecurityEvents = true;
  bool _enableRateLimiting = true;
  
  /// Initialize security manager with configuration
  SecurityManager({
    bool strictValidation = true,
    bool logSecurityEvents = true,
    bool enableRateLimiting = true,
  }) : _strictValidation = strictValidation,
       _logSecurityEvents = logSecurityEvents,
       _enableRateLimiting = enableRateLimiting {
    _logger.i('SecurityManager initialized - strict: $_strictValidation, logging: $_logSecurityEvents, rate limiting: $_enableRateLimiting');
  }
  
  /// Validate private key with comprehensive security checks
  Future<ValidationResult> validatePrivateKey(String privateKey) async {
    final result = SecurityValidator.validatePrivateKey(privateKey);
    
    if (!result.isValid && _strictValidation) {
      await _logSecurityEvent(SecurityEventType.invalidPrivateKey, result.message);
      throw SecurityException('Private key validation failed: ${result.message}');
    }
    
    if (result.severity == ValidationSeverity.warning) {
      await _logSecurityEvent(SecurityEventType.weakPrivateKey, result.message);
    }
    
    return result;
  }
  
  /// Validate trading parameters with security checks
  Future<ValidationResult> validateTradingParameters({
    required String symbol,
    required double size,
    double? price,
    double? slippage,
    int? leverage,
  }) async {
    final results = <ValidationResult>[];
    
    // Validate symbol
    results.add(SecurityValidator.validateSymbol(symbol));
    
    // Validate size
    results.add(SecurityValidator.validateTradingAmount(size));
    
    // Validate price if provided
    if (price != null) {
      results.add(SecurityValidator.validatePrice(price));
    }
    
    // Validate slippage if provided
    if (slippage != null) {
      results.add(SecurityValidator.validateSlippage(slippage));
    }
    
    // Validate leverage if provided
    if (leverage != null) {
      results.add(SecurityValidator.validateLeverage(leverage));
    }
    
    // Check for any errors
    final errors = results.where((r) => !r.isValid).toList();
    if (errors.isNotEmpty) {
      final errorMessage = errors.map((e) => e.message).join('; ');
      await _logSecurityEvent(SecurityEventType.invalidTradingParameters, errorMessage);
      
      if (_strictValidation) {
        throw SecurityException('Trading parameter validation failed: $errorMessage');
      }
      
      return ValidationResult.error(errorMessage);
    }
    
    // Check for warnings
    final warnings = results.where((r) => r.severity == ValidationSeverity.warning).toList();
    if (warnings.isNotEmpty) {
      final warningMessage = warnings.map((e) => e.message).join('; ');
      await _logSecurityEvent(SecurityEventType.tradingParameterWarning, warningMessage);
      return ValidationResult.warning(warningMessage);
    }
    
    return ValidationResult.success('All trading parameters are valid');
  }
  
  /// Check rate limits before API calls
  Future<bool> checkRateLimit() async {
    if (!_enableRateLimiting) return true;
    
    final now = DateTime.now();
    
    // Remove old calls outside the window
    while (_apiCalls.isNotEmpty && 
           now.difference(_apiCalls.first).inSeconds > _rateLimitWindow) {
      _apiCalls.removeFirst();
    }
    
    // Check if we're at the limit
    if (_apiCalls.length >= _maxCallsPerWindow) {
      await _logSecurityEvent(SecurityEventType.rateLimitExceeded, 
          'Rate limit exceeded: ${_apiCalls.length} calls in last $_rateLimitWindow seconds');
      
      if (_strictValidation) {
        throw SecurityException('Rate limit exceeded. Please wait before making more requests.');
      }
      
      return false;
    }
    
    // Add current call
    _apiCalls.add(now);
    
    // Warn if approaching limit
    if (_apiCalls.length > _maxCallsPerWindow * 0.8) {
      await _logSecurityEvent(SecurityEventType.rateLimitWarning, 
          'Approaching rate limit: ${_apiCalls.length}/$_maxCallsPerWindow calls');
    }
    
    return true;
  }
  
  /// Sanitize user inputs
  String sanitizeInput(String input) {
    final sanitized = SecurityValidator.sanitizeInput(input);
    
    if (sanitized != input) {
      _logSecurityEvent(SecurityEventType.inputSanitized, 
          'Input was sanitized: ${input.length} -> ${sanitized.length} chars');
    }
    
    return sanitized;
  }
  
  /// Validate WebSocket subscription limits
  Future<ValidationResult> validateSubscriptionLimit(int currentCount) async {
    final result = SecurityValidator.validateSubscriptionCount(currentCount);
    
    if (!result.isValid) {
      await _logSecurityEvent(SecurityEventType.subscriptionLimitExceeded, result.message);
      
      if (_strictValidation) {
        throw SecurityException('Subscription limit validation failed: ${result.message}');
      }
    }
    
    if (result.severity == ValidationSeverity.warning) {
      await _logSecurityEvent(SecurityEventType.subscriptionLimitWarning, result.message);
    }
    
    return result;
  }
  
  /// Generate secure nonce for requests
  int generateSecureNonce() {
    return SecurityValidator.generateSecureNonce();
  }
  
  /// Hash sensitive data for safe logging
  String hashForLogging(String sensitiveData) {
    return SecurityValidator.hashForLogging(sensitiveData);
  }
  
  /// Get security statistics
  Map<String, dynamic> getSecurityStats() {
    final now = DateTime.now();
    final recentCalls = _apiCalls.where((call) => 
        now.difference(call).inSeconds <= _rateLimitWindow).length;
    
    final eventCounts = <SecurityEventType, int>{};
    for (final event in _securityEvents) {
      eventCounts[event.type] = (eventCounts[event.type] ?? 0) + 1;
    }
    
    return {
      'rateLimiting': {
        'enabled': _enableRateLimiting,
        'callsInWindow': recentCalls,
        'maxCallsPerWindow': _maxCallsPerWindow,
        'windowSeconds': _rateLimitWindow,
      },
      'validation': {
        'strictMode': _strictValidation,
        'loggingEnabled': _logSecurityEvents,
      },
      'events': {
        'totalEvents': _securityEvents.length,
        'eventCounts': eventCounts.map((k, v) => MapEntry(k.toString(), v)),
      },
    };
  }
  
  /// Get recent security events
  List<SecurityEvent> getRecentSecurityEvents([int? limit]) {
    final events = _securityEvents.reversed.toList();
    return limit != null ? events.take(limit).toList() : events;
  }
  
  /// Clear security event history
  void clearSecurityEvents() {
    _securityEvents.clear();
    _logger.i('Security event history cleared');
  }
  
  /// Update security configuration
  void updateConfiguration({
    bool? strictValidation,
    bool? logSecurityEvents,
    bool? enableRateLimiting,
  }) {
    if (strictValidation != null) _strictValidation = strictValidation;
    if (logSecurityEvents != null) _logSecurityEvents = logSecurityEvents;
    if (enableRateLimiting != null) _enableRateLimiting = enableRateLimiting;
    
    _logger.i('Security configuration updated - strict: $_strictValidation, logging: $_logSecurityEvents, rate limiting: $_enableRateLimiting');
  }
  
  /// Log security events
  Future<void> _logSecurityEvent(SecurityEventType type, String message) async {
    if (!_logSecurityEvents) return;
    
    final event = SecurityEvent(
      type: type,
      message: message,
      timestamp: DateTime.now(),
    );
    
    _securityEvents.add(event);
    
    // Limit event history size
    if (_securityEvents.length > _maxSecurityEvents) {
      _securityEvents.removeAt(0);
    }
    
    // Log based on severity
    switch (type) {
      case SecurityEventType.invalidPrivateKey:
      case SecurityEventType.rateLimitExceeded:
      case SecurityEventType.subscriptionLimitExceeded:
        _logger.e('SECURITY: $message');
        break;
      case SecurityEventType.weakPrivateKey:
      case SecurityEventType.rateLimitWarning:
      case SecurityEventType.subscriptionLimitWarning:
      case SecurityEventType.tradingParameterWarning:
        _logger.w('SECURITY: $message');
        break;
      default:
        _logger.i('SECURITY: $message');
    }
  }
}

/// Security event for monitoring and auditing
class SecurityEvent {
  final SecurityEventType type;
  final String message;
  final DateTime timestamp;
  
  SecurityEvent({
    required this.type,
    required this.message,
    required this.timestamp,
  });
  
  @override
  String toString() => '${timestamp.toIso8601String()} [$type] $message';
}

/// Types of security events
enum SecurityEventType {
  invalidPrivateKey,
  weakPrivateKey,
  invalidTradingParameters,
  tradingParameterWarning,
  rateLimitExceeded,
  rateLimitWarning,
  subscriptionLimitExceeded,
  subscriptionLimitWarning,
  inputSanitized,
  authenticationFailure,
  suspiciousActivity,
}

/// Security exception for critical security violations
class SecurityException implements Exception {
  final String message;
  
  SecurityException(this.message);
  
  @override
  String toString() => 'SecurityException: $message';
}
