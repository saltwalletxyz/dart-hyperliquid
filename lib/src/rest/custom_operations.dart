import 'dart:math';
import '../hyperliquid_base.dart';
import '../rest/exchange_api.dart';
import '../rest/info_api.dart';
import '../utils/symbol_conversion.dart';

/// Custom operations for advanced trading functionality
///
/// This class provides high-level trading operations like market orders,
/// bulk operations, and position management that are commonly needed
/// for production trading applications.
class CustomOperations {
  final Hyperliquid _parent;
  final ExchangeAPI _exchange;
  final InfoAPI _infoApi;
  final SymbolConversion _symbolConversion;
  final String? _walletAddress;

  /// Default slippage percentage (5%)
  static const double defaultSlippage = 0.05;

  CustomOperations(
    this._parent,
    this._exchange,
    this._infoApi,
    this._symbolConversion,
    this._walletAddress,
  );

  /// Get the user's wallet address
  String _getUserAddress() {
    if (_walletAddress == null) {
      throw Exception(
        'No wallet address available. Please provide a wallet address or private key.',
      );
    }
    return _walletAddress!;
  }

  /// Cancel all open orders for a specific symbol or all symbols
  ///
  /// [symbol] - Optional symbol to cancel orders for. If null, cancels all orders
  /// Returns the cancel response from the exchange
  Future<dynamic> cancelAllOrders([String? symbol]) async {
    try {
      final address = _getUserAddress();
      final openOrdersResponse = await _infoApi.getUserOpenOrders(address);

      if (openOrdersResponse == null) {
        throw Exception('No orders to cancel');
      }

      // Handle the response as a list of dynamic objects
      List<dynamic> allOrders;
      if (openOrdersResponse is List) {
        allOrders = openOrdersResponse;
      } else if (openOrdersResponse is Map && openOrdersResponse.containsKey('orders')) {
        allOrders = openOrdersResponse['orders'] as List<dynamic>;
      } else {
        throw Exception('Unexpected response format for open orders');
      }

      if (allOrders.isEmpty) {
        throw Exception('No orders to cancel');
      }

      List<dynamic> ordersToCancel;

      if (symbol != null) {
        final convertedSymbol = await _symbolConversion.convertSymbol(symbol);
        ordersToCancel = allOrders.where((order) {
          return order['coin'] == convertedSymbol;
        }).toList();
      } else {
        ordersToCancel = allOrders;
      }

      if (ordersToCancel.isEmpty) {
        throw Exception('No orders to cancel for the specified criteria');
      }

      // Convert orders to cancel requests
      final cancelRequests = <Map<String, dynamic>>[];
      for (final order in ordersToCancel) {
        cancelRequests.add({
          'coin': order['coin'],
          'o': order['oid'],
        });
      }

      // Cancel all orders in batch
      return await _exchange.cancelOrder(cancelRequests);
    } catch (error) {
      rethrow;
    }
  }

  /// Get all available assets (perpetuals and spot)
  ///
  /// Returns a map with 'perp' and 'spot' keys containing lists of symbols
  Future<Map<String, List<String>>> getAllAssets() async {
    return await _symbolConversion.getAllAssets();
  }

  /// Calculate slippage-adjusted price for market orders
  ///
  /// [symbol] - Trading symbol
  /// [isBuy] - True for buy orders, false for sell orders
  /// [slippage] - Slippage percentage (e.g., 0.05 for 5%)
  /// [px] - Optional base price. If null, fetches current market price
  ///
  /// Returns the slippage-adjusted price
  Future<double> getSlippagePrice(
    String symbol,
    bool isBuy,
    double slippage, [
    double? px,
  ]) async {
    final convertedSymbol = await _symbolConversion.convertSymbol(symbol);

    double basePrice = px ?? 0.0;
    if (basePrice == 0.0) {
      final allMids = await _infoApi.getAllMids();
      if (allMids?.mids[convertedSymbol] != null) {
        basePrice = double.parse(allMids!.mids[convertedSymbol].toString());
      } else {
        throw Exception('Could not fetch price for symbol: $convertedSymbol');
      }
    }

    final isSpot = symbol.contains('-SPOT');

    // Calculate slippage-adjusted price
    final adjustedPrice = basePrice * (isBuy ? (1 + slippage) : (1 - slippage));

    // Determine decimal places for rounding
    int decimals = 8; // Default for spot
    if (!isSpot) {
      // For perpetuals, use price-based decimal calculation
      final priceStr = basePrice.toString();
      final decimalIndex = priceStr.indexOf('.');
      if (decimalIndex != -1) {
        decimals = max(0, priceStr.length - decimalIndex - 2);
      }
    }

    // Round to appropriate decimal places
    final multiplier = pow(10, decimals);
    return (adjustedPrice * multiplier).round() / multiplier;
  }

  /// Execute a market buy or sell order with slippage protection
  ///
  /// [symbol] - Trading symbol (e.g., 'BTC-PERP', 'ETH-SPOT')
  /// [isBuy] - True for buy, false for sell
  /// [size] - Order size
  /// [px] - Optional base price for slippage calculation
  /// [slippage] - Slippage tolerance (default: 5%)
  /// [cloid] - Optional client order ID
  ///
  /// Returns the order response
  Future<dynamic> marketOpen(
    String symbol,
    bool isBuy,
    double size, {
    double? px,
    double slippage = defaultSlippage,
    String? cloid,
  }) async {
    final convertedSymbol = await _symbolConversion.convertSymbol(symbol);
    final slippagePrice = await getSlippagePrice(convertedSymbol, isBuy, slippage, px);

    print('Market Open - Symbol: $convertedSymbol, Price: $slippagePrice, Size: $size');

    final orderRequest = {
      'coin': convertedSymbol,
      'is_buy': isBuy,
      'sz': size,
      'limit_px': slippagePrice,
      'order_type': {
        'limit': {'tif': 'Ioc'} // Immediate or Cancel for market-like behavior
      },
      'reduce_only': false,
    };

    if (cloid != null) {
      orderRequest['cloid'] = cloid;
    }

    return await _exchange.placeOrder(orderRequest);
  }

  /// Close a position with a market order
  ///
  /// [symbol] - Trading symbol
  /// [size] - Optional size to close. If null, closes entire position
  /// [px] - Optional base price for slippage calculation
  /// [slippage] - Slippage tolerance (default: 5%)
  /// [cloid] - Optional client order ID
  ///
  /// Returns the order response
  Future<dynamic> marketClose(
    String symbol, {
    double? size,
    double? px,
    double slippage = defaultSlippage,
    String? cloid,
  }) async {
    final convertedSymbol = await _symbolConversion.convertSymbol(symbol);
    final address = _getUserAddress();

    // Get current positions
    final positions = await _infoApi.perpetualsAPI.getClearinghouseState(address);

    if (positions == null || positions['assetPositions'] == null) {
      throw Exception('Could not fetch positions');
    }

    final assetPositions = positions['assetPositions'] as List;

    for (final positionData in assetPositions) {
      final position = positionData['position'];
      if (position['coin'] != convertedSymbol) {
        continue;
      }

      final szi = double.parse(position['szi'].toString());
      if (szi == 0) {
        throw Exception('No position found for $convertedSymbol');
      }

      final closeSize = size ?? szi.abs();
      final isBuy = szi < 0; // Buy to close short, sell to close long

      // Get slippage-adjusted price
      final slippagePrice = await getSlippagePrice(convertedSymbol, isBuy, slippage, px);

      print('Market Close - Symbol: $convertedSymbol, Price: $slippagePrice, Size: $closeSize');

      final orderRequest = {
        'coin': convertedSymbol,
        'is_buy': isBuy,
        'sz': closeSize,
        'limit_px': slippagePrice,
        'order_type': {
          'limit': {'tif': 'Ioc'} // Immediate or Cancel
        },
        'reduce_only': true,
      };

      if (cloid != null) {
        orderRequest['cloid'] = cloid;
      }

      return await _exchange.placeOrder(orderRequest);
    }

    throw Exception('No position found for $convertedSymbol');
  }

  /// Close all open positions with market orders
  ///
  /// [slippage] - Slippage tolerance for all orders (default: 5%)
  ///
  /// Returns a list of order responses
  Future<List<dynamic>> closeAllPositions({
    double slippage = defaultSlippage,
  }) async {
    try {
      final address = _getUserAddress();
      final positions = await _infoApi.perpetualsAPI.getClearinghouseState(address);

      if (positions == null || positions['assetPositions'] == null) {
        throw Exception('Could not fetch positions');
      }

      final assetPositions = positions['assetPositions'] as List;
      final closeOrders = <Future<dynamic>>[];

      print('Found ${assetPositions.length} asset positions');

      for (final positionData in assetPositions) {
        final position = positionData['position'];
        final szi = double.parse(position['szi'].toString());

        if (szi != 0) {
          // Convert back to user-friendly symbol
          final symbol = await _symbolConversion.convertSymbol(
            position['coin'].toString(),
            'reverse',
          );

          print('Closing position: $symbol (size: $szi)');
          closeOrders.add(marketClose(symbol, slippage: slippage));
        }
      }

      if (closeOrders.isEmpty) {
        throw Exception('No positions to close');
      }

      return await Future.wait(closeOrders);
    } catch (error) {
      rethrow;
    }
  }

  // ==================== ADDITIONAL TRADING UTILITIES ====================

  /// Get the current position for a specific symbol
  ///
  /// [symbol] - Trading symbol to check
  /// Returns position data or null if no position exists
  Future<Map<String, dynamic>?> getPosition(String symbol) async {
    final convertedSymbol = await _symbolConversion.convertSymbol(symbol);
    final address = _getUserAddress();
    
    final positions = await _infoApi.perpetualsAPI.getClearinghouseState(address);
    if (positions == null || positions['assetPositions'] == null) {
      return null;
    }

    final assetPositions = positions['assetPositions'] as List;
    for (final positionData in assetPositions) {
      final posMap = positionData as Map<String, dynamic>;
      final position = posMap['position'] as Map<String, dynamic>;
      if (position['coin'] == convertedSymbol) {
        return Map<String, dynamic>.from(position);
      }
    }
    return null;
  }

  /// Get all current positions
  ///
  /// Returns a list of position data
  Future<List<Map<String, dynamic>>> getAllPositions() async {
    final address = _getUserAddress();
    final positions = await _infoApi.perpetualsAPI.getClearinghouseState(address);
    
    if (positions == null || positions['assetPositions'] == null) {
      return [];
    }

    final assetPositions = positions['assetPositions'] as List;
    final result = <Map<String, dynamic>>[];
    
    for (final positionData in assetPositions) {
      final posMap = positionData as Map<String, dynamic>;
      final position = posMap['position'] as Map<String, dynamic>;
      final szi = double.parse(position['szi'].toString());
      
      if (szi != 0) {
        // Add user-friendly symbol
        final userSymbol = await _symbolConversion.convertSymbol(
          position['coin'].toString(),
          'reverse',
        );
        final positionCopy = Map<String, dynamic>.from(position);
        positionCopy['userSymbol'] = userSymbol;
        result.add(positionCopy);
      }
    }
    
    return result;
  }

  /// Place a stop-loss order
  ///
  /// [symbol] - Trading symbol
  /// [stopPrice] - Price at which to trigger the stop-loss
  /// [size] - Optional size, defaults to entire position
  /// [cloid] - Optional client order ID
  Future<dynamic> placeStopLoss(
    String symbol,
    double stopPrice, {
    double? size,
    String? cloid,
  }) async {
    final position = await getPosition(symbol);
    if (position == null) {
      throw Exception('No position found for $symbol');
    }
    
    final szi = double.parse(position['szi'].toString());
    if (szi == 0) {
      throw Exception('No position to stop-loss for $symbol');
    }
    
    final orderSize = size ?? szi.abs();
    final isBuy = szi < 0; // Buy to close short, sell to close long
    
    final convertedSymbol = await _symbolConversion.convertSymbol(symbol);
    
    final orderRequest = {
      'coin': convertedSymbol,
      'is_buy': isBuy,
      'sz': orderSize,
      'limit_px': stopPrice,
      'order_type': {
        'trigger': {
          'triggerPx': stopPrice,
          'isMarket': false,
          'tpsl': isBuy ? 'sl' : 'tp',
        }
      },
      'reduce_only': true,
    };

    if (cloid != null) {
      orderRequest['cloid'] = cloid;
    }

    return await _exchange.placeOrder(orderRequest);
  }

  /// Place a take-profit order
  ///
  /// [symbol] - Trading symbol
  /// [targetPrice] - Price at which to take profit
  /// [size] - Optional size, defaults to entire position
  /// [cloid] - Optional client order ID
  Future<dynamic> placeTakeProfit(
    String symbol,
    double targetPrice, {
    double? size,
    String? cloid,
  }) async {
    final position = await getPosition(symbol);
    if (position == null) {
      throw Exception('No position found for $symbol');
    }
    
    final szi = double.parse(position['szi'].toString());
    if (szi == 0) {
      throw Exception('No position to take-profit for $symbol');
    }
    
    final orderSize = size ?? szi.abs();
    final isBuy = szi < 0; // Buy to close short, sell to close long
    
    final convertedSymbol = await _symbolConversion.convertSymbol(symbol);
    
    final orderRequest = {
      'coin': convertedSymbol,
      'is_buy': isBuy,
      'sz': orderSize,
      'limit_px': targetPrice,
      'order_type': {
        'trigger': {
          'triggerPx': targetPrice,
          'isMarket': false,
          'tpsl': isBuy ? 'tp' : 'sl',
        }
      },
      'reduce_only': true,
    };

    if (cloid != null) {
      orderRequest['cloid'] = cloid;
    }

    return await _exchange.placeOrder(orderRequest);
  }

  /// Cancel all orders for a specific symbol
  ///
  /// [symbol] - Symbol to cancel orders for
  /// Returns the cancel response
  Future<dynamic> cancelOrdersForSymbol(String symbol) async {
    final convertedSymbol = await _symbolConversion.convertSymbol(symbol);
    final address = _getUserAddress();
    final openOrdersResponse = await _infoApi.getUserOpenOrders(address);

    if (openOrdersResponse == null) {
      throw Exception('No orders to cancel for $symbol');
    }

    final userOpenOrders = openOrdersResponse as dynamic;
    final orders = userOpenOrders.orders as List?;
    
    if (orders == null || orders.isEmpty) {
      throw Exception('No orders to cancel for $symbol');
    }

    final ordersToCancel = <Map<String, dynamic>>[];
    for (final order in orders) {
      final orderMap = order as Map<String, dynamic>;
      if (orderMap['coin'] == convertedSymbol) {
        ordersToCancel.add({
          'coin': convertedSymbol,
          'o': orderMap['oid'],
        });
      }
    }

    if (ordersToCancel.isEmpty) {
      throw Exception('No orders found for $symbol');
    }

    return await _exchange.cancelOrder({'cancels': ordersToCancel});
  }

  /// Calculate unrealized PnL for all positions
  ///
  /// Returns total unrealized PnL
  Future<double> getUnrealizedPnL() async {
    final address = _getUserAddress();
    final clearingState = await _infoApi.perpetualsAPI.getClearinghouseState(address);
    
    if (clearingState == null || clearingState['marginSummary'] == null) {
      return 0.0;
    }
    
    return double.parse(clearingState['marginSummary']['unrealizedPnl'].toString());
  }

  /// Get account equity
  ///
  /// Returns total account equity
  Future<double> getAccountEquity() async {
    final address = _getUserAddress();
    final clearingState = await _infoApi.perpetualsAPI.getClearinghouseState(address);
    
    if (clearingState == null || clearingState['marginSummary'] == null) {
      return 0.0;
    }
    
    return double.parse(clearingState['marginSummary']['accountValue'].toString());
  }

  /// Get available balance for trading
  ///
  /// Returns available balance
  Future<double> getAvailableBalance() async {
    final address = _getUserAddress();
    final clearingState = await _infoApi.perpetualsAPI.getClearinghouseState(address);
    
    if (clearingState == null || clearingState['withdrawable'] == null) {
      return 0.0;
    }
    
    return double.parse(clearingState['withdrawable'].toString());
  }

  /// Place multiple orders at once with optimal batching
  ///
  /// [orders] - List of order specifications
  /// [grouping] - Grouping strategy for batch orders
  /// Returns batch order response
  Future<dynamic> placeBatchOrders(
    List<Map<String, dynamic>> orders, [
    String grouping = 'na',
  ]) async {
    // Convert symbols in all orders
    for (final order in orders) {
      if (order.containsKey('coin')) {
        final coin = order['coin']?.toString();
        if (coin != null) {
          order['coin'] = await _symbolConversion.convertSymbol(coin);
        }
      }
    }

    return await _exchange.placeOrder({
      'orders': orders,
      'grouping': grouping,
    });
  }

  /// Get order book depth for a symbol
  ///
  /// [symbol] - Trading symbol
  /// [depth] - Number of levels to retrieve
  /// Returns order book data
  Future<Map<String, dynamic>> getOrderBookDepth(String symbol, {int depth = 10}) async {
    final convertedSymbol = await _symbolConversion.convertSymbol(symbol);
    final l2Book = await _infoApi.getL2Book(convertedSymbol);
    
    if (l2Book == null) {
      throw Exception('Could not fetch order book for $symbol');
    }
    
    final bids = (l2Book.levels[0] as List).take(depth).toList();
    final asks = (l2Book.levels[1] as List).take(depth).toList();
    
    return {
      'symbol': symbol,
      'bids': bids,
      'asks': asks,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };
  }
}
