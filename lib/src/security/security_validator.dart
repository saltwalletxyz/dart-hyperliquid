import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:logger/logger.dart';

/// Security validation and hardening utilities
class SecurityValidator {
  static final Logger _logger = Logger();

  // Security constants
  static const int _minPrivateKeyLength = 64; // 32 bytes hex
  static const int _maxPrivateKeyLength = 66; // With 0x prefix
  static const String _privateKeyPrefix = '0x';
  static const int _maxInputLength = 10000; // Max input string length
  static const int _maxApiCallsPerMinute = 1200; // Rate limit
  static const int _maxWebSocketSubscriptions = 1000;

  // Regex patterns for validation
  static final RegExp _hexPattern = RegExp(r'^[0-9a-fA-F]+$');
  static final RegExp _addressPattern = RegExp(r'^0x[0-9a-fA-F]{40}$');
  static final RegExp _privateKeyPattern = RegExp(r'^(0x)?[0-9a-fA-F]{64}$');
  static final RegExp _symbolPattern = RegExp(r'^[A-Z0-9\-_]{1,20}$');
  static final RegExp _emailPattern = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  /// Validate private key format and security
  static ValidationResult validatePrivateKey(String privateKey) {
    try {
      // Check null or empty
      if (privateKey.isEmpty) {
        return ValidationResult.error('Private key cannot be empty');
      }

      // Check length
      if (privateKey.length < _minPrivateKeyLength || privateKey.length > _maxPrivateKeyLength) {
        return ValidationResult.error('Private key must be 64 hex characters (with optional 0x prefix)');
      }

      // Normalize (remove 0x prefix if present)
      String normalizedKey = privateKey.toLowerCase();
      if (normalizedKey.startsWith(_privateKeyPrefix)) {
        normalizedKey = normalizedKey.substring(2);
      }

      // Check hex format
      if (!_hexPattern.hasMatch(normalizedKey)) {
        return ValidationResult.error('Private key must contain only hexadecimal characters');
      }

      // Check for weak keys (all zeros, all ones, etc.)
      if (_isWeakPrivateKey(normalizedKey)) {
        return ValidationResult.error('Private key appears to be weak or invalid');
      }

      // Check entropy (basic check)
      if (!_hasGoodEntropy(normalizedKey)) {
        return ValidationResult.warning('Private key may have low entropy - ensure it was generated securely');
      }

      _logger.d('Private key validation passed');
      return ValidationResult.success('Private key is valid');
    } catch (e) {
      _logger.e('Private key validation error: $e');
      return ValidationResult.error('Private key validation failed: $e');
    }
  }

  /// Validate Ethereum address format
  static ValidationResult validateAddress(String address) {
    try {
      if (address.isEmpty) {
        return ValidationResult.error('Address cannot be empty');
      }

      if (!_addressPattern.hasMatch(address)) {
        return ValidationResult.error('Invalid Ethereum address format');
      }

      // Check for null address
      if (address.toLowerCase() == '0x0000000000000000000000000000000000000000') {
        return ValidationResult.warning('Address is the null address');
      }

      return ValidationResult.success('Address is valid');
    } catch (e) {
      return ValidationResult.error('Address validation failed: $e');
    }
  }

  /// Validate trading symbol format
  static ValidationResult validateSymbol(String symbol) {
    try {
      if (symbol.isEmpty) {
        return ValidationResult.error('Symbol cannot be empty');
      }

      if (symbol.length > 20) {
        return ValidationResult.error('Symbol too long (max 20 characters)');
      }

      if (!_symbolPattern.hasMatch(symbol)) {
        return ValidationResult.error('Symbol contains invalid characters (use A-Z, 0-9, -, _)');
      }

      return ValidationResult.success('Symbol is valid');
    } catch (e) {
      return ValidationResult.error('Symbol validation failed: $e');
    }
  }

  /// Validate numerical inputs for trading
  static ValidationResult validateTradingAmount(double amount, {double? minAmount, double? maxAmount}) {
    try {
      if (amount.isNaN || amount.isInfinite) {
        return ValidationResult.error('Amount must be a valid number');
      }

      if (amount <= 0) {
        return ValidationResult.error('Amount must be positive');
      }

      if (minAmount != null && amount < minAmount) {
        return ValidationResult.error('Amount below minimum: $minAmount');
      }

      if (maxAmount != null && amount > maxAmount) {
        return ValidationResult.error('Amount above maximum: $maxAmount');
      }

      // Check for excessive precision (more than 18 decimal places)
      final amountStr = amount.toString();
      if (amountStr.contains('.')) {
        final decimals = amountStr.split('.')[1].length;
        if (decimals > 18) {
          return ValidationResult.warning('Amount has excessive precision (>18 decimals)');
        }
      }

      return ValidationResult.success('Amount is valid');
    } catch (e) {
      return ValidationResult.error('Amount validation failed: $e');
    }
  }

  /// Validate price inputs
  static ValidationResult validatePrice(double price) {
    return validateTradingAmount(price, minAmount: 0.000001); // Min price 1 micro-unit
  }

  /// Validate leverage values
  static ValidationResult validateLeverage(int leverage) {
    try {
      if (leverage < 1 || leverage > 100) {
        return ValidationResult.error('Leverage must be between 1 and 100');
      }

      if (leverage > 50) {
        return ValidationResult.warning('High leverage (>50x) increases liquidation risk');
      }

      return ValidationResult.success('Leverage is valid');
    } catch (e) {
      return ValidationResult.error('Leverage validation failed: $e');
    }
  }

  /// Validate slippage percentage
  static ValidationResult validateSlippage(double slippage) {
    try {
      if (slippage < 0 || slippage > 1) {
        return ValidationResult.error('Slippage must be between 0 and 1 (0% to 100%)');
      }

      if (slippage > 0.1) {
        return ValidationResult.warning('High slippage (>10%) may result in poor execution');
      }

      return ValidationResult.success('Slippage is valid');
    } catch (e) {
      return ValidationResult.error('Slippage validation failed: $e');
    }
  }

  /// Sanitize string inputs to prevent injection attacks
  static String sanitizeInput(String input) {
    if (input.length > _maxInputLength) {
      input = input.substring(0, _maxInputLength);
    }

    // Remove potentially dangerous characters
    return input
        .replaceAll('<', '')
        .replaceAll('>', '')
        .replaceAll('"', '')
        .replaceAll("'", '')
        .replaceAll('\\', '')
        .replaceAll(RegExp(r'[\x00-\x1f\x7f-\x9f]'), '')
        .trim();
  }

  /// Validate API rate limiting
  static ValidationResult validateRateLimit(int callsInLastMinute) {
    if (callsInLastMinute > _maxApiCallsPerMinute) {
      return ValidationResult.error('Rate limit exceeded: $callsInLastMinute calls/minute (max: $_maxApiCallsPerMinute)');
    }

    if (callsInLastMinute > _maxApiCallsPerMinute * 0.8) {
      return ValidationResult.warning('Approaching rate limit: $callsInLastMinute calls/minute');
    }

    return ValidationResult.success('Rate limit OK');
  }

  /// Validate WebSocket subscription limits
  static ValidationResult validateSubscriptionCount(int subscriptionCount) {
    if (subscriptionCount > _maxWebSocketSubscriptions) {
      return ValidationResult.error('Too many WebSocket subscriptions: $subscriptionCount (max: $_maxWebSocketSubscriptions)');
    }

    if (subscriptionCount > _maxWebSocketSubscriptions * 0.9) {
      return ValidationResult.warning('Approaching subscription limit: $subscriptionCount');
    }

    return ValidationResult.success('Subscription count OK');
  }

  /// Check if private key is weak (common patterns)
  static bool _isWeakPrivateKey(String key) {
    // Check for all zeros
    if (key == '0' * 64) return true;

    // Check for all ones
    if (key == 'f' * 64) return true;

    // Check for simple patterns
    final patterns = [
      '1234567890abcdef' * 4,
      'abcdef1234567890' * 4,
      '0123456789abcdef' * 4,
    ];

    for (final pattern in patterns) {
      if (key == pattern) return true;
    }

    return false;
  }

  /// Basic entropy check for private keys
  static bool _hasGoodEntropy(String key) {
    // Count unique characters
    final uniqueChars = key.split('').toSet().length;

    // Should have at least 8 different hex characters
    if (uniqueChars < 8) return false;

    // Check for repeated patterns
    for (int i = 2; i <= 8; i++) {
      final pattern = key.substring(0, i);
      if (key == pattern * (64 ~/ i)) {
        return false;
      }
    }

    return true;
  }

  /// Generate secure random nonce
  static int generateSecureNonce() {
    final random = Random.secure();
    return DateTime.now().millisecondsSinceEpoch + random.nextInt(1000000);
  }

  /// Hash sensitive data for logging
  static String hashForLogging(String sensitiveData) {
    final bytes = utf8.encode(sensitiveData);
    final digest = sha256.convert(bytes);
    return '${digest.toString().substring(0, 8)}...';
  }
}

/// Validation result with severity levels
class ValidationResult {
  final bool isValid;
  final String message;
  final ValidationSeverity severity;

  const ValidationResult._(this.isValid, this.message, this.severity);

  factory ValidationResult.success(String message) {
    return ValidationResult._(true, message, ValidationSeverity.success);
  }

  factory ValidationResult.warning(String message) {
    return ValidationResult._(true, message, ValidationSeverity.warning);
  }

  factory ValidationResult.error(String message) {
    return ValidationResult._(false, message, ValidationSeverity.error);
  }

  @override
  String toString() => '$severity: $message';
}

enum ValidationSeverity {
  success,
  warning,
  error,
}
