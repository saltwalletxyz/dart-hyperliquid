/// Advanced rate limiter with request weight management and statistics
class RateLimiter {
  final int capacity;
  final double refillRatePerSecond;
  
  // Request weight definitions for different API endpoints
  static const Map<String, int> _endpointWeights = {
    'info/allMids': 1,
    'info/openOrders': 1,
    'info/userFills': 1,
    'info/l2Book': 2,
    'info/candleSnapshot': 3,
    'info/leaderboard': 2,
    'info/liquidations': 2,
    'exchange/order': 1,
    'exchange/cancel': 1,
    'exchange/batchModify': 2,
    'exchange/usdTransfer': 3,
    'exchange/withdraw3': 5,
  };

  double _tokens;
  int _lastRefillMs;
  int _totalRequests = 0;
  int _totalWeight = 0;
  int _waitEvents = 0;
  final List<int> _requestHistory = [];

  RateLimiter({this.capacity = 100, this.refillRatePerSecond = 10})
      : _tokens = capacity.toDouble(),
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
    _totalRequests++;
    _totalWeight += weight;
    _requestHistory.add(DateTime.now().millisecondsSinceEpoch);
    
    // Keep only last 100 requests for history
    if (_requestHistory.length > 100) {
      _requestHistory.removeAt(0);
    }
    
    if (_tokens >= weight) {
      _tokens -= weight;
      return;
    }
    
    _waitEvents++;
    final tokensNeeded = weight - _tokens;
    final waitSeconds = tokensNeeded / refillRatePerSecond;
    final waitMs = (waitSeconds * 1000).ceil();
    await Future<void>.delayed(Duration(milliseconds: waitMs));
    return waitForToken(weight);
  }

  /// Wait for a specific endpoint with automatic weight calculation
  Future<void> waitForEndpoint(String endpoint) async {
    final weight = getWeightForEndpoint(endpoint);
    await waitForToken(weight);
  }

  /// Get the weight for a specific endpoint
  int getWeightForEndpoint(String endpoint) {
    return _endpointWeights[endpoint] ?? 1;
  }

  /// Reserve weight for a request without actually consuming tokens
  bool canReserveWeight(int weight) {
    _refill();
    return _tokens >= weight;
  }

  /// Get current rate limiting statistics
  Map<String, dynamic> getStatistics() {
    _refill();
    
    final now = DateTime.now().millisecondsSinceEpoch;
    final recentRequests = _requestHistory.where((time) => 
      now - time < 60000 // Last 60 seconds
    ).length;
    
    return {
      'currentTokens': _tokens,
      'capacity': capacity,
      'refillRate': refillRatePerSecond,
      'totalRequests': _totalRequests,
      'totalWeight': _totalWeight,
      'waitEvents': _waitEvents,
      'recentRequests': recentRequests,
      'utilizationPercent': ((capacity - _tokens) / capacity * 100).round(),
    };
  }

  /// Get available tokens
  double get availableTokens {
    _refill();
    return _tokens;
  }

  /// Check if the rate limiter is at capacity
  bool get isAtCapacity {
    _refill();
    return _tokens >= capacity;
  }

  /// Reset statistics (but not tokens)
  void resetStatistics() {
    _totalRequests = 0;
    _totalWeight = 0;
    _waitEvents = 0;
    _requestHistory.clear();
  }

  // Backwards-compatible API used by older code in this repo
  Future<void> wait([int weight = 1]) => waitForToken(weight);
}
