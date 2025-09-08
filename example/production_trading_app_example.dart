/// Production-Ready Hyperliquid Trading Application Example
///
/// This example demonstrates best practices for building a robust
/// trading application with the Hyperliquid Dart SDK.
///
/// Features:
/// - Environment-based configuration
/// - Comprehensive error handling
/// - Performance monitoring
/// - Security best practices
/// - Production logging
/// - Health checks
/// - Graceful shutdown
library;

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:hyperliquid/hyperliquid.dart';

/// Production trading application
class ProductionTradingApp {

  ProductionTradingApp({required this.config});
  final ProductionConfig config;
  late final Hyperliquid client;

  // Application state
  bool isRunning = false;
  DateTime startTime = DateTime.now();

  // Performance metrics
  int totalRequests = 0;
  int failedRequests = 0;
  int successfulTrades = 0;
  double totalVolume = 0;

  // Health monitoring
  Timer? healthCheckTimer;
  Timer? metricsTimer;
  Map<String, dynamic> lastHealthCheck = {};

  /// Initialize and start the application
  Future<void> start() async {
    print('🚀 Starting Production Trading Application...');
    print('Environment: ${config.environment}');
    print('Testnet: ${config.isTestnet}');

    try {
      await _initializeClient();
      await _startHealthChecks();
      await _startMetricsCollection();

      isRunning = true;
      startTime = DateTime.now();

      print('✅ Application started successfully');

      // Example trading operations
      await _runTradingExample();
    } catch (e, stackTrace) {
      print('❌ Failed to start application: $e');
      print('Stack trace: $stackTrace');
      await stop();
    }
  }

  /// Initialize Hyperliquid client with production settings
  Future<void> _initializeClient() async {
    final privateKey = Platform.environment['HYPERLIQUID_PRIVATE_KEY'];
    if (privateKey == null) {
      throw Exception('HYPERLIQUID_PRIVATE_KEY environment variable not set');
    }

    client = Hyperliquid(HyperliquidConfig(
      testnet: config.isTestnet,
      privateKey: privateKey,
      enableWs: config.enableWebSocket,
    ));

    print('📡 Connecting to Hyperliquid...');
    await client.connect();

    if (!client.isAuthenticated()) {
      throw Exception('Failed to authenticate with Hyperliquid');
    }

    print('✅ Connected and authenticated successfully');
  }

  /// Start health check monitoring
  Future<void> _startHealthChecks() async {
    healthCheckTimer = Timer.periodic(
      Duration(seconds: config.healthCheckIntervalSeconds),
      (_) => _performHealthCheck(),
    );

    // Initial health check
    await _performHealthCheck();
  }

  /// Start metrics collection
  Future<void> _startMetricsCollection() async {
    metricsTimer = Timer.periodic(
      Duration(minutes: config.metricsIntervalMinutes),
      (_) => _collectMetrics(),
    );
  }

  /// Perform comprehensive health check
  Future<void> _performHealthCheck() async {
    try {
      final startTime = DateTime.now();

      // Test basic connectivity
      final allMids = await client.info.generalAPI.getAllMids();
      final latency = DateTime.now().difference(startTime).inMilliseconds;

      // Test connection status
      final isConnected = client.isAuthenticated();

      // WebSocket health (if enabled)
      Map<String, dynamic> wsHealth = {};
      if (config.enableWebSocket) {
        wsHealth = {
          'enabled': config.enableWebSocket,
          'status': 'mock_status', // Replace with actual status when available
        };
      }

      lastHealthCheck = {
        'timestamp': DateTime.now().toIso8601String(),
        'status': 'healthy',
        'latency_ms': latency,
        'markets_available': allMids.mids.length,
        'connection_status': isConnected,
        'websocket': wsHealth,
      };

      print('💚 Health check passed - Latency: ${latency}ms, Markets: ${allMids.mids.length}');
    } catch (e) {
      lastHealthCheck = {
        'timestamp': DateTime.now().toIso8601String(),
        'status': 'unhealthy',
        'error': e.toString(),
      };

      print('❤️ Health check failed: $e');

      // Attempt recovery
      if (config.autoRecover) {
        await _attemptRecovery();
      }
    }
  }

  /// Collect and log performance metrics
  Future<void> _collectMetrics() async {
    final uptime = DateTime.now().difference(startTime);
    final successRate = totalRequests > 0 ? (totalRequests - failedRequests) / totalRequests * 100 : 100;

    final metrics = {
      'uptime_hours': uptime.inHours,
      'total_requests': totalRequests,
      'failed_requests': failedRequests,
      'success_rate_percent': successRate.toStringAsFixed(2),
      'successful_trades': successfulTrades,
      'total_volume': totalVolume.toStringAsFixed(2),
      'memory_usage_mb': ProcessInfo.currentRss / (1024 * 1024),
    };

    print('📊 Metrics: $metrics');

    // In production, send to monitoring system (Prometheus, DataDog, etc.)
    await _sendMetricsToMonitoring(metrics);
  }

  /// Attempt automatic recovery
  Future<void> _attemptRecovery() async {
    print('🔄 Attempting automatic recovery...');

    try {
      // Disconnect and reconnect
      client.disconnect();
      await Future<void>.delayed(const Duration(seconds: 5));
      await client.connect();

      if (client.isAuthenticated()) {
        print('✅ Recovery successful');
      } else {
        throw Exception('Authentication failed after recovery');
      }
    } catch (e) {
      print('❌ Recovery failed: $e');

      if (config.stopOnRecoveryFailure) {
        await stop();
      }
    }
  }

  /// Example trading operations with proper error handling
  Future<void> _runTradingExample() async {
    print('\n📈 Running trading example...');

    try {
      // Example 1: Get market data with error handling
      await _safeApiCall('Get Market Data', () async {
        final allMids = await client.info.generalAPI.getAllMids();
        print('Current BTC price: \$${allMids.mids['BTC-PERP'] ?? 'N/A'}');
        print('Current ETH price: \$${allMids.mids['ETH-PERP'] ?? 'N/A'}');
      });

      // Example 2: Get user information
      await _safeApiCall('Get User Info', () async {
        // Note: Replace with actual user address in production
        final userAddress = '0x${'0' * 40}'; // Placeholder
        try {
          final userOpenOrders = await client.info.getUserOpenOrders(userAddress);
          print('Open orders: ${userOpenOrders.length}');
        } catch (e) {
          print('ℹ️ User info not available (expected in example)');
        }
      });

      // Example 3: Advanced market analysis
      await _performMarketAnalysis();

      // Example 4: Portfolio monitoring (if authenticated for trading)
      await _monitorPortfolio();

      // Example 5: Risk management demo
      await _demonstrateRiskManagement();
    } catch (e) {
      print('❌ Trading example failed: $e');
    }
  }

  /// Perform market analysis
  Future<void> _performMarketAnalysis() async {
    print('\n🔍 Performing market analysis...');

    await _safeApiCall('Market Analysis', () async {
      final symbols = ['BTC-PERP', 'ETH-PERP', 'SOL-PERP'];

      for (final symbol in symbols) {
        try {
          // Get order book
          final l2Book = await client.info.getL2Book(symbol);

          if (l2Book.levels.isNotEmpty &&
              l2Book.levels.length > 1 &&
              l2Book.levels[0].isNotEmpty &&
              l2Book.levels[1].isNotEmpty) {
            final bestBid = l2Book.levels[0][0].px;
            final bestAsk = l2Book.levels[1][0].px;

            if (bestBid > 0 && bestAsk > 0) {
              final spread = bestAsk - bestBid;
              final spreadPercent = (spread / bestBid) * 100;

              print(
                  '$symbol - Bid: \$${bestBid.toStringAsFixed(2)}, Ask: \$${bestAsk.toStringAsFixed(2)}, Spread: ${spreadPercent.toStringAsFixed(3)}%');
            }
          }

          // Small delay to respect rate limits
          await Future<void>.delayed(const Duration(milliseconds: 100));
        } catch (e) {
          print('⚠️ Failed to analyze $symbol: $e');
        }
      }
    });
  }

  /// Monitor portfolio (demo)
  Future<void> _monitorPortfolio() async {
    print('\n💼 Portfolio monitoring demo...');

    await _safeApiCall('Portfolio Monitoring', () async {
      // In production, you would monitor real positions
      print('📊 Portfolio Metrics:');
      print('  - Total Equity: Demo Mode');
      print('  - Open Positions: Demo Mode');
      print('  - Unrealized PnL: Demo Mode');
      print('  - Available Balance: Demo Mode');

      // Simulate portfolio tracking
      final mockMetrics = {
        'total_equity': 10000.0,
        'unrealized_pnl': 150.25,
        'margin_usage': 0.25,
        'open_positions': 3,
      };

      print('📈 Mock Portfolio: $mockMetrics');
    });
  }

  /// Demonstrate risk management
  Future<void> _demonstrateRiskManagement() async {
    print('\n🛡️ Risk management demonstration...');

    await _safeApiCall('Risk Management', () async {
      // Example risk calculations
      final portfolioValue = 10000.0;
      final maxRiskPerTrade = portfolioValue * 0.02; // 2% risk per trade
      final maxPortfolioRisk = portfolioValue * 0.1; // 10% total risk

      print('💰 Portfolio Value: \$${portfolioValue.toStringAsFixed(2)}');
      print('⚠️ Max Risk Per Trade: \$${maxRiskPerTrade.toStringAsFixed(2)}');
      print('🚨 Max Portfolio Risk: \$${maxPortfolioRisk.toStringAsFixed(2)}');

      // Example position sizing
      final btcPrice = 50000.0;
      final stopLossPercent = 0.02; // 2% stop loss
      final riskAmount = maxRiskPerTrade;
      final stopLossDistance = btcPrice * stopLossPercent;
      final positionSize = riskAmount / stopLossDistance;

      print('\n📊 Position Sizing Example (BTC):');
      print('  - Entry Price: \$${btcPrice.toStringAsFixed(2)}');
      print('  - Stop Loss Distance: \$${stopLossDistance.toStringAsFixed(2)}');
      print('  - Position Size: ${positionSize.toStringAsFixed(4)} BTC');
      print('  - Position Value: \$${(positionSize * btcPrice).toStringAsFixed(2)}');
    });
  }

  /// Safe API call wrapper with error handling and retry
  Future<T> _safeApiCall<T>(String operation, Future<T> Function() apiCall) async {
    const maxRetries = 3;
    const baseDelay = Duration(seconds: 1);

    for (int attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        totalRequests++;
        final result = await apiCall();
        print('✅ $operation completed successfully');
        return result;
      } catch (e) {
        failedRequests++;

        if (attempt == maxRetries) {
          print('❌ $operation failed after $maxRetries attempts: $e');
          rethrow;
        }

        final delay = baseDelay * pow(2, attempt - 1);
        print('⚠️ $operation failed (attempt $attempt/$maxRetries): $e');
        print('🔄 Retrying in ${delay.inSeconds} seconds...');

        await Future.delayed(delay);
      }
    }

    throw Exception('This should never be reached');
  }

  /// Send metrics to monitoring system (mock implementation)
  Future<void> _sendMetricsToMonitoring(Map<String, dynamic> metrics) async {
    // In production, integrate with your monitoring stack:
    // - Prometheus metrics endpoint
    // - DataDog API
    // - Custom logging service
    // - AWS CloudWatch
    // - etc.

    print('📡 Sending metrics to monitoring system: ${metrics.keys.join(', ')}');
  }

  /// Graceful shutdown
  Future<void> stop() async {
    if (!isRunning) return;

    print('🛑 Shutting down application...');
    isRunning = false;

    // Cancel timers
    healthCheckTimer?.cancel();
    metricsTimer?.cancel();

    // Final metrics collection
    await _collectMetrics();

    // Close connections
    client.disconnect();

    // Final report
    final uptime = DateTime.now().difference(startTime);
    print('\n📋 Final Report:');
    print('  - Uptime: ${uptime.inHours}h ${uptime.inMinutes % 60}m');
    print('  - Total Requests: $totalRequests');
    print('  - Failed Requests: $failedRequests');
    print(
        '  - Success Rate: ${totalRequests > 0 ? ((totalRequests - failedRequests) / totalRequests * 100).toStringAsFixed(2) : 100}%');
    print('  - Successful Trades: $successfulTrades');
    print('  - Total Volume: \$${totalVolume.toStringAsFixed(2)}');

    print('✅ Application shutdown complete');
  }
}

/// Production configuration
class ProductionConfig {

  const ProductionConfig({
    required this.environment,
    this.isTestnet = true,
    this.enableWebSocket = true,
    this.enableLogging = true,
    this.autoRecover = true,
    this.stopOnRecoveryFailure = false,
    this.maxReconnectAttempts = 10,
    this.requestTimeoutMs = 30000,
    this.rateLimitTokens = 1200,
    this.healthCheckIntervalSeconds = 30,
    this.metricsIntervalMinutes = 5,
  });

  /// Development configuration
  factory ProductionConfig.development() {
    return const ProductionConfig(
      environment: 'development',
      isTestnet: true,
      rateLimitTokens: 600,
      healthCheckIntervalSeconds: 60,
      metricsIntervalMinutes: 10,
    );
  }

  /// Staging configuration
  factory ProductionConfig.staging() {
    return const ProductionConfig(
      environment: 'staging',
      isTestnet: true,
      rateLimitTokens: 1000,
      healthCheckIntervalSeconds: 30,
      metricsIntervalMinutes: 5,
    );
  }

  /// Production configuration
  factory ProductionConfig.production() {
    return const ProductionConfig(
      environment: 'production',
      isTestnet: false, // MAINNET
      rateLimitTokens: 1200,
      maxReconnectAttempts: 15,
      healthCheckIntervalSeconds: 15,
      metricsIntervalMinutes: 1,
      stopOnRecoveryFailure: true,
    );
  }
  final String environment;
  final bool isTestnet;
  final bool enableWebSocket;
  final bool enableLogging;
  final bool autoRecover;
  final bool stopOnRecoveryFailure;

  final int maxReconnectAttempts;
  final int requestTimeoutMs;
  final int rateLimitTokens;
  final int healthCheckIntervalSeconds;
  final int metricsIntervalMinutes;
}

/// Environment helper
class Environment {
  static String get current {
    return Platform.environment['ENVIRONMENT'] ?? 'development';
  }

  static bool get isDevelopment => current == 'development';
  static bool get isStaging => current == 'staging';
  static bool get isProduction => current == 'production';

  static ProductionConfig getConfig() {
    switch (current) {
      case 'staging':
        return ProductionConfig.staging();
      case 'production':
        return ProductionConfig.production();
      default:
        return ProductionConfig.development();
    }
  }
}

/// Application entry point
Future<void> main() async {
  print('🌟 Hyperliquid Production Trading Application');
  print('=' * 50);

  // Get configuration based on environment
  final config = Environment.getConfig();

  // Create application
  final app = ProductionTradingApp(config: config);

  // Handle shutdown signals
  ProcessSignal.sigint.watch().listen((_) async {
    print('\n📡 Received shutdown signal (SIGINT)...');
    await app.stop();
    exit(0);
  });

  ProcessSignal.sigterm.watch().listen((_) async {
    print('\n📡 Received shutdown signal (SIGTERM)...');
    await app.stop();
    exit(0);
  });

  try {
    // Start the application
    await app.start();

    // Keep running until shutdown
    while (app.isRunning) {
      await Future.delayed(const Duration(seconds: 1));
    }
  } catch (e, stackTrace) {
    print('💥 Application crashed: $e');
    print('Stack trace: $stackTrace');
    await app.stop();
    exit(1);
  }
}

/// Additional utility classes and extensions

/// Performance monitor
class PerformanceMonitor {
  static final Map<String, List<int>> _timings = {};

  static Future<T> time<T>(String operation, Future<T> Function() function) async {
    final start = DateTime.now();
    try {
      final result = await function();
      final duration = DateTime.now().difference(start).inMilliseconds;

      _timings.putIfAbsent(operation, () => []);
      _timings[operation]!.add(duration);

      // Keep only last 100 timings
      if (_timings[operation]!.length > 100) {
        _timings[operation]!.removeAt(0);
      }

      return result;
    } catch (e) {
      final duration = DateTime.now().difference(start).inMilliseconds;
      print('⏱️ $operation failed after ${duration}ms: $e');
      rethrow;
    }
  }

  static Map<String, Map<String, double>> getStats() {
    final stats = <String, Map<String, double>>{};

    for (final entry in _timings.entries) {
      final timings = entry.value;
      if (timings.isEmpty) continue;

      final avg = timings.reduce((a, b) => a + b) / timings.length;
      final min = timings.reduce((a, b) => a < b ? a : b);
      final max = timings.reduce((a, b) => a > b ? a : b);

      stats[entry.key] = {
        'avg_ms': avg,
        'min_ms': min.toDouble(),
        'max_ms': max.toDouble(),
        'count': timings.length.toDouble(),
      };
    }

    return stats;
  }
}

/// Circuit breaker for API calls
class CircuitBreaker {

  CircuitBreaker({
    this.failureThreshold = 5,
    this.timeout = const Duration(seconds: 60),
    this.retryAfter = const Duration(seconds: 30),
  });
  final int failureThreshold;
  final Duration timeout;
  final Duration retryAfter;

  int _failureCount = 0;
  DateTime? _lastFailureTime;
  bool _isOpen = false;

  Future<T> execute<T>(Future<T> Function() operation) async {
    if (_isOpen) {
      if (_lastFailureTime != null && DateTime.now().difference(_lastFailureTime!) > retryAfter) {
        _isOpen = false;
        _failureCount = 0;
      } else {
        throw Exception('Circuit breaker is open');
      }
    }

    try {
      final result = await operation();
      _onSuccess();
      return result;
    } catch (e) {
      _onFailure();
      rethrow;
    }
  }

  void _onSuccess() {
    _failureCount = 0;
    _isOpen = false;
  }

  void _onFailure() {
    _failureCount++;
    _lastFailureTime = DateTime.now();

    if (_failureCount >= failureThreshold) {
      _isOpen = true;
    }
  }

  bool get isOpen => _isOpen;
  int get currentFailures => _failureCount;
}
