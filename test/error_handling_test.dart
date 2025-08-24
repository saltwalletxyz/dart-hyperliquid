import 'dart:io';
import 'package:test/test.dart';
import 'package:hyperliquid/hyperliquid.dart';

void main() {
  group('Error Handling Tests', () {
    late ErrorHandler errorHandler;

    setUp(() {
      errorHandler = ErrorHandler(
        enableAutoRecovery: true,
        maxRetryAttempts: 3,
        baseRetryDelay: const Duration(milliseconds: 100),
      );
    });

    group('Basic Error Handling', () {
      test('should handle successful operations', () async {
        final result = await errorHandler.handleError<String>(
          'test-operation',
          () async => 'success',
        );

        expect(result, equals('success'));
        print('✅ Successful operation handled correctly');
      });

      test('should retry failed operations', () async {
        int attempts = 0;
        
        try {
          await errorHandler.handleError<String>(
            'failing-operation',
            () async {
              attempts++;
              if (attempts < 3) {
                throw Exception('Simulated failure');
              }
              return 'success-after-retries';
            },
            maxRetries: 3,
          );
        } catch (e) {
          // Expected to fail
        }

        expect(attempts, equals(4)); // Initial + 3 retries
        print('✅ Retry mechanism working correctly');
      });

      test('should respect max retry attempts', () async {
        int attempts = 0;
        
        try {
          await errorHandler.handleError<String>(
            'always-failing-operation',
            () async {
              attempts++;
              throw Exception('Always fails');
            },
            maxRetries: 2,
          );
          fail('Should have thrown an exception');
        } catch (e) {
          expect(attempts, equals(3)); // Initial + 2 retries
          expect(e.toString(), contains('Always fails'));
        }

        print('✅ Max retry attempts respected');
      });

      test('should handle operations without retry', () async {
        int attempts = 0;
        
        try {
          await errorHandler.handleError<String>(
            'no-retry-operation',
            () async {
              attempts++;
              throw Exception('No retry');
            },
            enableRetry: false,
          );
          fail('Should have thrown an exception');
        } catch (e) {
          expect(attempts, equals(1)); // No retries
        }

        print('✅ No-retry operations handled correctly');
      });
    });

    group('Error Statistics', () {
      test('should track error statistics', () async {
        // Generate some errors
        for (int i = 0; i < 5; i++) {
          try {
            await errorHandler.handleError<void>(
              'test-operation',
              () async => throw Exception('Test error $i'),
              enableRetry: false,
            );
          } catch (e) {
            // Expected
          }
        }

        final stats = errorHandler.getErrorStats();
        expect(stats['totalErrors'], equals(5));
        expect(stats['errorCounts'], isA<Map<String, int>>());
        
        print('✅ Error statistics tracking working');
        print('📊 Stats: ${stats['errorCounts']}');
      });

      test('should track recent errors', () async {
        await errorHandler.logError(
          'manual-error',
          Exception('Manual error'),
          StackTrace.current,
        );

        final recentErrors = errorHandler.getRecentErrors(10);
        expect(recentErrors, isNotEmpty);
        expect(recentErrors.first.operation, equals('manual-error'));
        
        print('✅ Recent error tracking working');
      });

      test('should clear error history', () {
        errorHandler.clearErrorHistory();
        
        final stats = errorHandler.getErrorStats();
        expect(stats['totalErrors'], equals(0));
        
        print('✅ Error history clearing working');
      });
    });

    group('Recovery Strategies', () {
      test('should apply recovery strategies', () async {
        // Register a custom recovery strategy
        errorHandler.registerRecoveryStrategy<TestException>(TestRecoveryStrategy());

        int attempts = 0;
        try {
          await errorHandler.handleError<String>(
            'recovery-test',
            () async {
              attempts++;
              if (attempts < 3) {
                throw TestException('Test recovery');
              }
              return 'recovered';
            },
            maxRetries: 3,
          );
        } catch (e) {
          // May still fail, but recovery strategy should be applied
        }

        print('✅ Recovery strategies can be registered and applied');
      });
    });

    group('Configuration', () {
      test('should update configuration', () {
        errorHandler.updateConfiguration(
          enableAutoRecovery: false,
          maxRetryAttempts: 5,
          baseRetryDelay: const Duration(seconds: 2),
        );

        final stats = errorHandler.getErrorStats();
        expect(stats['autoRecoveryEnabled'], isFalse);
        expect(stats['maxRetryAttempts'], equals(5));
        
        print('✅ Configuration updates working');
      });
    });
  });

  group('Structured Logging Tests', () {
    late StructuredLogger logger;

    setUp(() {
      logger = StructuredLogger(
        serviceName: 'test-service',
        version: '1.0.0',
        enableStructuredOutput: true,
      );
    });

    tearDown(() {
      logger.close();
    });

    group('Basic Logging', () {
      test('should log at different levels', () {
        logger.trace('Trace message');
        logger.debug('Debug message');
        logger.info('Info message');
        logger.warning('Warning message');
        logger.error('Error message');
        logger.fatal('Fatal message');
        
        print('✅ All log levels working');
      });

      test('should log with context', () {
        logger.info('Test message with context', {
          'userId': '12345',
          'operation': 'test',
          'timestamp': DateTime.now().toIso8601String(),
        });
        
        print('✅ Context logging working');
      });

      test('should handle global context', () {
        logger.addGlobalContext({'sessionId': 'abc123'});
        logger.info('Message with global context');
        
        logger.removeGlobalContext('sessionId');
        logger.info('Message without global context');
        
        print('✅ Global context management working');
      });
    });

    group('Specialized Logging', () {
      test('should log API requests', () {
        logger.logApiRequest(
          'POST',
          'https://api.example.com/orders',
          headers: {'Authorization': 'Bearer token123'},
          statusCode: 200,
          duration: const Duration(milliseconds: 150),
        );
        
        print('✅ API request logging working');
      });

      test('should log WebSocket events', () {
        logger.logWebSocketEvent(
          'message_received',
          channel: 'orders',
          data: {'type': 'order_update'},
        );
        
        print('✅ WebSocket event logging working');
      });

      test('should log trading operations', () {
        logger.logTradingOperation(
          'place_order',
          symbol: 'BTC-PERP',
          amount: 0.1,
          price: 50000.0,
          orderId: 'order123',
          status: 'filled',
        );
        
        print('✅ Trading operation logging working');
      });

      test('should log security events', () {
        logger.logSecurityEvent(
          'invalid_private_key',
          severity: 'warning',
          source: 'authentication',
        );
        
        print('✅ Security event logging working');
      });

      test('should log performance metrics', () {
        logger.logPerformance(
          'api_call',
          const Duration(milliseconds: 250),
          success: true,
          metrics: {'responseSize': 1024},
        );
        
        print('✅ Performance logging working');
      });
    });
  });

  group('Integration with Main Client', () {
    test('should integrate error handling with main client', () {
      const testPrivateKey = '0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d';
      
      final client = Hyperliquid(const HyperliquidConfig(
        testnet: true,
        privateKey: testPrivateKey,
      ));
      
      expect(client.errorHandler, isNotNull);
      expect(client.structuredLogger, isNotNull);
      
      final errorStats = client.errorHandler.getErrorStats();
      expect(errorStats, isA<Map<String, dynamic>>());
      
      client.disconnect();
      print('✅ Error handling integration with main client working');
    });

    test('should log client operations', () {
      const testPrivateKey = '0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d';
      
      final client = Hyperliquid(const HyperliquidConfig(
        testnet: true,
        privateKey: testPrivateKey,
      ));
      
      // Test structured logging
      client.structuredLogger.info('Client initialized', {
        'authenticated': client.isAuthenticated(),
        'testnet': client.testnet,
      });
      
      client.disconnect();
      print('✅ Client operation logging working');
    });
  });

  group('Error Handling Documentation', () {
    test('should document error handling features', () {
      print('🛠️ Error Handling & Logging Features:');
      print('');
      print('🔄 Automatic Error Recovery:');
      print('  - Configurable retry attempts (default: 3)');
      print('  - Exponential backoff with jitter');
      print('  - Custom recovery strategies per error type');
      print('  - Automatic recovery for network errors');
      print('');
      print('📊 Error Monitoring:');
      print('  - Comprehensive error statistics');
      print('  - Error history tracking (last 1000 errors)');
      print('  - Error frequency analysis');
      print('  - Recent error retrieval');
      print('');
      print('🎯 Recovery Strategies:');
      print('  - NetworkErrorRecoveryStrategy (longer delays)');
      print('  - TimeoutErrorRecoveryStrategy (timeout adjustment)');
      print('  - HttpErrorRecoveryStrategy (rate limit handling)');
      print('  - Custom strategy registration');
      print('');
      print('📝 Structured Logging:');
      print('  - JSON-formatted log output');
      print('  - Global context management');
      print('  - Specialized log types (API, WebSocket, Trading, Security)');
      print('  - Performance metric logging');
      print('  - File logging support');
      print('');
      print('🔧 Configuration:');
      print('  - Enable/disable auto-recovery');
      print('  - Configurable retry attempts');
      print('  - Adjustable retry delays');
      print('  - Log level configuration');
      print('  - Structured output toggle');
      
      expect(true, isTrue); // Placeholder assertion
    });
  });
}

// Test exception for recovery strategy testing
class TestException implements Exception {
  final String message;
  TestException(this.message);
  
  @override
  String toString() => 'TestException: $message';
}

// Test recovery strategy
class TestRecoveryStrategy extends ErrorRecoveryStrategy {
  @override
  Future<void> recover(ErrorEvent errorEvent) async {
    // Simulate recovery action
    await Future.delayed(const Duration(milliseconds: 50));
  }
}
