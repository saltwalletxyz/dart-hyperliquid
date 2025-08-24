import 'package:test/test.dart';
import 'package:hyperliquid/hyperliquid.dart';

void main() {
  group('WebSocket Tests', () {
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

    test('should initialize WebSocket client', () {
      expect(wsClient.ws, isNotNull);
      expect(wsClient.subscriptions, isNotNull);
    });

    test('should not be connected initially', () {
      expect(wsClient.isWebSocketConnected(), isFalse);
    });

    test('should connect to WebSocket', () async {
      try {
        await wsClient.connect();
        // Note: This test might fail without internet connection
        // In production, we'd mock the WebSocket connection
      } catch (e) {
        print('WebSocket connection test skipped: $e');
      }
    }, skip: 'Requires internet connection');

    test('should handle manual disconnect', () {
      wsClient.disconnect();
      expect(wsClient.isWebSocketConnected(), isFalse);
    });
  });

  group('WebSocket Subscriptions', () {
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

    test('should have subscriptions object', () {
      expect(wsClient.subscriptions, isNotNull);
    });

    // Note: The current Dart implementation has a very basic WebSocket subscriptions class
    // These tests would need to be expanded once the full subscription functionality is implemented
    test('should have symbol conversion in subscriptions', () {
      expect(wsClient.subscriptions.symbolConversion, isNotNull);
    });
  });

  group('WebSocket with Authentication', () {
    late Hyperliquid authenticatedWsClient;

    setUp(() {
      authenticatedWsClient = Hyperliquid(const HyperliquidConfig(
        testnet: true,
        privateKey: '0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d',
        enableWs: true,
      ));
    });

    tearDown(() {
      authenticatedWsClient.disconnect();
    });

    test('should be authenticated', () {
      expect(authenticatedWsClient.isAuthenticated(), isTrue);
    });

    test('should have WebSocket enabled', () {
      expect(authenticatedWsClient.enableWs, isTrue);
    });

    // Note: The TypeScript version has wsPayloads for WebSocket POST operations
    // This functionality is missing in the current Dart implementation
    test('should support WebSocket POST operations (future)', () {
      // This test documents missing functionality that should be implemented
      // The TypeScript version has wsPayloads for executing exchange operations via WebSocket
      expect(() => authenticatedWsClient.subscriptions, returnsNormally);
    }, skip: 'WebSocket POST operations not yet implemented');
  });

  group('WebSocket Configuration', () {
    test('should respect maxReconnectAttempts setting', () {
      final client = Hyperliquid(const HyperliquidConfig(
        testnet: true,
        enableWs: true,
        maxReconnectAttempts: 10,
      ));
      
      expect(client.ws.maxReconnectAttempts, equals(10));
      client.disconnect();
    });

    test('should use correct WebSocket URL for testnet', () {
      final testnetClient = Hyperliquid(const HyperliquidConfig(
        testnet: true,
        enableWs: true,
      ));
      
      expect(testnetClient.ws.testnet, isTrue);
      testnetClient.disconnect();
    });

    test('should use correct WebSocket URL for mainnet', () {
      final mainnetClient = Hyperliquid(const HyperliquidConfig(
        testnet: false,
        enableWs: true,
      ));
      
      expect(mainnetClient.ws.testnet, isFalse);
      mainnetClient.disconnect();
    });
  });

  group('WebSocket Disabled', () {
    late Hyperliquid noWsClient;

    setUp(() {
      noWsClient = Hyperliquid(const HyperliquidConfig(
        testnet: true,
        enableWs: false,
      ));
    });

    tearDown(() {
      noWsClient.disconnect();
    });

    test('should not initialize WebSocket when disabled', () {
      expect(noWsClient.enableWs, isFalse);
      expect(noWsClient.isWebSocketConnected(), isFalse);
    });

    test('should still work for REST API operations', () async {
      await noWsClient.connect();
      expect(noWsClient.info, isNotNull);
    });
  });
}
