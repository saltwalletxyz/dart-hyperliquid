import 'package:test/test.dart';
import 'package:hyperliquid/src/rest/exchange_api.dart';
import 'package:hyperliquid/src/utils/rate_limiter.dart';
import 'package:hyperliquid/src/utils/symbol_conversion.dart';
import 'package:hyperliquid/src/hyperliquid_base.dart';

// Minimal stub to access private nonce via placeOrder payload builder

void main() {
  test('unique nonce monotonicity', () {
    final ex = _NonceTester();
    final n1 = ex.next();
    final n2 = ex.next();
    expect(n2 >= n1, isTrue);
  });
}

class _DummyHyperliquid extends Hyperliquid {
  _DummyHyperliquid() : super(const HyperliquidConfig(enableWs: false));
  @override
  Future<void> ensureInitialized() async {}
}

class _NonceTester extends ExchangeAPI {
  _NonceTester()
      : super(true, '0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d', null, RateLimiter(),
            SymbolConversion('http://localhost', RateLimiter(), true, 60000), null, _DummyHyperliquid(), null);
  int next() => testNextNonce();
}
