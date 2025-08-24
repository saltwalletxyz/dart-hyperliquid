# Production Deployment Guide

This guide covers best practices for deploying the Hyperliquid Dart SDK in production environments.

## Table of Contents

- [Security Configuration](#security-configuration)
- [Environment Setup](#environment-setup)
- [Error Handling & Monitoring](#error-handling--monitoring)
- [Performance Optimization](#performance-optimization)
- [Logging & Observability](#logging--observability)
- [Testing Strategy](#testing-strategy)
- [Deployment Checklist](#deployment-checklist)

## Security Configuration

### Private Key Management

**❌ Never do this:**
```dart
// DON'T hardcode private keys
final client = Hyperliquid(HyperliquidConfig(
  privateKey: '0x1234567890abcdef...', // NEVER!
));
```

**✅ Best practices:**
```dart
// Use environment variables
final privateKey = Platform.environment['HYPERLIQUID_PRIVATE_KEY'];
if (privateKey == null) {
  throw Exception('HYPERLIQUID_PRIVATE_KEY environment variable not set');
}

final client = Hyperliquid(HyperliquidConfig(
  privateKey: privateKey,
  testnet: false, // Production
));
```

### Security Configuration

```dart
// Configure strict security settings
client.security.updateConfiguration(
  strictValidation: true,
  enableRateLimiting: true,
  logSecurityEvents: true,
);

// Validate all trading parameters
await client.security.validateTradingParameters(
  symbol: symbol,
  size: size,
  price: price,
  leverage: leverage,
  slippage: slippage,
);
```

### Input Validation

```dart
// Always sanitize user inputs
final sanitizedSymbol = client.security.sanitizeInput(userSymbol);

// Validate amounts with proper bounds
final validation = SecurityValidator.validateTradingAmount(
  amount,
  minAmount: 0.001,
  maxAmount: 1000.0,
);

if (!validation.isValid) {
  throw ValidationException(validation.message);
}
```

## Environment Setup

### Environment Variables

Create a `.env` file for local development:

```bash
# Hyperliquid Configuration
HYPERLIQUID_PRIVATE_KEY=0x...
HYPERLIQUID_TESTNET=false
HYPERLIQUID_MAX_RETRIES=5
HYPERLIQUID_RATE_LIMIT=1000

# Logging Configuration
LOG_LEVEL=info
LOG_FILE_PATH=/var/log/hyperliquid/app.log
ENABLE_STRUCTURED_LOGGING=true

# Monitoring
ENABLE_METRICS=true
METRICS_PORT=9090
```

### Docker Configuration

```dockerfile
FROM dart:stable AS build

WORKDIR /app
COPY pubspec.* ./
RUN dart pub get

COPY . .
RUN dart compile exe bin/main.dart -o bin/app

FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/app /app/bin/

# Security: Run as non-root user
USER 1001

EXPOSE 8080
ENTRYPOINT ["/app/bin/app"]
```

### Kubernetes Deployment

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hyperliquid-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: hyperliquid-app
  template:
    metadata:
      labels:
        app: hyperliquid-app
    spec:
      containers:
      - name: app
        image: your-registry/hyperliquid-app:latest
        env:
        - name: HYPERLIQUID_PRIVATE_KEY
          valueFrom:
            secretKeyRef:
              name: hyperliquid-secrets
              key: private-key
        - name: LOG_LEVEL
          value: "info"
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
        livenessProbe:
          httpGet:
            path: /health
            port: 8080
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /ready
            port: 8080
          initialDelaySeconds: 5
          periodSeconds: 5
```

## Error Handling & Monitoring

### Comprehensive Error Handling

```dart
class ProductionErrorHandler {
  final ErrorHandler errorHandler;
  final StructuredLogger logger;
  
  ProductionErrorHandler(this.errorHandler, this.logger) {
    // Configure for production
    errorHandler.updateConfiguration(
      enableAutoRecovery: true,
      maxRetryAttempts: 5,
      baseRetryDelay: Duration(seconds: 2),
    );
  }
  
  Future<T> executeWithRetry<T>(
    String operation,
    Future<T> Function() action, {
    Map<String, dynamic>? context,
  }) async {
    return await errorHandler.handleError(
      operation,
      action,
      context: context,
      enableRetry: true,
    );
  }
  
  void handleCriticalError(String operation, dynamic error, StackTrace stackTrace) {
    logger.fatal('Critical error in $operation', error, stackTrace, {
      'operation': operation,
      'timestamp': DateTime.now().toIso8601String(),
      'severity': 'critical',
    });
    
    // Send alert to monitoring system
    _sendAlert(operation, error);
  }
  
  void _sendAlert(String operation, dynamic error) {
    // Implement your alerting logic here
    // e.g., send to Slack, PagerDuty, etc.
  }
}
```

### Circuit Breaker Pattern

```dart
class CircuitBreaker {
  final int failureThreshold;
  final Duration timeout;
  int _failureCount = 0;
  DateTime? _lastFailureTime;
  bool _isOpen = false;
  
  CircuitBreaker({
    this.failureThreshold = 5,
    this.timeout = const Duration(minutes: 1),
  });
  
  Future<T> execute<T>(Future<T> Function() action) async {
    if (_isOpen) {
      if (DateTime.now().difference(_lastFailureTime!) > timeout) {
        _isOpen = false;
        _failureCount = 0;
      } else {
        throw CircuitBreakerOpenException();
      }
    }
    
    try {
      final result = await action();
      _failureCount = 0;
      return result;
    } catch (e) {
      _failureCount++;
      _lastFailureTime = DateTime.now();
      
      if (_failureCount >= failureThreshold) {
        _isOpen = true;
      }
      
      rethrow;
    }
  }
}
```

## Performance Optimization

### Connection Pooling

```dart
class HyperliquidConnectionPool {
  final List<Hyperliquid> _connections = [];
  final int maxConnections;
  int _currentIndex = 0;
  
  HyperliquidConnectionPool({this.maxConnections = 5});
  
  Future<void> initialize(HyperliquidConfig config) async {
    for (int i = 0; i < maxConnections; i++) {
      final client = Hyperliquid(config);
      await client.connect();
      _connections.add(client);
    }
  }
  
  Hyperliquid getConnection() {
    final connection = _connections[_currentIndex];
    _currentIndex = (_currentIndex + 1) % _connections.length;
    return connection;
  }
  
  void dispose() {
    for (final connection in _connections) {
      connection.disconnect();
    }
    _connections.clear();
  }
}
```

### Caching Strategy

```dart
class MarketDataCache {
  final Map<String, CacheEntry> _cache = {};
  final Duration cacheTtl;
  
  MarketDataCache({this.cacheTtl = const Duration(seconds: 30)});
  
  Future<Map<String, String>> getAllMids(Hyperliquid client) async {
    const key = 'all_mids';
    final entry = _cache[key];
    
    if (entry != null && !entry.isExpired) {
      return entry.data as Map<String, String>;
    }
    
    final data = await client.info.getAllMids();
    _cache[key] = CacheEntry(data, DateTime.now().add(cacheTtl));
    
    return data;
  }
}

class CacheEntry {
  final dynamic data;
  final DateTime expiresAt;
  
  CacheEntry(this.data, this.expiresAt);
  
  bool get isExpired => DateTime.now().isAfter(expiresAt);
}
```

## Logging & Observability

### Production Logging Configuration

```dart
final logger = StructuredLogger(
  serviceName: 'hyperliquid-trading-bot',
  version: '1.0.0',
  logLevel: Level.info,
  enableFileLogging: true,
  logFilePath: '/var/log/hyperliquid/app.log',
  enableStructuredOutput: true,
);

// Add global context
logger.addGlobalContext({
  'environment': 'production',
  'region': 'us-east-1',
  'instance_id': Platform.environment['INSTANCE_ID'],
});
```

### Metrics Collection

```dart
class MetricsCollector {
  final Map<String, int> _counters = {};
  final Map<String, List<double>> _histograms = {};
  
  void incrementCounter(String name, [Map<String, String>? labels]) {
    final key = _buildKey(name, labels);
    _counters[key] = (_counters[key] ?? 0) + 1;
  }
  
  void recordDuration(String name, Duration duration, [Map<String, String>? labels]) {
    final key = _buildKey(name, labels);
    _histograms.putIfAbsent(key, () => []).add(duration.inMilliseconds.toDouble());
  }
  
  String _buildKey(String name, Map<String, String>? labels) {
    if (labels == null || labels.isEmpty) return name;
    final labelStr = labels.entries.map((e) => '${e.key}=${e.value}').join(',');
    return '$name{$labelStr}';
  }
  
  Map<String, dynamic> getMetrics() {
    return {
      'counters': _counters,
      'histograms': _histograms.map((k, v) => MapEntry(k, {
        'count': v.length,
        'sum': v.reduce((a, b) => a + b),
        'avg': v.reduce((a, b) => a + b) / v.length,
        'min': v.reduce((a, b) => a < b ? a : b),
        'max': v.reduce((a, b) => a > b ? a : b),
      })),
    };
  }
}
```

## Testing Strategy

### Integration Tests

```dart
@TestOn('vm')
void main() {
  group('Production Integration Tests', () {
    late Hyperliquid client;
    
    setUpAll(() async {
      client = Hyperliquid(HyperliquidConfig(
        privateKey: Platform.environment['TEST_PRIVATE_KEY']!,
        testnet: true,
      ));
      await client.connect();
    });
    
    tearDownAll(() {
      client.disconnect();
    });
    
    test('should handle high-frequency requests', () async {
      final futures = List.generate(100, (i) => 
        client.info.getAllMids()
      );
      
      final results = await Future.wait(futures);
      expect(results.length, equals(100));
    });
    
    test('should recover from network failures', () async {
      // Simulate network failure and recovery
      // Implementation depends on your testing setup
    });
  });
}
```

### Load Testing

```dart
class LoadTester {
  final Hyperliquid client;
  final MetricsCollector metrics;
  
  LoadTester(this.client, this.metrics);
  
  Future<void> runLoadTest({
    required int concurrentUsers,
    required Duration duration,
    required int requestsPerSecond,
  }) async {
    final stopwatch = Stopwatch()..start();
    final futures = <Future>[];
    
    while (stopwatch.elapsed < duration) {
      for (int i = 0; i < concurrentUsers; i++) {
        futures.add(_simulateUser());
      }
      
      await Future.delayed(Duration(milliseconds: 1000 ~/ requestsPerSecond));
    }
    
    await Future.wait(futures);
    
    print('Load test completed:');
    print('Metrics: ${metrics.getMetrics()}');
  }
  
  Future<void> _simulateUser() async {
    final start = DateTime.now();
    
    try {
      await client.info.getAllMids();
      metrics.incrementCounter('requests_success');
    } catch (e) {
      metrics.incrementCounter('requests_error');
    } finally {
      metrics.recordDuration('request_duration', DateTime.now().difference(start));
    }
  }
}
```

## Deployment Checklist

### Pre-deployment

- [ ] All tests pass (unit, integration, load)
- [ ] Security audit completed
- [ ] Private keys stored securely
- [ ] Environment variables configured
- [ ] Monitoring and alerting set up
- [ ] Backup and recovery procedures tested
- [ ] Rate limiting configured appropriately
- [ ] Error handling tested with various failure scenarios

### Deployment

- [ ] Deploy to staging environment first
- [ ] Run smoke tests in staging
- [ ] Monitor logs and metrics
- [ ] Gradual rollout (blue-green or canary)
- [ ] Monitor error rates and performance
- [ ] Verify all integrations working

### Post-deployment

- [ ] Monitor application health
- [ ] Check error rates and response times
- [ ] Verify trading operations working correctly
- [ ] Monitor security events
- [ ] Set up regular health checks
- [ ] Document any issues and resolutions

### Monitoring Alerts

Set up alerts for:
- High error rates (>5%)
- Slow response times (>2s)
- Security events
- Rate limit violations
- WebSocket disconnections
- Memory/CPU usage spikes
- Failed authentication attempts

## Support and Maintenance

### Regular Maintenance Tasks

1. **Weekly:**
   - Review error logs and metrics
   - Check security event logs
   - Verify backup procedures

2. **Monthly:**
   - Update dependencies
   - Review and rotate API keys
   - Performance optimization review

3. **Quarterly:**
   - Security audit
   - Disaster recovery testing
   - Capacity planning review

### Emergency Procedures

1. **Service Outage:**
   - Check application logs
   - Verify network connectivity
   - Check Hyperliquid API status
   - Implement circuit breaker if needed

2. **Security Incident:**
   - Immediately rotate compromised keys
   - Review security logs
   - Implement additional monitoring
   - Document incident and response

3. **Performance Issues:**
   - Check resource utilization
   - Review recent deployments
   - Implement rate limiting
   - Scale horizontally if needed

---

For additional support, please refer to the main documentation or contact the development team.
