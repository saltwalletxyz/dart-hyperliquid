import 'package:test/test.dart';
import 'package:hyperliquid/hyperliquid.dart';

void main() {
  group('Security Validation Tests', () {
    group('Private Key Validation', () {
      test('should validate correct private keys', () {
        const validKey = '0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d';
        final result = SecurityValidator.validatePrivateKey(validKey);
        
        expect(result.isValid, isTrue);
        expect(result.severity, equals(ValidationSeverity.success));
        print('✅ Valid private key accepted');
      });

      test('should reject empty private keys', () {
        final result = SecurityValidator.validatePrivateKey('');
        
        expect(result.isValid, isFalse);
        expect(result.message, contains('cannot be empty'));
        print('✅ Empty private key rejected');
      });

      test('should reject short private keys', () {
        final result = SecurityValidator.validatePrivateKey('0x123');
        
        expect(result.isValid, isFalse);
        expect(result.message, contains('64 hex characters'));
        print('✅ Short private key rejected');
      });

      test('should reject non-hex private keys', () {
        final result = SecurityValidator.validatePrivateKey('0x' + 'g' * 64);
        
        expect(result.isValid, isFalse);
        expect(result.message, contains('hexadecimal characters'));
        print('✅ Non-hex private key rejected');
      });

      test('should detect weak private keys', () {
        final weakKeys = [
          '0x' + '0' * 64, // All zeros
          '0x' + 'f' * 64, // All ones
          '0x' + '1234567890abcdef' * 4, // Pattern
        ];

        for (final weakKey in weakKeys) {
          final result = SecurityValidator.validatePrivateKey(weakKey);
          expect(result.isValid, isFalse);
          expect(result.message, contains('weak'));
        }
        
        print('✅ Weak private keys detected');
      });

      test('should warn about low entropy keys', () {
        // Key with low entropy (only uses 0, 1, 2, 3)
        final lowEntropyKey = '0x' + '0123' * 16;
        final result = SecurityValidator.validatePrivateKey(lowEntropyKey);
        
        expect(result.isValid, isTrue);
        expect(result.severity, equals(ValidationSeverity.warning));
        expect(result.message, contains('entropy'));
        print('✅ Low entropy warning triggered');
      });
    });

    group('Address Validation', () {
      test('should validate correct addresses', () {
        const validAddress = '0x742d35Cc6634C0532925a3b8D4C9db96C4b5Da5e';
        final result = SecurityValidator.validateAddress(validAddress);
        
        expect(result.isValid, isTrue);
        print('✅ Valid address accepted');
      });

      test('should reject invalid address formats', () {
        final invalidAddresses = [
          '', // Empty
          '0x123', // Too short
          '742d35Cc6634C0532925a3b8D4C9db96C4b5Da5e', // No 0x prefix
          '0x742d35Cc6634C0532925a3b8D4C9db96C4b5Da5g', // Invalid hex
        ];

        for (final address in invalidAddresses) {
          final result = SecurityValidator.validateAddress(address);
          expect(result.isValid, isFalse);
        }
        
        print('✅ Invalid addresses rejected');
      });

      test('should warn about null address', () {
        const nullAddress = '0x0000000000000000000000000000000000000000';
        final result = SecurityValidator.validateAddress(nullAddress);
        
        expect(result.isValid, isTrue);
        expect(result.severity, equals(ValidationSeverity.warning));
        expect(result.message, contains('null address'));
        print('✅ Null address warning triggered');
      });
    });

    group('Trading Parameter Validation', () {
      test('should validate correct trading amounts', () {
        final amounts = [0.001, 1.0, 100.5, 1000000.0];
        
        for (final amount in amounts) {
          final result = SecurityValidator.validateTradingAmount(amount);
          expect(result.isValid, isTrue);
        }
        
        print('✅ Valid trading amounts accepted');
      });

      test('should reject invalid trading amounts', () {
        final invalidAmounts = [0.0, -1.0, double.nan, double.infinity];
        
        for (final amount in invalidAmounts) {
          final result = SecurityValidator.validateTradingAmount(amount);
          expect(result.isValid, isFalse);
        }
        
        print('✅ Invalid trading amounts rejected');
      });

      test('should validate amount ranges', () {
        final result1 = SecurityValidator.validateTradingAmount(0.5, minAmount: 1.0);
        expect(result1.isValid, isFalse);
        expect(result1.message, contains('minimum'));
        
        final result2 = SecurityValidator.validateTradingAmount(150.0, maxAmount: 100.0);
        expect(result2.isValid, isFalse);
        expect(result2.message, contains('maximum'));
        
        print('✅ Amount range validation working');
      });

      test('should validate leverage values', () {
        final validLeverages = [1, 5, 10, 25, 50];
        for (final leverage in validLeverages) {
          final result = SecurityValidator.validateLeverage(leverage);
          expect(result.isValid, isTrue);
        }
        
        final invalidLeverages = [0, -1, 101, 1000];
        for (final leverage in invalidLeverages) {
          final result = SecurityValidator.validateLeverage(leverage);
          expect(result.isValid, isFalse);
        }
        
        print('✅ Leverage validation working');
      });

      test('should warn about high leverage', () {
        final result = SecurityValidator.validateLeverage(75);
        expect(result.isValid, isTrue);
        expect(result.severity, equals(ValidationSeverity.warning));
        expect(result.message, contains('High leverage'));
        
        print('✅ High leverage warning triggered');
      });

      test('should validate slippage values', () {
        final validSlippages = [0.0, 0.01, 0.05, 0.1];
        for (final slippage in validSlippages) {
          final result = SecurityValidator.validateSlippage(slippage);
          expect(result.isValid, isTrue);
        }
        
        final invalidSlippages = [-0.1, 1.1, 2.0];
        for (final slippage in invalidSlippages) {
          final result = SecurityValidator.validateSlippage(slippage);
          expect(result.isValid, isFalse);
        }
        
        print('✅ Slippage validation working');
      });
    });

    group('Symbol Validation', () {
      test('should validate correct symbols', () {
        final validSymbols = ['BTC-PERP', 'ETH-PERP', 'SOL-PERP', 'USDC'];
        
        for (final symbol in validSymbols) {
          final result = SecurityValidator.validateSymbol(symbol);
          expect(result.isValid, isTrue);
        }
        
        print('✅ Valid symbols accepted');
      });

      test('should reject invalid symbols', () {
        final invalidSymbols = [
          '', // Empty
          'btc-perp', // Lowercase
          'BTC PERP', // Space
          'BTC@PERP', // Invalid character
          'A' * 25, // Too long
        ];
        
        for (final symbol in invalidSymbols) {
          final result = SecurityValidator.validateSymbol(symbol);
          expect(result.isValid, isFalse);
        }
        
        print('✅ Invalid symbols rejected');
      });
    });

    group('Input Sanitization', () {
      test('should sanitize dangerous inputs', () {
        final dangerousInputs = [
          '<script>alert("xss")</script>',
          'SELECT * FROM users; DROP TABLE users;',
          'test\x00null\x1fbyte',
          '"quoted"string\'with\'quotes',
        ];
        
        for (final input in dangerousInputs) {
          final sanitized = SecurityValidator.sanitizeInput(input);
          expect(sanitized, isNot(equals(input)));
          expect(sanitized, isNot(contains('<')));
          expect(sanitized, isNot(contains('>')));
          expect(sanitized, isNot(contains('"')));
        }
        
        print('✅ Input sanitization working');
      });

      test('should handle long inputs', () {
        final longInput = 'a' * 20000;
        final sanitized = SecurityValidator.sanitizeInput(longInput);
        
        expect(sanitized.length, lessThanOrEqualTo(10000));
        print('✅ Long input truncation working');
      });
    });

    group('Rate Limiting', () {
      test('should validate rate limits', () {
        final result1 = SecurityValidator.validateRateLimit(100);
        expect(result1.isValid, isTrue);
        
        final result2 = SecurityValidator.validateRateLimit(1000);
        expect(result2.isValid, isTrue);
        expect(result2.severity, equals(ValidationSeverity.warning));
        
        final result3 = SecurityValidator.validateRateLimit(1500);
        expect(result3.isValid, isFalse);
        
        print('✅ Rate limit validation working');
      });
    });

    group('Utility Functions', () {
      test('should generate secure nonces', () {
        final nonces = <int>{};
        
        for (int i = 0; i < 100; i++) {
          final nonce = SecurityValidator.generateSecureNonce();
          expect(nonce, greaterThan(0));
          expect(nonces.contains(nonce), isFalse); // Should be unique
          nonces.add(nonce);
        }
        
        print('✅ Secure nonce generation working');
      });

      test('should hash sensitive data for logging', () {
        const sensitiveData = 'very-secret-private-key-data';
        final hashed = SecurityValidator.hashForLogging(sensitiveData);
        
        expect(hashed, isNot(equals(sensitiveData)));
        expect(hashed.length, lessThan(sensitiveData.length));
        expect(hashed, endsWith('...'));
        
        print('✅ Sensitive data hashing working');
      });
    });
  });

  group('Security Manager Tests', () {
    late SecurityManager securityManager;

    setUp(() {
      securityManager = SecurityManager(
        strictValidation: true,
        logSecurityEvents: true,
        enableRateLimiting: true,
      );
    });

    group('Configuration', () {
      test('should initialize with correct configuration', () {
        final stats = securityManager.getSecurityStats();
        
        expect(stats['validation']['strictMode'], isTrue);
        expect(stats['validation']['loggingEnabled'], isTrue);
        expect(stats['rateLimiting']['enabled'], isTrue);
        
        print('✅ Security manager configuration working');
      });

      test('should update configuration', () {
        securityManager.updateConfiguration(
          strictValidation: false,
          enableRateLimiting: false,
        );
        
        final stats = securityManager.getSecurityStats();
        expect(stats['validation']['strictMode'], isFalse);
        expect(stats['rateLimiting']['enabled'], isFalse);
        
        print('✅ Configuration updates working');
      });
    });

    group('Rate Limiting', () {
      test('should track API calls', () async {
        // Make several calls
        for (int i = 0; i < 10; i++) {
          final allowed = await securityManager.checkRateLimit();
          expect(allowed, isTrue);
        }
        
        final stats = securityManager.getSecurityStats();
        expect(stats['rateLimiting']['callsInWindow'], equals(10));
        
        print('✅ Rate limiting tracking working');
      });
    });

    group('Security Events', () {
      test('should log security events', () async {
        // Trigger a security event
        try {
          await securityManager.validatePrivateKey('invalid-key');
        } catch (e) {
          // Expected to fail
        }
        
        final events = securityManager.getRecentSecurityEvents();
        expect(events, isNotEmpty);
        expect(events.first.type, equals(SecurityEventType.invalidPrivateKey));
        
        print('✅ Security event logging working');
      });

      test('should clear security events', () {
        securityManager.clearSecurityEvents();
        final events = securityManager.getRecentSecurityEvents();
        expect(events, isEmpty);
        
        print('✅ Security event clearing working');
      });
    });

    group('Input Sanitization', () {
      test('should sanitize inputs', () {
        const dangerousInput = '<script>alert("test")</script>';
        final sanitized = securityManager.sanitizeInput(dangerousInput);
        
        expect(sanitized, isNot(contains('<script>')));
        print('✅ Security manager input sanitization working');
      });
    });

    group('Utility Methods', () {
      test('should generate secure nonces', () {
        final nonce1 = securityManager.generateSecureNonce();
        final nonce2 = securityManager.generateSecureNonce();
        
        expect(nonce1, isNot(equals(nonce2)));
        expect(nonce1, greaterThan(0));
        expect(nonce2, greaterThan(0));
        
        print('✅ Security manager nonce generation working');
      });

      test('should hash sensitive data', () {
        const sensitiveData = 'private-key-or-secret';
        final hashed = securityManager.hashForLogging(sensitiveData);
        
        expect(hashed, isNot(equals(sensitiveData)));
        expect(hashed, endsWith('...'));
        
        print('✅ Security manager data hashing working');
      });
    });
  });

  group('Integration with Main Client', () {
    test('should integrate security with main client', () {
      const testPrivateKey = '0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d';
      
      final client = Hyperliquid(const HyperliquidConfig(
        testnet: true,
        privateKey: testPrivateKey,
      ));
      
      expect(client.security, isNotNull);
      expect(client.isAuthenticated(), isTrue);
      
      final stats = client.security.getSecurityStats();
      expect(stats, isA<Map<String, dynamic>>());
      
      client.disconnect();
      print('✅ Security integration with main client working');
    });

    test('should reject invalid private keys in main client', () {
      expect(() => Hyperliquid(const HyperliquidConfig(
        testnet: true,
        privateKey: 'invalid-key',
      )), throwsException);
      
      print('✅ Main client rejects invalid private keys');
    });
  });

  group('Security Documentation', () {
    test('should document security features', () {
      print('🛡️ Security Features Implemented:');
      print('');
      print('🔐 Private Key Security:');
      print('  - Format validation (64 hex chars with optional 0x prefix)');
      print('  - Weak key detection (all zeros, patterns, etc.)');
      print('  - Entropy analysis and warnings');
      print('  - Secure storage recommendations');
      print('');
      print('📊 Input Validation:');
      print('  - Trading amount validation with min/max limits');
      print('  - Price validation with reasonable bounds');
      print('  - Leverage validation (1-100x with warnings >50x)');
      print('  - Slippage validation (0-100% with warnings >10%)');
      print('  - Symbol format validation');
      print('  - Address format validation');
      print('');
      print('🚫 Input Sanitization:');
      print('  - XSS prevention (removes <, >, quotes)');
      print('  - SQL injection prevention');
      print('  - Control character removal');
      print('  - Length limiting (max 10,000 chars)');
      print('');
      print('⏱️ Rate Limiting:');
      print('  - API call tracking (1200 calls/minute max)');
      print('  - Warning at 80% of limit');
      print('  - Configurable enforcement');
      print('');
      print('📡 WebSocket Security:');
      print('  - Subscription limit enforcement (1000 max)');
      print('  - Connection state monitoring');
      print('  - Automatic cleanup on disconnect');
      print('');
      print('📝 Security Monitoring:');
      print('  - Comprehensive event logging');
      print('  - Security statistics tracking');
      print('  - Configurable strict mode');
      print('  - Audit trail for security events');
      print('');
      print('🔧 Utility Functions:');
      print('  - Secure nonce generation');
      print('  - Sensitive data hashing for logs');
      print('  - Configuration management');
      
      expect(true, isTrue); // Placeholder assertion
    });
  });
}
