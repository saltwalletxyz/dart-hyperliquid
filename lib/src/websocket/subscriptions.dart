import 'dart:async';

import 'package:hyperliquid/src/utils/symbol_conversion.dart';
import 'package:hyperliquid/src/websocket/websocket_client.dart';
import 'package:logger/logger.dart';

class WebSocketSubscriptions {
  WebSocketSubscriptions(this.ws, this.symbolConversion) {
    // Listen for WebSocket messages
    ws.on(WebSocketEvent.message, _handleMessage);

    // Listen for reconnection events to resubscribe
    ws.on(WebSocketEvent.reconnect, _resubscribeAll);

    // Clean up on disconnect
    ws.on(WebSocketEvent.close, _handleDisconnect);
  }
  final WebSocketClient ws;
  final SymbolConversion symbolConversion;
  final Logger _logger = Logger();

  // POST request handling
  final Map<String, Completer<dynamic>> _pendingRequests = {};
  int _requestIdCounter = 0;

  // Subscription management
  final Map<String, Set<Function>> _activeSubscriptions = {};
  final Map<String, Map<String, dynamic>> _subscriptionDetails = {};

  void _handleMessage(dynamic message) {
    if (message is Map<String, dynamic>) {
      try {
        // Handle POST request responses
        if (message.containsKey('id') && message.containsKey('response')) {
          final requestId = message['id'].toString();
          final completer = _pendingRequests.remove(requestId);
          if (completer != null) {
            if (message.containsKey('error')) {
              completer.completeError(Exception('WebSocket POST error: ${message['error']}'));
            } else {
              completer.complete(message['response']);
            }
          }
          return;
        }

        // Handle subscription data
        if (message.containsKey('channel') && message.containsKey('data')) {
          final channel = message['channel'] as String;
          final data = message['data'];
          _notifySubscribers(channel, data);
          return;
        }

        // Handle other message types
        _logger.d('Received unhandled message: ${message.keys.join(', ')}');
      } catch (e) {
        _logger.e('Error handling WebSocket message: $e');
      }
    }
  }

  /// Notify subscribers of new data
  void _notifySubscribers(String channel, dynamic data) {
    final subscribers = _activeSubscriptions[channel];
    if (subscribers != null) {
      for (final callback in subscribers) {
        try {
          callback(data);
        } catch (e) {
          _logger.e('Error in subscription callback for $channel: $e');
        }
      }
    }
  }

  /// Handle reconnection - resubscribe to all channels
  void _resubscribeAll() {
    _logger.i('Resubscribing to ${_subscriptionDetails.length} channels after reconnection');

    for (final entry in _subscriptionDetails.entries) {
      final channel = entry.key;
      final details = entry.value;

      try {
        _sendSubscriptionMessage(details);
        _logger.d('Resubscribed to channel: $channel');
      } catch (e) {
        _logger.e('Failed to resubscribe to $channel: $e');
      }
    }
  }

  /// Handle disconnect - clean up state
  void _handleDisconnect() {
    // Complete all pending requests with error
    for (final completer in _pendingRequests.values) {
      if (!completer.isCompleted) {
        completer.completeError(Exception('WebSocket disconnected'));
      }
    }
    _pendingRequests.clear();

    _logger.d('Cleaned up ${_pendingRequests.length} pending requests on disconnect');
  }

  /// Send subscription message
  void _sendSubscriptionMessage(Map<String, dynamic> subscriptionDetails) {
    ws.sendMessage(subscriptionDetails);
  }

  /// Send a POST request via WebSocket
  ///
  /// [requestType] - The type of request ('info' or 'action')
  /// [payload] - The payload to send with the request
  /// [timeout] - Optional timeout in milliseconds (default: 30000)
  ///
  /// Returns a promise that resolves with the response data
  Future<dynamic> postRequest(
    String requestType,
    Map<String, dynamic> payload, [
    int timeout = 30000,
  ]) async {
    // Ensure WebSocket is connected
    if (!ws.isConnected()) {
      throw Exception('WebSocket is not connected');
    }

    // Generate unique request ID
    final requestId = (++_requestIdCounter).toString();

    // Create completer for the response
    final completer = Completer<dynamic>();
    _pendingRequests[requestId] = completer;

    // Set up timeout
    Timer(Duration(milliseconds: timeout), () {
      final pendingCompleter = _pendingRequests.remove(requestId);
      if (pendingCompleter != null && !pendingCompleter.isCompleted) {
        pendingCompleter.completeError(Exception('WebSocket POST request timeout'));
      }
    });

    try {
      // Send the POST request
      final message = {
        'method': 'post',
        'id': requestId,
        'request': {
          'type': requestType,
          ...payload,
        },
      };

      ws.sendMessage(message);

      // Wait for response
      return await completer.future;
    } catch (error) {
      _pendingRequests.remove(requestId);
      rethrow;
    }
  }

  /// Subscribe to a channel
  Future<void> subscribe(String channel, Function callback, [Map<String, dynamic>? params]) async {
    if (!ws.canAddSubscription()) {
      throw Exception('Maximum subscription limit reached');
    }

    // Add callback to active subscriptions
    _activeSubscriptions.putIfAbsent(channel, () => <Function>{}).add(callback);

    // Store subscription details for reconnection
    final subscriptionMessage = {
      'method': 'subscribe',
      'subscription': {
        'type': channel,
        if (params != null) ...params,
      },
    };

    _subscriptionDetails[channel] = subscriptionMessage;

    // Send subscription message
    try {
      _sendSubscriptionMessage(subscriptionMessage);
      ws.incrementSubscriptionCount();
      _logger.i('Subscribed to channel: $channel');
    } catch (e) {
      // Clean up on failure
      _activeSubscriptions[channel]?.remove(callback);
      if (_activeSubscriptions[channel]?.isEmpty == true) {
        _activeSubscriptions.remove(channel);
        _subscriptionDetails.remove(channel);
      }
      rethrow;
    }
  }

  /// Unsubscribe from a channel
  Future<void> unsubscribe(String channel, [Function? callback]) async {
    if (callback != null) {
      // Remove specific callback
      _activeSubscriptions[channel]?.remove(callback);
      if (_activeSubscriptions[channel]?.isEmpty == true) {
        _activeSubscriptions.remove(channel);
      }
    } else {
      // Remove all callbacks for channel
      _activeSubscriptions.remove(channel);
    }

    // If no more callbacks, unsubscribe from server
    if (!_activeSubscriptions.containsKey(channel)) {
      _subscriptionDetails.remove(channel);

      try {
        ws.sendMessage({
          'method': 'unsubscribe',
          'subscription': {'type': channel},
        });
        ws.decrementSubscriptionCount();
        _logger.i('Unsubscribed from channel: $channel');
      } catch (e) {
        _logger.e('Error unsubscribing from $channel: $e');
      }
    }
  }

  /// Unsubscribe from all channels
  Future<void> unsubscribeAll() async {
    final channels = List<String>.from(_activeSubscriptions.keys);
    for (final channel in channels) {
      await unsubscribe(channel);
    }
  }

  /// Subscribe to all mids updates
  Future<void> subscribeToAllMids(Function callback) async {
    await subscribe('allMids', callback);
  }

  /// Unsubscribe from all mids updates
  Future<void> unsubscribeFromAllMids() async {
    await unsubscribe('allMids');
  }

  /// Subscribe to user notifications
  Future<void> subscribeToNotification(String user, Function callback) async {
    await subscribe('notification', callback, {'user': user});
  }

  /// Unsubscribe from user notifications
  Future<void> unsubscribeFromNotification(String user) async {
    await unsubscribe('notification');
  }

  /// Subscribe to web data 2 updates
  Future<void> subscribeToWebData2(String user, Function callback) async {
    await subscribe('webData2', callback, {'user': user});
  }

  /// Unsubscribe from web data 2 updates
  Future<void> unsubscribeFromWebData2(String user) async {
    await unsubscribe('webData2');
  }

  /// Subscribe to candle updates
  Future<void> subscribeToCandle(String coin, String interval, Function callback) async {
    // For WebSocket subscriptions, use the coin symbol directly without conversion
    // The API expects the raw symbol name (e.g., "BTC") not the converted internal name
    await subscribe('candle', callback, {'coin': coin, 'interval': interval});
  }

  /// Unsubscribe from candle updates
  Future<void> unsubscribeFromCandle(String coin, String interval) async {
    await unsubscribe('candle');
  }

  /// Subscribe to L2 order book updates
  Future<void> subscribeToL2Book(String coin, Function callback) async {
    // For WebSocket subscriptions, use the coin symbol directly without conversion
    await subscribe('l2Book', callback, {'coin': coin});
  }

  /// Unsubscribe from L2 order book updates
  Future<void> unsubscribeFromL2Book(String coin) async {
    await unsubscribe('l2Book');
  }

  /// Subscribe to trades
  Future<void> subscribeToTrades(String coin, Function callback) async {
    // For WebSocket subscriptions, use the coin symbol directly without conversion
    await subscribe('trades', callback, {'coin': coin});
  }

  /// Unsubscribe from trades
  Future<void> unsubscribeFromTrades(String coin) async {
    await unsubscribe('trades');
  }

  /// Subscribe to order updates
  Future<void> subscribeToOrderUpdates(String user, Function callback) async {
    await subscribe('orderUpdates', callback, {'user': user});
  }

  /// Unsubscribe from order updates
  Future<void> unsubscribeFromOrderUpdates(String user) async {
    await unsubscribe('orderUpdates');
  }

  /// Subscribe to user events
  Future<void> subscribeToUserEvents(String user, Function callback) async {
    await subscribe('userEvents', callback, {'user': user});
  }

  /// Unsubscribe from user events
  Future<void> unsubscribeFromUserEvents(String user) async {
    await unsubscribe('userEvents');
  }

  /// Subscribe to user fills
  Future<void> subscribeToUserFills(String user, Function callback) async {
    await subscribe('userFills', callback, {'user': user});
  }

  /// Unsubscribe from user fills
  Future<void> unsubscribeFromUserFills(String user) async {
    await unsubscribe('userFills');
  }

  /// Subscribe to user fundings
  Future<void> subscribeToUserFundings(String user, Function callback) async {
    await subscribe('userFundings', callback, {'user': user});
  }

  /// Unsubscribe from user fundings
  Future<void> unsubscribeFromUserFundings(String user) async {
    await unsubscribe('userFundings');
  }

  /// Subscribe to user non-funding ledger updates
  Future<void> subscribeToUserNonFundingLedgerUpdates(String user, Function callback) async {
    await subscribe('userNonFundingLedgerUpdates', callback, {'user': user});
  }

  /// Unsubscribe from user non-funding ledger updates
  Future<void> unsubscribeFromUserNonFundingLedgerUpdates(String user) async {
    await unsubscribe('userNonFundingLedgerUpdates');
  }

  /// Subscribe to user active asset data
  Future<void> subscribeToUserActiveAssetData(String user, String coin, Function callback) async {
    // For WebSocket subscriptions, use the coin symbol directly without conversion
    await subscribe('activeAssetData', callback, {'user': user, 'coin': coin});
  }

  /// Unsubscribe from user active asset data
  Future<void> unsubscribeFromUserActiveAssetData(String user, String coin) async {
    await unsubscribe('activeAssetData');
  }

  /// Subscribe to active asset context
  Future<void> subscribeToActiveAssetCtx(String coin, Function callback) async {
    // For WebSocket subscriptions, use the coin symbol directly without conversion
    await subscribe('activeAssetCtx', callback, {'coin': coin});
  }

  /// Unsubscribe from active asset context
  Future<void> unsubscribeFromActiveAssetCtx(String coin) async {
    await unsubscribe('activeAssetCtx');
  }

  /// Subscribe to TWAP history
  Future<void> subscribeToTwapHistory(String user, Function callback) async {
    await subscribe('twapHistory', callback, {'user': user});
  }

  /// Unsubscribe from TWAP history
  Future<void> unsubscribeFromTwapHistory(String user) async {
    await unsubscribe('twapHistory');
  }

  /// Subscribe to TWAP slice fills
  Future<void> subscribeToTwapSliceFills(String user, Function callback) async {
    await subscribe('twapSliceFills', callback, {'user': user});
  }

  /// Unsubscribe from TWAP slice fills
  Future<void> unsubscribeFromTwapSliceFills(String user) async {
    await unsubscribe('twapSliceFills');
  }

  /// Subscribe to active spot asset context
  /// Provides real-time context for spot trading assets
  Future<void> subscribeToActiveSpotAssetCtx(String coin, Function callback) async {
    // For WebSocket subscriptions, use the coin symbol directly without conversion
    await subscribe('activeSpotAssetCtx', callback, {'coin': coin});
  }

  /// Unsubscribe from active spot asset context
  Future<void> unsubscribeFromActiveSpotAssetCtx(String coin) async {
    await unsubscribe('activeSpotAssetCtx');
  }

  /// Subscribe to user TWAP slice fills
  /// Provides real-time TWAP execution updates for user
  Future<void> subscribeToUserTwapSliceFills(String user, Function callback) async {
    await subscribe('userTwapSliceFills', callback, {'user': user});
  }

  /// Unsubscribe from user TWAP slice fills
  Future<void> unsubscribeFromUserTwapSliceFills(String user) async {
    await unsubscribe('userTwapSliceFills');
  }

  /// Subscribe to user TWAP history
  /// Provides TWAP order history updates for user
  Future<void> subscribeToUserTwapHistory(String user, Function callback) async {
    await subscribe('userTwapHistory', callback, {'user': user});
  }

  /// Unsubscribe from user TWAP history
  Future<void> unsubscribeFromUserTwapHistory(String user) async {
    await unsubscribe('userTwapHistory');
  }

  // ==================== ADDITIONAL SUBSCRIPTION TYPES ====================

  /// Subscribe to BBO (Best Bid/Offer) stream
  /// This provides the best bid and offer prices for a specific coin
  Future<void> subscribeToBBO(String coin, Function callback) async {
    // For WebSocket subscriptions, use the coin symbol directly without conversion
    await subscribe('bbo', callback, {'coin': coin});
  }

  /// Unsubscribe from BBO stream
  Future<void> unsubscribeFromBBO(String coin) async {
    await unsubscribe('bbo');
  }

  /// Subscribe to user positions
  /// Provides real-time updates on user position changes
  Future<void> subscribeToUserPositions(String user, Function callback) async {
    await subscribe('userPositions', callback, {'user': user});
  }

  /// Unsubscribe from user positions
  Future<void> unsubscribeFromUserPositions(String user) async {
    await unsubscribe('userPositions');
  }

  /// Subscribe to user balance updates
  /// Provides real-time balance changes for cross/isolated margin
  Future<void> subscribeToUserBalances(String user, Function callback) async {
    await subscribe('userBalances', callback, {'user': user});
  }

  /// Unsubscribe from user balance updates
  Future<void> unsubscribeFromUserBalances(String user) async {
    await unsubscribe('userBalances');
  }

  /// Subscribe to market mid-price for a specific coin
  /// Alternative to allMids for single coin tracking
  Future<void> subscribeToMid(String coin, Function callback) async {
    // For WebSocket subscriptions, use the coin symbol directly without conversion
    await subscribe('mid', callback, {'coin': coin});
  }

  /// Unsubscribe from specific coin mid-price
  Future<void> unsubscribeFromMid(String coin) async {
    await unsubscribe('mid');
  }

  /// Subscribe to user funding history
  /// Provides real-time funding payments for perpetual positions
  Future<void> subscribeToUserFundingHistory(String user, Function callback) async {
    await subscribe('userFundingHistory', callback, {'user': user});
  }

  /// Unsubscribe from user funding history
  Future<void> unsubscribeFromUserFundingHistory(String user) async {
    await unsubscribe('userFundingHistory');
  }

  /// Subscribe to oracle prices
  /// Provides oracle price data for mark price calculations
  Future<void> subscribeToOraclePrices(String coin, Function callback) async {
    // For WebSocket subscriptions, use the coin symbol directly without conversion
    await subscribe('oraclePrices', callback, {'coin': coin});
  }

  /// Unsubscribe from oracle prices
  Future<void> unsubscribeFromOraclePrices(String coin) async {
    await unsubscribe('oraclePrices');
  }

  /// Subscribe to funding rates
  /// Provides real-time funding rate updates
  Future<void> subscribeToFundingRates(String coin, Function callback) async {
    // For WebSocket subscriptions, use the coin symbol directly without conversion
    await subscribe('fundingRates', callback, {'coin': coin});
  }

  /// Unsubscribe from funding rates
  Future<void> unsubscribeFromFundingRates(String coin) async {
    await unsubscribe('fundingRates');
  }

  /// Subscribe to liquidation events
  /// Provides real-time liquidation data for market analysis
  Future<void> subscribeToLiquidations(String coin, Function callback) async {
    // For WebSocket subscriptions, use the coin symbol directly without conversion
    await subscribe('liquidations', callback, {'coin': coin});
  }

  /// Unsubscribe from liquidation events
  Future<void> unsubscribeFromLiquidations(String coin) async {
    await unsubscribe('liquidations');
  }

  /// Subscribe to order book snapshots
  /// Provides periodic full order book snapshots
  Future<void> subscribeToOrderBookSnapshot(String coin, Function callback, {int? nSigFigs, int? mantissa}) async {
    // For WebSocket subscriptions, use the coin symbol directly without conversion
    final params = <String, dynamic>{'coin': coin};

    if (nSigFigs != null) params['nSigFigs'] = nSigFigs;
    if (mantissa != null) params['mantissa'] = mantissa;

    await subscribe('orderBookSnapshot', callback, params);
  }

  /// Unsubscribe from order book snapshots
  Future<void> unsubscribeFromOrderBookSnapshot(String coin) async {
    await unsubscribe('orderBookSnapshot');
  }

  /// Get list of active subscriptions
  List<String> getActiveSubscriptions() {
    return _activeSubscriptions.keys.toList();
  }

  /// Get subscription count
  int getSubscriptionCount() {
    return _activeSubscriptions.length;
  }

  /// Check if WebSocket is connected
  bool isConnected() {
    return ws.isConnected();
  }

  /// Get WebSocket connection statistics
  Map<String, dynamic> getConnectionStats() {
    return {
      ...ws.getConnectionStats(),
      'activeSubscriptions': _activeSubscriptions.length,
      'subscriptionChannels': _activeSubscriptions.keys.toList(),
    };
  }

  /// Disconnect and clean up
  void disconnect() {
    // Complete all pending requests with error
    for (final completer in _pendingRequests.values) {
      if (!completer.isCompleted) {
        completer.completeError(Exception('WebSocket disconnected'));
      }
    }
    _pendingRequests.clear();

    // Clear subscriptions
    _activeSubscriptions.clear();
    _subscriptionDetails.clear();

    _logger.i('WebSocket subscriptions cleaned up');
  }
}
