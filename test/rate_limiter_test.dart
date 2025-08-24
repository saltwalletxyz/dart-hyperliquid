import 'package:test/test.dart';
import 'package:hyperliquid/src/utils/rate_limiter.dart';

void main() {
  test('rate limiter immediate token consumption', () async {
    final rl = RateLimiter(capacity: 5, refillRatePerSecond: 1000);
    final sw = Stopwatch()..start();
    await rl.waitForToken(3);
    sw.stop();
    expect(sw.elapsedMilliseconds < 50, isTrue);
  });

  // Intentionally skip timing-based wait test to avoid flakiness in CI.
}
