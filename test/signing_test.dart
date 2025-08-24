import 'package:test/test.dart';
import 'package:hyperliquid/src/utils/signing.dart';

void main() {
  test('floatToWire enforces precision and strips zeros', () {
    expect(floatToWire(1), '1');
    expect(floatToWire(1.2300000), '1.23');
  });

  test('removeTrailingZeros works', () {
    expect(removeTrailingZeros('1.2300'), '1.23');
    expect(removeTrailingZeros('2.000'), '2');
  });

  test('orderTypeToWire limit', () {
    final wire = orderTypeToWire(<String, dynamic>{'limit': <String, dynamic>{}});
    expect(wire.containsKey('limit'), isTrue);
  });

  test('orderToWire builds structure', () {
    final wire = orderToWire(<String, dynamic>{
      'coin': 'BTC',
      'is_buy': true,
      'limit_px': 35000,
      'sz': 0.01,
      'reduce_only': false,
      'order_type': <String, dynamic>{'limit': <String, dynamic>{}}
    }, 5);
    expect(wire['a'], 5);
    expect(wire['b'], true);
    expect(wire['p'], '35000');
  });
}
