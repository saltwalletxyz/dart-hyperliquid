/// Advanced rate limiter with request weight management and statistics
class RateLimiter {
  RateLimiter({this.capacity = 100, this.refillRatePerSecond = 10})
      : _tokens = capacity.toDouble(),
        _lastRefillMs = DateTime.now().millisecondsSinceEpoch;
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
    final recentRequests = _requestHistory
        .where((time) => now - time < 60000 // Last 60 seconds
            )
        .length;

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

  /// Get rate limiting health status
  Map<String, dynamic> getHealthStatus() {
    _refill();
    final utilizationPercent = ((capacity - _tokens) / capacity * 100).round();
    final recentRequestsPerMinute = _requestHistory.where((time) => DateTime.now().millisecondsSinceEpoch - time < 60000).length;

    String status;
    if (utilizationPercent >= 90) {
      status = 'CRITICAL';
    } else if (utilizationPercent >= 75) {
      status = 'WARNING';
    } else if (utilizationPercent >= 50) {
      status = 'MODERATE';
    } else {
      status = 'HEALTHY';
    }

    return {
      'status': status,
      'utilizationPercent': utilizationPercent,
      'availableTokens': _tokens,
      'recentRequestsPerMinute': recentRequestsPerMinute,
      'waitEvents': _waitEvents,
      'isThrottling': _waitEvents > 0,
    };
  }

  /// Get rate limiting recommendations
  List<String> getRecommendations() {
    final health = getHealthStatus();
    final recommendations = <String>[];

    if (health['status'] == 'CRITICAL') {
      recommendations.add('Rate limit usage is critical. Consider reducing request frequency.');
      recommendations.add('Implement request batching to reduce API calls.');
      recommendations.add('Consider upgrading to a paid plan if available.');
    } else if (health['status'] == 'WARNING') {
      recommendations.add('Rate limit usage is high. Monitor closely.');
      recommendations.add('Consider implementing request queuing.');
    }

    final waitEvents = (health['waitEvents'] as num?)?.toInt() ?? 0;
    if (waitEvents > 10) {
      recommendations.add('Frequent wait events detected. Introduce delays between requests.');
    } else if (waitEvents > 0) {
      recommendations.add('Some wait events detected. Optimize request patterns.');
    }

    final recentRequestsPerMinute = (health['recentRequestsPerMinute'] as num?)?.toInt() ?? 0;
    if (recentRequestsPerMinute > (capacity * 0.8).round()) {
      recommendations.add('High request rate detected. Consider spreading out requests.');
    }
    //

    return recommendations;
  }

  /// Get detailed performance metrics
  Map<String, dynamic> getPerformanceMetrics() {
    _refill();

    final now = DateTime.now().millisecondsSinceEpoch;
    final lastHourRequests = _requestHistory.where((time) => now - time < 3600000).length;
    final lastMinuteRequests = _requestHistory.where((time) => now - time < 60000).length;
    final last10SecondsRequests = _requestHistory.where((time) => now - time < 10000).length;

    final avgRequestWeight = _totalRequests > 0 ? _totalWeight / _totalRequests : 0.0;
    final waitRatio = _totalRequests > 0 ? _waitEvents / _totalRequests : 0.0;

    return {
      'requestsPerHour': lastHourRequests,
      'requestsPerMinute': lastMinuteRequests,
      'requestsPer10Seconds': last10SecondsRequests,
      'averageRequestWeight': avgRequestWeight,
      'waitEventRatio': waitRatio,
      'efficiency': 1.0 - waitRatio,
      'peakUtilizationPercent': ((capacity - _tokens) / capacity * 100).round(),
    };
  }

  /// Check if rate limiter is in a good state for high-frequency operations
  bool isReadyForHighFrequency() {
    final health = getHealthStatus();
    final status = health['status'] as String? ?? '';
    final utilizationPercent = (health['utilizationPercent'] as num?)?.toInt() ?? 0;
    return status == 'HEALTHY' && utilizationPercent < 30;
  }

  /// Get estimated time until next token availability
  Duration getTimeUntilNextToken() {
    _refill();
    if (_tokens >= 1) return Duration.zero;

    final tokensNeeded = 1 - _tokens;
    final secondsNeeded = tokensNeeded / refillRatePerSecond;
    return Duration(milliseconds: (secondsNeeded * 1000).round());
  }

  /// Get burst capacity information
  Map<String, dynamic> getBurstCapacity() {
    _refill();
    final availableBurst = _tokens.floor();
    final timeForFullRefill = Duration(milliseconds: ((capacity - _tokens) / refillRatePerSecond * 1000).round());

    return {
      'availableBurstRequests': availableBurst,
      'timeForFullCapacity': timeForFullRefill,
      'canHandleBurst': availableBurst >= 10, // Arbitrary threshold for "burst"
    };
  }

  // Backwards-compatible API used by older code in this repo
  Future<void> wait([int weight = 1]) => waitForToken(weight);
}
