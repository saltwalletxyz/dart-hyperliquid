/// Advanced Trading Bot Example for Hyperliquid Dart SDK
///
/// This example demonstrates how to build a sophisticated trading bot
/// with the Hyperliquid SDK, including:
/// - Real-time market monitoring
/// - Risk management and position sizing
/// - Multiple trading strategies
/// - Portfolio management
/// - Error handling and recovery
/// - Performance monitoring
///
/// ⚠️ WARNING: This is for educational purposes only.
/// Always test thoroughly on testnet before using real funds.
library;

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:hyperliquid/hyperliquid.dart';

/// Main trading bot class
class HyperliquidTradingBot {

  HyperliquidTradingBot({
    required this.client,
    required this.config,
  })  : riskManager = RiskManager(config.riskConfig),
        portfolioManager = PortfolioManager() {
    // Initialize strategies
    strategies.addAll([
      MomentumStrategy(config: config.momentumConfig),
      MeanReversionStrategy(config: config.meanReversionConfig),
      ArbitrageStrategy(config: config.arbitrageConfig),
    ]);
  }
  final Hyperliquid client;
  final BotConfig config;
  final RiskManager riskManager;
  final PortfolioManager portfolioManager;
  final List<TradingStrategy> strategies = [];

  // Bot state
  bool isRunning = false;
  DateTime startTime = DateTime.now();
  Map<String, double> lastPrices = {};
  Map<String, List<double>> priceHistory = {};

  // Performance tracking
  double initialEquity = 0;
  int totalTrades = 0;
  int profitableTrades = 0;
  double totalPnl = 0;

  /// Start the trading bot
  Future<void> start() async {
    if (isRunning) {
      print('❌ Bot is already running');
      return;
    }

    print('🚀 Starting Hyperliquid Trading Bot...');

    try {
      await client.connect();

      if (!client.isAuthenticated()) {
        throw Exception('Authentication failed');
      }

      // Get initial portfolio state
      final userState = await client.info.getUserState(client.address);
      initialEquity = double.parse(userState.marginSummary.accountValue);

      print('✅ Connected successfully');
      print('💰 Initial Equity: \$${initialEquity.toStringAsFixed(2)}');

      isRunning = true;
      startTime = DateTime.now();

      // Start main trading loop
      await _startTradingLoop();
    } catch (e, stackTrace) {
      print('❌ Failed to start bot: $e');
      print('Stack trace: $stackTrace');
      await stop();
    }
  }

  /// Stop the trading bot
  Future<void> stop() async {
    if (!isRunning) return;

    print('🛑 Stopping trading bot...');
    isRunning = false;

    // Close all positions if configured
    if (config.closePositionsOnStop) {
      try {
        await client.custom.closeAllPositions(slippage: 0.05);
        print('✅ All positions closed');
      } catch (e) {
        print('⚠️ Failed to close positions: $e');
      }
    }

    // Print final performance
    await _printPerformanceReport();

    client.disconnect();
    print('✅ Bot stopped successfully');
  }

  /// Main trading loop
  Future<void> _startTradingLoop() async {
    // Subscribe to real-time data
    await _setupRealtimeData();

    // Start periodic tasks
    final marketDataTimer = Timer.periodic(
      Duration(seconds: config.marketDataIntervalSeconds),
      (_) => _updateMarketData(),
    );

    final tradingTimer = Timer.periodic(
      Duration(seconds: config.tradingIntervalSeconds),
      (_) => _executeTradingCycle(),
    );

    final riskTimer = Timer.periodic(
      Duration(seconds: config.riskCheckIntervalSeconds),
      (_) => _checkRiskLimits(),
    );

    final reportTimer = Timer.periodic(
      Duration(minutes: config.reportIntervalMinutes),
      (_) => _printStatusReport(),
    );

    // Wait for stop signal
    while (isRunning) {
      await Future.delayed(const Duration(seconds: 1));
    }

    // Cancel timers
    marketDataTimer.cancel();
    tradingTimer.cancel();
    riskTimer.cancel();
    reportTimer.cancel();
  }

  /// Setup real-time data subscriptions
  Future<void> _setupRealtimeData() async {
    await client.subscriptions.subscribeToAllMids();
    await client.subscriptions.subscribeToUserEvents();

    // Handle price updates
    client.subscriptions.onAllMids((data) {
      for (final symbol in config.watchedSymbols) {
        final priceStr = data.mids[symbol];
        if (priceStr != null) {
          final price = double.parse(priceStr);
          lastPrices[symbol] = price;

          // Store price history
          priceHistory.putIfAbsent(symbol, () => []);
          priceHistory[symbol]!.add(price);

          // Keep only recent prices
          if (priceHistory[symbol]!.length > config.maxPriceHistoryLength) {
            priceHistory[symbol]!.removeAt(0);
          }
        }
      }
    });

    // Handle user events (fills, liquidations, etc.)
    client.subscriptions.onUserEvents((events) {
      for (final event in events) {
        _handleUserEvent(event);
      }
    });
  }

  /// Handle user events
  void _handleUserEvent(dynamic event) {
    switch (event.type) {
      case 'fill':
        totalTrades++;
        final pnl = double.tryParse(event.data['pnl']?.toString() ?? '0') ?? 0;
        totalPnl += pnl;
        if (pnl > 0) profitableTrades++;

        print('📈 Order filled: ${event.data['coin']} - PnL: \$${pnl.toStringAsFixed(2)}');
        break;

      case 'liquidation':
        print('🚨 LIQUIDATION ALERT: ${event.data}');
        // Implement emergency procedures
        _handleLiquidationAlert(event.data);
        break;

      default:
        print('📨 User event: ${event.type} - ${event.data}');
    }
  }

  /// Update market data and indicators
  Future<void> _updateMarketData() async {
    try {
      for (final symbol in config.watchedSymbols) {
        // Update technical indicators
        if (priceHistory[symbol] != null && priceHistory[symbol]!.length >= 20) {
          final prices = priceHistory[symbol]!;

          // Calculate moving averages
          final sma20 = _calculateSMA(prices, 20);
          final sma50 = _calculateSMA(prices, min(50, prices.length));

          // Calculate RSI
          final rsi = _calculateRSI(prices, min(14, prices.length));

          // Store indicators for strategies
          for (final strategy in strategies) {
            strategy.updateIndicators(symbol, {
              'price': prices.last,
              'sma20': sma20,
              'sma50': sma50,
              'rsi': rsi,
              'volume': 0.0, // Would need volume data
            });
          }
        }
      }
    } catch (e) {
      print('⚠️ Error updating market data: $e');
    }
  }

  /// Execute trading cycle
  Future<void> _executeTradingCycle() async {
    if (!isRunning) return;

    try {
      // Get current portfolio state
      final userState = await client.info.getUserState(client.address);
      portfolioManager.updatePortfolio(userState);

      // Check if we can trade
      if (!riskManager.canTrade(portfolioManager)) {
        return;
      }

      // Execute strategies
      for (final strategy in strategies) {
        if (!strategy.isEnabled) continue;

        final signals = await strategy.generateSignals(
          lastPrices,
          portfolioManager,
        );

        for (final signal in signals) {
          await _executeSignal(signal);
        }
      }
    } catch (e) {
      print('⚠️ Error in trading cycle: $e');
    }
  }

  /// Execute a trading signal
  Future<void> _executeSignal(TradingSignal signal) async {
    try {
      // Validate signal
      if (!riskManager.validateSignal(signal, portfolioManager)) {
        print('🚫 Signal rejected by risk manager: ${signal.symbol} ${signal.action}');
        return;
      }

      // Calculate position size
      final positionSize = riskManager.calculatePositionSize(
        signal,
        portfolioManager,
        lastPrices[signal.symbol] ?? 0,
      );

      if (positionSize <= 0) {
        print('🚫 Invalid position size for ${signal.symbol}');
        return;
      }

      print('📊 Executing signal: ${signal.symbol} ${signal.action} $positionSize');

      // Execute the trade
      switch (signal.action) {
        case SignalAction.buy:
          if (signal.orderType == OrderType.market) {
            await client.custom.marketOpen(
              signal.symbol,
              true,
              positionSize,
              slippage: config.maxSlippage,
            );
          } else {
            await client.exchange.placeOrder({
              'coin': signal.symbol,
              'is_buy': true,
              'sz': positionSize,
              'limit_px': signal.price!,
              'order_type': {
                'limit': {'tif': 'Gtc'}
              },
              'reduce_only': false,
            });
          }
          break;

        case SignalAction.sell:
          if (signal.orderType == OrderType.market) {
            await client.custom.marketOpen(
              signal.symbol,
              false,
              positionSize,
              slippage: config.maxSlippage,
            );
          } else {
            await client.exchange.placeOrder({
              'coin': signal.symbol,
              'is_buy': false,
              'sz': positionSize,
              'limit_px': signal.price!,
              'order_type': {
                'limit': {'tif': 'Gtc'}
              },
              'reduce_only': false,
            });
          }
          break;

        case SignalAction.close:
          await client.custom.marketClose(
            signal.symbol,
            slippage: config.maxSlippage,
          );
          break;
      }
    } catch (e) {
      print('❌ Failed to execute signal: $e');
    }
  }

  /// Check risk limits
  Future<void> _checkRiskLimits() async {
    try {
      final userState = await client.info.getUserState(client.address);
      portfolioManager.updatePortfolio(userState);

      // Check drawdown
      final currentEquity = portfolioManager.totalEquity;
      final drawdown = (initialEquity - currentEquity) / initialEquity;

      if (drawdown > config.maxDrawdown) {
        print('🚨 MAX DRAWDOWN EXCEEDED: ${(drawdown * 100).toStringAsFixed(2)}%');

        if (config.stopOnMaxDrawdown) {
          await stop();
          return;
        }

        // Close all positions
        await client.custom.closeAllPositions(slippage: 0.05);
      }

      // Check margin usage
      final marginUsage = portfolioManager.marginUsage;
      if (marginUsage > config.maxMarginUsage) {
        print('⚠️ High margin usage: ${(marginUsage * 100).toStringAsFixed(1)}%');

        // Reduce position sizes
        await _reducePositionSizes(0.5);
      }
    } catch (e) {
      print('⚠️ Error checking risk limits: $e');
    }
  }

  /// Handle liquidation alert
  Future<void> _handleLiquidationAlert(dynamic liquidationData) async {
    print('🚨 LIQUIDATION EMERGENCY PROTOCOL ACTIVATED');

    // Immediately close all positions
    try {
      await client.custom.closeAllPositions(slippage: 0.1); // Higher slippage for emergency
      print('✅ Emergency position closure completed');
    } catch (e) {
      print('❌ Emergency position closure failed: $e');
    }

    // Stop the bot if configured
    if (config.stopOnLiquidation) {
      await stop();
    }
  }

  /// Reduce position sizes
  Future<void> _reducePositionSizes(double reductionFactor) async {
    try {
      final userState = await client.info.getUserState(client.address);

      for (final pos in userState.assetPositions) {
        if (pos.position.szi != '0') {
          final currentSize = double.parse(pos.position.szi).abs();
          final reduceSize = currentSize * reductionFactor;

          await client.custom.marketClose(
            pos.position.coin,
            size: reduceSize,
            slippage: config.maxSlippage,
          );

          print('📉 Reduced ${pos.position.coin} position by ${(reductionFactor * 100).toInt()}%');
        }
      }
    } catch (e) {
      print('❌ Failed to reduce position sizes: $e');
    }
  }

  /// Print status report
  Future<void> _printStatusReport() async {
    try {
      final uptime = DateTime.now().difference(startTime);
      final userState = await client.info.getUserState(client.address);
      final currentEquity = double.parse(userState.marginSummary.accountValue);
      final returnPercent = ((currentEquity - initialEquity) / initialEquity) * 100;
      final winRate = totalTrades > 0 ? (profitableTrades / totalTrades) * 100 : 0;

      print('\n📊 === TRADING BOT STATUS REPORT ===');
      print('⏱️  Uptime: ${uptime.inHours}h ${uptime.inMinutes % 60}m');
      print(
          '💰 Equity: \$${currentEquity.toStringAsFixed(2)} (${returnPercent >= 0 ? '+' : ''}${returnPercent.toStringAsFixed(2)}%)');
      print('📈 Total PnL: \$${totalPnl.toStringAsFixed(2)}');
      print('🎯 Trades: $totalTrades (${winRate.toStringAsFixed(1)}% win rate)');
      print('📊 Open Positions: ${userState.assetPositions.where((p) => p.position.szi != '0').length}');
      print(
          '💳 Available Balance: \$${(currentEquity - double.parse(userState.marginSummary.totalMarginUsed)).toStringAsFixed(2)}');

      // Strategy performance
      print('\n📈 Strategy Performance:');
      for (final strategy in strategies) {
        print('  ${strategy.name}: ${strategy.isEnabled ? '✅' : '❌'} - Signals: ${strategy.signalsGenerated}');
      }

      print('=' * 40);
    } catch (e) {
      print('⚠️ Error generating status report: $e');
    }
  }

  /// Print final performance report
  Future<void> _printPerformanceReport() async {
    final duration = DateTime.now().difference(startTime);
    final userState = await client.info.getUserState(client.address);
    final finalEquity = double.parse(userState.marginSummary.accountValue);
    final totalReturn = ((finalEquity - initialEquity) / initialEquity) * 100;
    final dailyReturn = totalReturn / duration.inDays.clamp(1, double.infinity);

    print('\n🏁 === FINAL PERFORMANCE REPORT ===');
    print('📅 Trading Period: ${duration.inDays} days, ${duration.inHours % 24} hours');
    print('💰 Initial Equity: \$${initialEquity.toStringAsFixed(2)}');
    print('💰 Final Equity: \$${finalEquity.toStringAsFixed(2)}');
    print('📈 Total Return: ${totalReturn >= 0 ? '+' : ''}${totalReturn.toStringAsFixed(2)}%');
    print('📊 Daily Return: ${dailyReturn >= 0 ? '+' : ''}${dailyReturn.toStringAsFixed(2)}%');
    print('🎯 Total Trades: $totalTrades');
    print(
        '✅ Profitable Trades: $profitableTrades (${totalTrades > 0 ? ((profitableTrades / totalTrades) * 100).toStringAsFixed(1) : 0}%)');
    print('💵 Total PnL: \$${totalPnl.toStringAsFixed(2)}');
    print('🎯 Average Trade: \$${totalTrades > 0 ? (totalPnl / totalTrades).toStringAsFixed(2) : '0.00'}');
    print('=' * 40);
  }

  // Technical indicator calculations
  double _calculateSMA(List<double> prices, int period) {
    if (prices.length < period) return prices.last;
    return prices.takeLast(period).reduce((a, b) => a + b) / period;
  }

  double _calculateRSI(List<double> prices, int period) {
    if (prices.length < period + 1) return 50.0;

    double gains = 0;
    double losses = 0;

    for (int i = prices.length - period; i < prices.length; i++) {
      final change = prices[i] - prices[i - 1];
      if (change > 0) {
        gains += change;
      } else {
        losses += change.abs();
      }
    }

    final avgGain = gains / period;
    final avgLoss = losses / period;

    if (avgLoss == 0) return 100.0;

    final rs = avgGain / avgLoss;
    return 100 - (100 / (1 + rs));
  }
}

/// Bot configuration
class BotConfig {

  BotConfig({
    required this.watchedSymbols,
    this.marketDataIntervalSeconds = 10,
    this.tradingIntervalSeconds = 30,
    this.riskCheckIntervalSeconds = 60,
    this.reportIntervalMinutes = 15,
    this.maxPriceHistoryLength = 200,
    this.maxSlippage = 0.02,
    this.maxDrawdown = 0.1,
    this.maxMarginUsage = 0.8,
    this.closePositionsOnStop = true,
    this.stopOnMaxDrawdown = true,
    this.stopOnLiquidation = true,
    required this.riskConfig,
    required this.momentumConfig,
    required this.meanReversionConfig,
    required this.arbitrageConfig,
  });
  final List<String> watchedSymbols;
  final int marketDataIntervalSeconds;
  final int tradingIntervalSeconds;
  final int riskCheckIntervalSeconds;
  final int reportIntervalMinutes;
  final int maxPriceHistoryLength;
  final double maxSlippage;
  final double maxDrawdown;
  final double maxMarginUsage;
  final bool closePositionsOnStop;
  final bool stopOnMaxDrawdown;
  final bool stopOnLiquidation;

  final RiskConfig riskConfig;
  final StrategyConfig momentumConfig;
  final StrategyConfig meanReversionConfig;
  final StrategyConfig arbitrageConfig;
}

/// Risk management configuration
class RiskConfig {

  RiskConfig({
    this.maxPositionSize = 0.1,
    this.maxPortfolioRisk = 0.05,
    this.maxCorrelationRisk = 0.3,
    this.maxOpenPositions = 5,
  });
  final double maxPositionSize;
  final double maxPortfolioRisk;
  final double maxCorrelationRisk;
  final int maxOpenPositions;
}

/// Strategy configuration
class StrategyConfig {

  StrategyConfig({
    this.enabled = true,
    this.allocation = 0.33,
    this.parameters = const {},
  });
  final bool enabled;
  final double allocation;
  final Map<String, dynamic> parameters;
}

/// Risk manager
class RiskManager {

  RiskManager(this.config);
  final RiskConfig config;

  bool canTrade(PortfolioManager portfolio) {
    return portfolio.availableBalance > 100 && // Minimum balance
        portfolio.marginUsage < config.maxPortfolioRisk &&
        portfolio.openPositions < config.maxOpenPositions;
  }

  bool validateSignal(TradingSignal signal, PortfolioManager portfolio) {
    // Check if we already have a position in this symbol
    final existingPosition = portfolio.getPosition(signal.symbol);

    // Prevent adding to losing positions
    if (existingPosition != null && existingPosition.unrealizedPnl < 0) {
      if (signal.action == SignalAction.buy && existingPosition.size > 0) return false;
      if (signal.action == SignalAction.sell && existingPosition.size < 0) return false;
    }

    return true;
  }

  double calculatePositionSize(TradingSignal signal, PortfolioManager portfolio, double price) {
    final availableBalance = portfolio.availableBalance;
    final maxPositionValue = availableBalance * config.maxPositionSize;

    if (price <= 0) return 0;

    return (maxPositionValue / price).clamp(0.001, 10.0);
  }
}

/// Portfolio manager
class PortfolioManager {
  double totalEquity = 0;
  double availableBalance = 0;
  double marginUsage = 0;
  int openPositions = 0;
  List<Position> positions = [];

  void updatePortfolio(dynamic userState) {
    totalEquity = double.parse(userState.marginSummary.accountValue);
    availableBalance = totalEquity - double.parse(userState.marginSummary.totalMarginUsed);
    marginUsage = double.parse(userState.marginSummary.totalMarginUsed) / totalEquity;

    positions.clear();
    openPositions = 0;

    for (final pos in userState.assetPositions) {
      if (pos.position.szi != '0') {
        openPositions++;
        positions.add(Position(
          symbol: pos.position.coin,
          size: double.parse(pos.position.szi),
          entryPrice: double.parse(pos.position.entryPx),
          unrealizedPnl: double.parse(pos.position.unrealizedPnl),
        ));
      }
    }
  }

  Position? getPosition(String symbol) {
    return positions.where((p) => p.symbol == symbol).firstOrNull;
  }
}

/// Position data
class Position {

  Position({
    required this.symbol,
    required this.size,
    required this.entryPrice,
    required this.unrealizedPnl,
  });
  final String symbol;
  final double size;
  final double entryPrice;
  final double unrealizedPnl;
}

/// Trading signal
class TradingSignal {

  TradingSignal({
    required this.symbol,
    required this.action,
    required this.orderType,
    this.price,
    required this.confidence,
    required this.strategy,
  });
  final String symbol;
  final SignalAction action;
  final OrderType orderType;
  final double? price;
  final double confidence;
  final String strategy;
}

enum SignalAction { buy, sell, close }

enum OrderType { market, limit }

/// Base trading strategy
abstract class TradingStrategy {

  TradingStrategy({
    required this.name,
    required this.config,
  }) : isEnabled = config.enabled;
  final String name;
  final StrategyConfig config;
  bool isEnabled;
  int signalsGenerated = 0;
  Map<String, Map<String, double>> indicators = {};

  void updateIndicators(String symbol, Map<String, double> newIndicators) {
    indicators[symbol] = newIndicators;
  }

  Future<List<TradingSignal>> generateSignals(
    Map<String, double> prices,
    PortfolioManager portfolio,
  );
}

/// Momentum trading strategy
class MomentumStrategy extends TradingStrategy {
  MomentumStrategy({required super.config}) : super(name: 'Momentum');

  @override
  Future<List<TradingSignal>> generateSignals(
    Map<String, double> prices,
    PortfolioManager portfolio,
  ) async {
    final signals = <TradingSignal>[];

    for (final symbol in prices.keys) {
      final indicatorData = indicators[symbol];
      if (indicatorData == null) continue;

      final price = indicatorData['price']!;
      final sma20 = indicatorData['sma20']!;
      final sma50 = indicatorData['sma50']!;
      final rsi = indicatorData['rsi']!;

      // Momentum buy signal: price above both MAs and RSI not overbought
      if (price > sma20 && sma20 > sma50 && rsi < 70) {
        signals.add(TradingSignal(
          symbol: symbol,
          action: SignalAction.buy,
          orderType: OrderType.market,
          confidence: 0.7,
          strategy: name,
        ));
        signalsGenerated++;
      }

      // Momentum sell signal: price below both MAs and RSI not oversold
      else if (price < sma20 && sma20 < sma50 && rsi > 30) {
        signals.add(TradingSignal(
          symbol: symbol,
          action: SignalAction.sell,
          orderType: OrderType.market,
          confidence: 0.7,
          strategy: name,
        ));
        signalsGenerated++;
      }
    }

    return signals;
  }
}

/// Mean reversion strategy
class MeanReversionStrategy extends TradingStrategy {
  MeanReversionStrategy({required super.config}) : super(name: 'Mean Reversion');

  @override
  Future<List<TradingSignal>> generateSignals(
    Map<String, double> prices,
    PortfolioManager portfolio,
  ) async {
    final signals = <TradingSignal>[];

    for (final symbol in prices.keys) {
      final indicatorData = indicators[symbol];
      if (indicatorData == null) continue;

      final price = indicatorData['price']!;
      final sma20 = indicatorData['sma20']!;
      final rsi = indicatorData['rsi']!;

      // Mean reversion buy: price significantly below SMA and oversold
      if (price < sma20 * 0.98 && rsi < 30) {
        signals.add(TradingSignal(
          symbol: symbol,
          action: SignalAction.buy,
          orderType: OrderType.limit,
          price: price * 1.001, // Slightly above current price
          confidence: 0.6,
          strategy: name,
        ));
        signalsGenerated++;
      }

      // Mean reversion sell: price significantly above SMA and overbought
      else if (price > sma20 * 1.02 && rsi > 70) {
        signals.add(TradingSignal(
          symbol: symbol,
          action: SignalAction.sell,
          orderType: OrderType.limit,
          price: price * 0.999, // Slightly below current price
          confidence: 0.6,
          strategy: name,
        ));
        signalsGenerated++;
      }
    }

    return signals;
  }
}

/// Arbitrage strategy (placeholder)
class ArbitrageStrategy extends TradingStrategy {
  ArbitrageStrategy({required super.config}) : super(name: 'Arbitrage');

  @override
  Future<List<TradingSignal>> generateSignals(
    Map<String, double> prices,
    PortfolioManager portfolio,
  ) async {
    // Placeholder - would implement cross-exchange or cross-asset arbitrage
    return [];
  }
}

/// Extension to get first element or null
extension IterableExtension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
  Iterable<T> takeLast(int count) => skip(length - count);
}

/// Main function - example usage
Future<void> main() async {
  // Get configuration from environment
  final privateKey = Platform.environment['HYPERLIQUID_PRIVATE_KEY'];
  if (privateKey == null) {
    print('❌ Please set HYPERLIQUID_PRIVATE_KEY environment variable');
    return;
  }

  // Create client
  final client = Hyperliquid(HyperliquidConfig(
    testnet: true, // Always use testnet for examples
    privateKey: privateKey,
    enableWs: true,
  ));

  // Create bot configuration
  final botConfig = BotConfig(
    watchedSymbols: ['BTC-PERP', 'ETH-PERP', 'SOL-PERP'],
    maxDrawdown: 0.05, // 5% max drawdown
    maxMarginUsage: 0.6, // 60% max margin usage
    riskConfig: RiskConfig(
      maxPositionSize: 0.02, // 2% of portfolio per position
      maxOpenPositions: 3,
    ),
    momentumConfig: StrategyConfig(enabled: true, allocation: 0.5),
    meanReversionConfig: StrategyConfig(enabled: true, allocation: 0.3),
    arbitrageConfig: StrategyConfig(enabled: false, allocation: 0.2),
  );

  // Create and start bot
  final bot = HyperliquidTradingBot(
    client: client,
    config: botConfig,
  );

  // Handle shutdown signals
  ProcessSignal.sigint.watch().listen((_) async {
    print('\n🛑 Received shutdown signal...');
    await bot.stop();
    exit(0);
  });

  try {
    await bot.start();
  } catch (e) {
    print('❌ Bot crashed: $e');
    await bot.stop();
    exit(1);
  }
}
