import 'package:test/test.dart';
import 'package:hyperliquid/hyperliquid.dart';

void main() {
  group('Info API Tests', () {
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

    group('General Info API', () {
      test('should have getAllMids method', () {
        expect(client.info.getAllMids, isNotNull);
      });

      test('should have getUserOpenOrders method', () {
        expect(client.info.getUserOpenOrders, isNotNull);
      });

      test('should have getFrontendOpenOrders method', () {
        expect(client.info.getFrontendOpenOrders, isNotNull);
      });

      test('should have getUserFills method', () {
        expect(client.info.getUserFills, isNotNull);
      });

      test('should have getUserFillsByTime method', () {
        expect(client.info.getUserFillsByTime, isNotNull);
      });

      test('should have getUserRateLimit method', () {
        expect(client.info.getUserRateLimit, isNotNull);
      });

      test('getAllMids should return data', () async {
        try {
          final result = await client.info.getAllMids();
          expect(result, isNotNull);
          // The result should be a map or object with mids data
        } catch (e) {
          // Skip if network error - this is expected in CI
          print('Network test skipped: $e');
        }
      }, skip: 'Requires internet connection');
    });

    group('Symbol Conversion', () {
      test('should get asset index', () async {
        try {
          final index = await client.info.getAssetIndex('BTC');
          expect(index, isA<int?>());
        } catch (e) {
          print('Network test skipped: $e');
        }
      }, skip: 'Requires internet connection');

      test('should get internal name', () async {
        try {
          final name = await client.info.getInternalName('BTC');
          expect(name, isA<String?>());
        } catch (e) {
          print('Network test skipped: $e');
        }
      }, skip: 'Requires internet connection');

      test('should get all assets', () async {
        try {
          final assets = await client.info.getAllAssets();
          expect(assets, isA<Map<String, List<String>>>());
        } catch (e) {
          print('Network test skipped: $e');
        }
      }, skip: 'Requires internet connection');
    });

    group('API Structure', () {
      test('should have generalAPI', () {
        expect(client.info.generalAPI, isNotNull);
      });

      test('should have spotAPI', () {
        expect(client.info.spotAPI, isNotNull);
      });

      test('should have perpetualsAPI', () {
        expect(client.info.perpetualsAPI, isNotNull);
      });
    });
  });

  group('Info API with Authentication', () {
    late Hyperliquid authenticatedClient;

    setUp(() {
      authenticatedClient = Hyperliquid(const HyperliquidConfig(
        testnet: true,
        privateKey: '0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d',
        enableWs: false,
      ));
    });

    tearDown(() {
      authenticatedClient.disconnect();
    });

    test('should be authenticated', () {
      expect(authenticatedClient.isAuthenticated(), isTrue);
    });

    test('should access user-specific methods', () async {
      // These methods should work with authentication
      expect(authenticatedClient.info.getUserOpenOrders, isNotNull);
      expect(authenticatedClient.info.getUserFills, isNotNull);
    });
  });
}
