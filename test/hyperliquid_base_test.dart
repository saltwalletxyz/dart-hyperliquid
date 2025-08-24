import 'package:test/test.dart';
import 'package:hyperliquid/hyperliquid.dart';

void main() {
  group('Hyperliquid Base Tests', () {
    late Hyperliquid client;

    setUp(() {
      client = Hyperliquid(const HyperliquidConfig(
        testnet: true,
        enableWs: false, // Disable WebSocket for basic tests
      ));
    });

    tearDown(() {
      client.disconnect();
    });

    test('should initialize with default config', () {
      expect(client.testnet, isTrue);
      expect(client.enableWs, isFalse);
      expect(client.isAuthenticated(), isFalse);
    });

    test('should initialize with private key', () {
      final authenticatedClient = Hyperliquid(const HyperliquidConfig(
        testnet: true,
        privateKey: '0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d',
        enableWs: false,
      ));

      expect(authenticatedClient.isAuthenticated(), isTrue);
      authenticatedClient.disconnect();
    });

    test('should have correct base URL for testnet', () {
      expect(client.getBaseUrl(), contains('testnet'));
    });

    test('should have correct base URL for mainnet', () {
      final mainnetClient = Hyperliquid(const HyperliquidConfig(
        testnet: false,
        enableWs: false,
      ));

      expect(mainnetClient.getBaseUrl(), isNot(contains('testnet')));
      mainnetClient.disconnect();
    });

    test('should initialize rate limiter', () {
      expect(client.getRateLimiter(), isNotNull);
    });

    test('should handle asset map refresh controls', () async {
      // Initially, refresh is enabled but timer might not be started yet
      await client.connect(); // This will initialize the symbol conversion

      client.disableAssetMapRefresh();
      expect(client.isAssetMapRefreshEnabled(), isFalse);

      client.enableAssetMapRefresh();
      // After enabling, it should be enabled (though timer might not be active without initialization)
    });

    test('should allow setting asset map refresh interval', () {
      const newInterval = 30000;
      client.setAssetMapRefreshInterval(newInterval);
      expect(client.getAssetMapRefreshInterval(), equals(newInterval));
    });

    test('should connect and initialize properly', () async {
      await client.connect();
      expect(client.isWebSocketConnected(), isFalse); // WS disabled
    });
  });

  group('Hyperliquid WebSocket Tests', () {
    late Hyperliquid wsClient;

    setUp(() {
      wsClient = Hyperliquid(const HyperliquidConfig(
        testnet: true,
        enableWs: true,
      ));
    });

    tearDown(() {
      wsClient.disconnect();
    });

    test('should initialize with WebSocket enabled', () {
      expect(wsClient.enableWs, isTrue);
    });

    test('should connect WebSocket', () async {
      await wsClient.connect();
      // Note: This might fail if no internet connection
      // In a real test environment, we'd mock the WebSocket
    }, skip: 'Requires internet connection');
  });
}
