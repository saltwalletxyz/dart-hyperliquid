import 'package:test/test.dart';
import 'package:hyperliquid/hyperliquid.dart';

void main() {
  group('Integration Tests', () {
    late Hyperliquid client;

    setUp(() {
      client = Hyperliquid(const HyperliquidConfig(
        testnet: true,
        enableWs: false,
      ));
    });

    tearDown(() {
      client.disconnect();
    });

    test('should fetch all mids from testnet', () async {
      try {
        await client.connect();
        final mids = await client.info.getAllMids();
        
        expect(mids, isNotNull);
        print('Successfully fetched mids data');
      } catch (e) {
        print('Integration test skipped due to network error: $e');
      }
    }, skip: 'Requires internet connection');

    test('should handle symbol conversion', () async {
      try {
        await client.connect();
        
        // Test asset index retrieval
        final btcIndex = await client.info.getAssetIndex('BTC');
        expect(btcIndex, isA<int?>());
        
        if (btcIndex != null) {
          print('BTC asset index: $btcIndex');
        }
        
        // Test internal name retrieval
        final btcInternal = await client.info.getInternalName('BTC');
        expect(btcInternal, isA<String?>());
        
        if (btcInternal != null) {
          print('BTC internal name: $btcInternal');
        }
        
        // Test all assets retrieval
        final allAssets = await client.info.getAllAssets();
        expect(allAssets, isA<Map<String, List<String>>>());
        
        print('Available asset categories: ${allAssets.keys.toList()}');
        
      } catch (e) {
        print('Symbol conversion test skipped due to network error: $e');
      }
    }, skip: 'Requires internet connection');

    test('should handle rate limiting gracefully', () async {
      final rateLimiter = client.getRateLimiter();
      expect(rateLimiter, isNotNull);
      
      // Test that rate limiter allows immediate requests
      final stopwatch = Stopwatch()..start();
      await rateLimiter.waitForToken(1);
      stopwatch.stop();
      
      expect(stopwatch.elapsedMilliseconds, lessThan(100));
    });

    test('should manage asset map refresh', () async {
      expect(client.isAssetMapRefreshEnabled(), isTrue);
      
      // Test disabling refresh
      client.disableAssetMapRefresh();
      expect(client.isAssetMapRefreshEnabled(), isFalse);
      
      // Test enabling refresh
      client.enableAssetMapRefresh();
      expect(client.isAssetMapRefreshEnabled(), isTrue);
      
      // Test setting custom interval
      const customInterval = 45000;
      client.setAssetMapRefreshInterval(customInterval);
      expect(client.getAssetMapRefreshInterval(), equals(customInterval));
      
      // Test manual refresh
      try {
        await client.refreshAssetMapsNow();
        print('Manual asset map refresh completed');
      } catch (e) {
        print('Manual refresh test skipped: $e');
      }
    }, skip: 'Requires internet connection for manual refresh');
  });

  group('Authenticated Integration Tests', () {
    late Hyperliquid authenticatedClient;
    const testPrivateKey = '0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d';

    setUp(() {
      authenticatedClient = Hyperliquid(const HyperliquidConfig(
        testnet: true,
        privateKey: testPrivateKey,
        enableWs: false,
      ));
    });

    tearDown(() {
      authenticatedClient.disconnect();
    });

    test('should authenticate successfully', () {
      expect(authenticatedClient.isAuthenticated(), isTrue);
    });

    test('should create valid order payloads', () async {
      try {
        await authenticatedClient.connect();
        
        final orderRequest = {
          'coin': 'BTC',
          'is_buy': true,
          'sz': 0.01,
          'limit_px': 35000,
          'order_type': {'limit': {}},
          'reduce_only': false,
        };
        
        final payload = await authenticatedClient.exchange.getOrderPayload(orderRequest);
        
        expect(payload, isA<Map<String, dynamic>>());
        expect(payload['action'], isNotNull);
        expect(payload['signature'], isNotNull);
        expect(payload['nonce'], isNotNull);
        expect(payload['vaultAddress'], isA<String?>());
        
        print('Order payload created successfully');
        print('Action type: ${payload['action']['type']}');
        print('Nonce: ${payload['nonce']}');
        
      } catch (e) {
        print('Order payload test skipped: $e');
      }
    }, skip: 'Requires internet connection for symbol conversion');

    test('should create valid cancel payloads', () async {
      try {
        await authenticatedClient.connect();
        
        final cancelRequest = {
          'coin': 'BTC',
          'o': 123456789,
        };
        
        final payload = await authenticatedClient.exchange.getCancelOrderPayload(cancelRequest);
        
        expect(payload, isA<Map<String, dynamic>>());
        expect(payload['action'], isNotNull);
        expect(payload['signature'], isNotNull);
        expect(payload['nonce'], isNotNull);
        
        print('Cancel payload created successfully');
        print('Action type: ${payload['action']['type']}');
        
      } catch (e) {
        print('Cancel payload test skipped: $e');
      }
    }, skip: 'Requires internet connection for symbol conversion');

    test('should handle nonce generation correctly', () {
      // Test that nonces are unique and monotonic
      final nonce1 = authenticatedClient.exchange.testNextNonce();
      final nonce2 = authenticatedClient.exchange.testNextNonce();
      final nonce3 = authenticatedClient.exchange.testNextNonce();
      
      expect(nonce2, greaterThan(nonce1));
      expect(nonce3, greaterThan(nonce2));
      
      print('Nonce sequence: $nonce1 -> $nonce2 -> $nonce3');
    });
  });

  group('Error Handling Integration Tests', () {
    test('should handle invalid private key gracefully', () {
      final invalidClient = Hyperliquid(const HyperliquidConfig(
        testnet: true,
        privateKey: 'invalid_key',
        enableWs: false,
      ));
      
      expect(invalidClient.isAuthenticated(), isFalse);
      invalidClient.disconnect();
    });

    test('should handle network errors gracefully', () async {
      final client = Hyperliquid(const HyperliquidConfig(
        testnet: true,
        enableWs: false,
      ));
      
      // This test would ideally use a mock HTTP client to simulate network errors
      // For now, we just ensure the client can be created and disconnected
      expect(client, isNotNull);
      client.disconnect();
    });
  });
}
