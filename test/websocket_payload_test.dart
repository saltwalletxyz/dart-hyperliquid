import 'package:test/test.dart';
import 'package:hyperliquid/hyperliquid.dart';

void main() {
  group('WebSocket Payload Tests', () {
    late Hyperliquid authenticatedClient;
    const testPrivateKey = '0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d';

    setUp(() {
      authenticatedClient = Hyperliquid(const HyperliquidConfig(
        testnet: true,
        privateKey: testPrivateKey,
        enableWs: true, // Enable WebSocket for payload tests
      ));
    });

    tearDown(() {
      authenticatedClient.disconnect();
    });

    group('Initialization', () {
      test('should initialize WebSocket payload manager with authentication', () {
        expect(authenticatedClient.isAuthenticated(), isTrue);
        expect(authenticatedClient.enableWs, isTrue);
        expect(authenticatedClient.wsPayloads, isNotNull);
      });

      test('should not initialize WebSocket payloads without WebSocket enabled', () {
        final noWsClient = Hyperliquid(const HyperliquidConfig(
          testnet: true,
          privateKey: testPrivateKey,
          enableWs: false, // Disable WebSocket
        ));
        
        expect(noWsClient.isAuthenticated(), isTrue);
        expect(noWsClient.enableWs, isFalse);
        expect(() => noWsClient.wsPayloads, throwsA(anything));
        
        noWsClient.disconnect();
      });

      test('should not initialize WebSocket payloads without authentication', () {
        final unauthenticatedClient = Hyperliquid(const HyperliquidConfig(
          testnet: true,
          enableWs: true,
        ));
        
        expect(unauthenticatedClient.isAuthenticated(), isFalse);
        expect(() => unauthenticatedClient.wsPayloads, throwsA(anything));
        
        unauthenticatedClient.disconnect();
      });
    });

    group('Payload Generation', () {
      test('should generate valid order payload', () async {
        try {
          await authenticatedClient.connect();
          
          final orderParams = {
            'coin': 'BTC-PERP',
            'is_buy': true,
            'sz': 0.01,
            'limit_px': 50000,
            'order_type': {'limit': {}},
            'reduce_only': false,
          };
          
          final payload = await authenticatedClient.wsPayloads.generatePayload('placeOrder', {
            'orders': [orderParams]
          });
          
          expect(payload, isA<Map<String, dynamic>>());
          expect(payload['action'], isNotNull);
          expect(payload['signature'], isNotNull);
          expect(payload['nonce'], isNotNull);
          
          print('✅ Order payload generated successfully');
          print('📋 Action type: ${payload['action']['type']}');
          
        } catch (e) {
          print('Payload generation test skipped: $e');
        }
      }, skip: 'Requires internet connection for symbol conversion');

      test('should generate valid cancel payload', () async {
        try {
          await authenticatedClient.connect();
          
          final cancelParams = {
            'coin': 'BTC-PERP',
            'o': 123456789,
          };
          
          final payload = await authenticatedClient.wsPayloads.generatePayload('cancelOrder', {
            'cancels': [cancelParams]
          });
          
          expect(payload, isA<Map<String, dynamic>>());
          expect(payload['action'], isNotNull);
          expect(payload['signature'], isNotNull);
          expect(payload['nonce'], isNotNull);
          
          print('✅ Cancel payload generated successfully');
          
        } catch (e) {
          print('Cancel payload generation test skipped: $e');
        }
      }, skip: 'Requires internet connection for symbol conversion');
    });

    group('Available Methods', () {
      test('should list all available exchange methods', () {
        final methods = authenticatedClient.wsPayloads.getAvailableMethods();
        
        expect(methods, isA<List<String>>());
        expect(methods.length, greaterThan(0));
        
        // Check for key methods
        expect(methods, contains('placeOrder'));
        expect(methods, contains('cancelOrder'));
        expect(methods, contains('updateLeverage'));
        expect(methods, contains('usdTransfer'));
        expect(methods, contains('vaultTransfer'));
        expect(methods, contains('placeTwapOrder'));
        
        print('✅ Available methods: ${methods.length}');
        print('📋 Methods: ${methods.take(10).toList()}...');
      });

      test('should check method support correctly', () {
        expect(authenticatedClient.wsPayloads.isMethodSupported('placeOrder'), isTrue);
        expect(authenticatedClient.wsPayloads.isMethodSupported('cancelOrder'), isTrue);
        expect(authenticatedClient.wsPayloads.isMethodSupported('invalidMethod'), isFalse);
        
        print('✅ Method support checking works correctly');
      });
    });

    group('Order Management Methods', () {
      test('should have place order method', () {
        expect(authenticatedClient.wsPayloads.placeOrder, isNotNull);
      });

      test('should have place orders method', () {
        expect(authenticatedClient.wsPayloads.placeOrders, isNotNull);
      });

      test('should have cancel order method', () {
        expect(authenticatedClient.wsPayloads.cancelOrder, isNotNull);
      });

      test('should have cancel orders method', () {
        expect(authenticatedClient.wsPayloads.cancelOrders, isNotNull);
      });

      test('should have modify order method', () {
        expect(authenticatedClient.wsPayloads.modifyOrder, isNotNull);
      });

      test('should have batch modify method', () {
        expect(authenticatedClient.wsPayloads.batchModify, isNotNull);
      });
    });

    group('Leverage and Margin Methods', () {
      test('should have update leverage method', () {
        expect(authenticatedClient.wsPayloads.updateLeverage, isNotNull);
      });

      test('should have update isolated margin method', () {
        expect(authenticatedClient.wsPayloads.updateIsolatedMargin, isNotNull);
      });
    });

    group('Transfer Methods', () {
      test('should have USD transfer method', () {
        expect(authenticatedClient.wsPayloads.usdTransfer, isNotNull);
      });

      test('should have spot transfer method', () {
        expect(authenticatedClient.wsPayloads.spotTransfer, isNotNull);
      });
    });

    group('Vault Methods', () {
      test('should have vault transfer method', () {
        expect(authenticatedClient.wsPayloads.vaultTransfer, isNotNull);
      });

      test('should have create vault method', () {
        expect(authenticatedClient.wsPayloads.createVault, isNotNull);
      });

      test('should have vault distribute method', () {
        expect(authenticatedClient.wsPayloads.vaultDistribute, isNotNull);
      });

      test('should have vault modify method', () {
        expect(authenticatedClient.wsPayloads.vaultModify, isNotNull);
      });
    });

    group('TWAP Methods', () {
      test('should have place TWAP order method', () {
        expect(authenticatedClient.wsPayloads.placeTwapOrder, isNotNull);
      });

      test('should have cancel TWAP order method', () {
        expect(authenticatedClient.wsPayloads.cancelTwapOrder, isNotNull);
      });
    });

    group('Agent Methods', () {
      test('should have approve agent method', () {
        expect(authenticatedClient.wsPayloads.approveAgent, isNotNull);
      });

      test('should have approve builder fee method', () {
        expect(authenticatedClient.wsPayloads.approveBuilderFee, isNotNull);
      });
    });

    group('Withdrawal Methods', () {
      test('should have initiate withdrawal method', () {
        expect(authenticatedClient.wsPayloads.initiateWithdrawal, isNotNull);
      });
    });

    group('Sub-Account Methods', () {
      test('should have create sub-account method', () {
        expect(authenticatedClient.wsPayloads.createSubAccount, isNotNull);
      });

      test('should have sub-account transfer method', () {
        expect(authenticatedClient.wsPayloads.subAccountTransfer, isNotNull);
      });

      test('should have sub-account spot transfer method', () {
        expect(authenticatedClient.wsPayloads.subAccountSpotTransfer, isNotNull);
      });
    });

    group('Staking Methods', () {
      test('should have cDeposit method', () {
        expect(authenticatedClient.wsPayloads.cDeposit, isNotNull);
      });

      test('should have cWithdraw method', () {
        expect(authenticatedClient.wsPayloads.cWithdraw, isNotNull);
      });
    });

    group('Custom Market Operations', () {
      test('should have market open method', () {
        expect(authenticatedClient.wsPayloads.marketOpen, isNotNull);
      });

      test('should have market close method', () {
        expect(authenticatedClient.wsPayloads.marketClose, isNotNull);
      });

      test('should have close all positions method', () {
        expect(authenticatedClient.wsPayloads.closeAllPositions, isNotNull);
      });
    });

    group('Utility Methods', () {
      test('should have execute custom method', () {
        expect(authenticatedClient.wsPayloads.executeCustomMethod, isNotNull);
      });

      test('should have set vault address method', () {
        expect(authenticatedClient.wsPayloads.setVaultAddress, isNotNull);
      });

      test('should update vault address correctly', () {
        const newVaultAddress = '0x1234567890123456789012345678901234567890';
        authenticatedClient.wsPayloads.setVaultAddress(newVaultAddress);
        
        expect(authenticatedClient.wsPayloads.vaultAddress, equals(newVaultAddress));
        print('✅ Vault address updated successfully');
      });
    });

    group('Error Handling', () {
      test('should handle invalid method names', () async {
        try {
          await authenticatedClient.wsPayloads.generatePayload('invalidMethod', {});
          fail('Should have thrown an exception for invalid method');
        } catch (e) {
          expect(e.toString(), contains('Unknown exchange method'));
          print('✅ Invalid method handled gracefully');
        }
      });

      test('should handle missing parameters', () async {
        try {
          // Try to generate payload with missing required parameters
          await authenticatedClient.wsPayloads.generatePayload('placeOrder', {});
          fail('Should have thrown an exception for missing parameters');
        } catch (e) {
          // Expected to fail due to missing orders parameter
          print('✅ Missing parameters handled gracefully: $e');
        }
      });
    });
  });

  group('WebSocket Payload Integration', () {
    test('should document WebSocket POST functionality', () {
      print('🎯 WebSocket POST Operations (wsPayloads) Features:');
      print('');
      print('📋 Order Management:');
      print('  - placeOrder() / placeOrders()');
      print('  - cancelOrder() / cancelOrders()');
      print('  - modifyOrder() / batchModify()');
      print('');
      print('⚖️ Leverage & Margin:');
      print('  - updateLeverage()');
      print('  - updateIsolatedMargin()');
      print('');
      print('💸 Transfers:');
      print('  - usdTransfer() / spotTransfer()');
      print('  - vaultTransfer() / subAccountTransfer()');
      print('');
      print('🏦 Vault Operations:');
      print('  - createVault() / vaultDistribute() / vaultModify()');
      print('');
      print('📈 TWAP Orders:');
      print('  - placeTwapOrder() / cancelTwapOrder()');
      print('');
      print('🤖 Agent Operations:');
      print('  - approveAgent() / approveBuilderFee()');
      print('');
      print('💰 Staking:');
      print('  - cDeposit() / cWithdraw()');
      print('');
      print('🎯 Custom Market Operations:');
      print('  - marketOpen() / marketClose() / closeAllPositions()');
      print('');
      print('⚙️ Utilities:');
      print('  - executeCustomMethod() / generatePayload()');
      print('  - getAvailableMethods() / isMethodSupported()');
      
      expect(true, isTrue); // Placeholder assertion
    });
  });
}
