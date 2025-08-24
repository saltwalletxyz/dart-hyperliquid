import 'package:test/test.dart';
import 'package:hyperliquid/src/utils/symbol_conversion.dart';
import 'package:hyperliquid/src/utils/rate_limiter.dart';

void main() {
  test('symbol conversion returns mapping if provided manually', () async {
    final sc = SymbolConversion('http://localhost', RateLimiter(), true, 60000);
    sc.registerTestAsset('BTC', 'BTC-PERP', 1);
    final converted = await sc.convertSymbol('BTC');
    expect(converted, 'BTC-PERP');
  });
  test('reverse mode returns original exchange name', () async {
    final sc = SymbolConversion('http://localhost', RateLimiter(), true, 60000);
    sc.registerTestAsset('ETH', 'ETH-PERP', 2);
    final reverse = await sc.convertSymbol('ETH-PERP', 'reverse');
    expect(reverse, 'ETH');
  });
}
