class RateLimiter {
  final int capacity;
  final double refillRatePerSecond;

  double _tokens;
  int _lastRefillMs;

  RateLimiter({this.capacity = 100, this.refillRatePerSecond = 10})
      : _tokens = 100,
        _lastRefillMs = DateTime.now().millisecondsSinceEpoch;

  void _refill() {
    final now = DateTime.now().millisecondsSinceEpoch;
    final elapsedSeconds = (now - _lastRefillMs) / 1000.0;
    if (elapsedSeconds <= 0) return;
    final newTokens = elapsedSeconds * refillRatePerSecond;
    _tokens = (_tokens + newTokens).clamp(0, capacity.toDouble());
    _lastRefillMs = now;
  }

  Future<void> waitForToken([int weight = 1]) async {
    _refill();
    if (_tokens >= weight) {
      _tokens -= weight;
      return;
    }
    final tokensNeeded = weight - _tokens;
    final waitSeconds = tokensNeeded / refillRatePerSecond;
    final waitMs = (waitSeconds * 1000).ceil();
    await Future<void>.delayed(Duration(milliseconds: waitMs));
    return waitForToken(weight);
  }

  // Backwards-compatible API used by older code in this repo
  Future<void> wait([int weight = 1]) => waitForToken(weight);
}
