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
}
