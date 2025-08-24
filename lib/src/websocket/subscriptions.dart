import 'dart:async';
import 'package:hyperliquid/src/websocket/websocket_client.dart';
import 'package:hyperliquid/src/utils/symbol_conversion.dart';
import 'package:logger/logger.dart';

class WebSocketSubscriptions {
  final WebSocketClient ws;
  final SymbolConversion symbolConversion;
  final Logger _logger = Logger();

  // POST request handling
  final Map<String, Completer<dynamic>> _pendingRequests = {};
  int _requestIdCounter = 0;

  // Subscription management
  final Map<String, Set<Function>> _activeSubscriptions = {};
  final Map<String, Map<String, dynamic>> _subscriptionDetails = {};

  WebSocketSubscriptions(this.ws, this.symbolConversion) {
    // Listen for WebSocket messages
    ws.on(WebSocketEvent.message, _handleMessage);

    // Listen for reconnection events to resubscribe
    ws.on(WebSocketEvent.reconnect, _resubscribeAll);

    // Clean up on disconnect
    ws.on(WebSocketEvent.close, _handleDisconnect);
  }

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
