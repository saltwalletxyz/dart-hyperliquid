import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:logger/logger.dart';
import '../constants.dart';

/// WebSocket connection states
enum WebSocketState {
  disconnected,
  connecting,
  connected,
  reconnecting,
  error,
}

/// WebSocket event types
enum WebSocketEvent {
  open,
  close,
  error,
  message,
  reconnect,
  maxReconnectAttemptsReached,
  manualDisconnect,
  ping,
  pong,
}

/// Production-grade WebSocket client with advanced features
class WebSocketClient {
  final bool testnet;
  final int maxReconnectAttempts;
  final Logger _logger = Logger();

  // Connection management
  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _messageSubscription;
  WebSocketState _state = WebSocketState.disconnected;
  bool _manualDisconnect = false;

  // Reconnection logic
  int _reconnectAttempts = 0;
  final int _initialReconnectDelay = 1000; // 1 second
  final int _maxReconnectDelay = 30000; // 30 seconds
  Timer? _reconnectTimer;

  // Heartbeat mechanism
  Timer? _pingTimer;
  Timer? _pongTimeoutTimer;
  DateTime? _lastPongReceived;
  final int _pingInterval = 15000; // 15 seconds
  final int _pongTimeout = 30000; // 30 seconds

  // Subscription management
  int _subscriptionCount = 0;
  final int _maxSubscriptions = 1000; // API limit

  // Event handling
  final Map<WebSocketEvent, Set<Function>> _eventHandlers = {};

  // Message queue for offline messages
  final List<Map<String, dynamic>> _messageQueue = [];
  final int _maxQueueSize = 100;
  bool _queueEnabled = true;

  WebSocketClient(this.testnet, this.maxReconnectAttempts) {
    _logger.d('WebSocketClient initialized - testnet: $testnet, maxReconnectAttempts: $maxReconnectAttempts');
  }

  /// Current connection state
  WebSocketState get state => _state;

  /// Check if connected
  bool isConnected() => _state == WebSocketState.connected && _channel != null;

  /// Check if connecting
  bool isConnecting() => _state == WebSocketState.connecting;

  /// Check if reconnecting
  bool isReconnecting() => _state == WebSocketState.reconnecting;

  /// Get current subscription count
  int get subscriptionCount => _subscriptionCount;

  /// Check if can add more subscriptions
  bool canAddSubscription() => _subscriptionCount < _maxSubscriptions;

  /// Increment subscription count
  bool incrementSubscriptionCount() {
    if (_subscriptionCount < _maxSubscriptions) {
      _subscriptionCount++;
      _logger.d('Subscription count incremented to $_subscriptionCount');
      return true;
    }
    _logger.w('Maximum subscription limit reached: $_maxSubscriptions');
    return false;
  }

  /// Decrement subscription count
  void decrementSubscriptionCount() {
    if (_subscriptionCount > 0) {
      _subscriptionCount--;
      _logger.d('Subscription count decremented to $_subscriptionCount');
    }
  }

  /// Add event listener
  void on(WebSocketEvent event, Function handler) {
    _eventHandlers.putIfAbsent(event, () => <Function>{}).add(handler);
  }

  /// Remove event listener
  void off(WebSocketEvent event, Function handler) {
    _eventHandlers[event]?.remove(handler);
  }

  /// Emit event to all listeners
  void _emit(WebSocketEvent event, [dynamic data]) {
    final handlers = _eventHandlers[event];
    if (handlers != null) {
      for (final handler in handlers) {
        try {
          if (data != null) {
            handler(data);
          } else {
            handler();
          }
        } catch (e) {
          _logger.e('Error in event handler for $event: $e');
        }
      }
    }
  }

  /// Connect to WebSocket
  Future<void> connect() async {
    if (_state == WebSocketState.connecting || _state == WebSocketState.connected) {
      _logger.w('Already connecting or connected');
      return;
    }

    _setState(WebSocketState.connecting);
    _manualDisconnect = false;

    try {
      final url = testnet ? WssUrls.testnet : WssUrls.production;
      _logger.i('Connecting to WebSocket: $url');

      _channel = WebSocketChannel.connect(Uri.parse(url));

      // Set up message listener
      _messageSubscription = _channel!.stream.listen(
        _onMessage,
        onError: _onError,
        onDone: _onClose,
      );

      // Wait for connection to be established
      await Future<void>.delayed(const Duration(milliseconds: 100));

      _setState(WebSocketState.connected);
      _reconnectAttempts = 0;
      _lastPongReceived = DateTime.now();

      _startHeartbeat();
      _processMessageQueue();

      _emit(WebSocketEvent.open);
      _logger.i('WebSocket connected successfully');
    } catch (error) {
      _setState(WebSocketState.error);
      _logger.e('Failed to connect to WebSocket: $error');
      _emit(WebSocketEvent.error, error);

      if (!_manualDisconnect) {
        _scheduleReconnect();
      }
      rethrow;
    }
  }

  /// Set connection state
  void _setState(WebSocketState newState) {
    if (_state != newState) {
      final oldState = _state;
      _state = newState;
      _logger.d('WebSocket state changed: $oldState -> $newState');
    }
  }

  /// Handle incoming messages
  void _onMessage(dynamic message) {
    try {
      final decoded = jsonDecode(message.toString());
      _lastPongReceived = DateTime.now();

      // Handle pong messages
      if (decoded is Map<String, dynamic> && decoded['method'] == 'pong') {
        _emit(WebSocketEvent.pong);
        return;
      }

      _emit(WebSocketEvent.message, decoded);
    } catch (e) {
      _logger.e('Error decoding WebSocket message: $e');
    }
  }

  /// Handle WebSocket errors
  void _onError(Object error) {
    _logger.e('WebSocket error: $error');
    _setState(WebSocketState.error);
    _emit(WebSocketEvent.error, error);

    if (!_manualDisconnect) {
      _scheduleReconnect();
    }
  }

  /// Handle WebSocket close
  void _onClose() {
    _logger.i('WebSocket connection closed');
    _setState(WebSocketState.disconnected);
    _stopHeartbeat();
    _emit(WebSocketEvent.close);

    if (!_manualDisconnect) {
      _scheduleReconnect();
    } else {
      _emit(WebSocketEvent.manualDisconnect);
    }
  }

  /// Send message to WebSocket
  void sendMessage(Map<String, dynamic> message) {
    if (!isConnected()) {
      if (_queueEnabled && _messageQueue.length < _maxQueueSize) {
        _messageQueue.add(message);
        _logger.d('Message queued (not connected): ${message['method'] ?? 'unknown'}');
        return;
      } else {
        throw Exception('WebSocket is not connected and message queue is full or disabled');
      }
    }

    try {
      final jsonMessage = jsonEncode(message);
      _channel!.sink.add(jsonMessage);
      _logger.d('Message sent: ${message['method'] ?? 'unknown'}');
    } catch (e) {
      _logger.e('Error sending message: $e');
      throw Exception('Failed to send WebSocket message: $e');
    }
  }

  /// Process queued messages
  void _processMessageQueue() {
    if (_messageQueue.isNotEmpty) {
      _logger.i('Processing ${_messageQueue.length} queued messages');
      final messages = List<Map<String, dynamic>>.from(_messageQueue);
      _messageQueue.clear();

      for (final message in messages) {
        try {
          sendMessage(message);
        } catch (e) {
          _logger.e('Error processing queued message: $e');
        }
      }
    }
  }

  /// Start heartbeat mechanism
  void _startHeartbeat() {
    _stopHeartbeat(); // Clear any existing timers

    _pingTimer = Timer.periodic(Duration(milliseconds: _pingInterval), (timer) {
      if (isConnected()) {
        _sendPing();
        _checkPongTimeout();
      }
    });
  }

  /// Stop heartbeat mechanism
  void _stopHeartbeat() {
    _pingTimer?.cancel();
    _pingTimer = null;
    _pongTimeoutTimer?.cancel();
    _pongTimeoutTimer = null;
  }

  /// Send ping message
  void _sendPing() {
    try {
      sendMessage({'method': 'ping'});
      _emit(WebSocketEvent.ping);
    } catch (e) {
      _logger.e('Error sending ping: $e');
    }
  }

  /// Check if pong timeout occurred
  void _checkPongTimeout() {
    if (_lastPongReceived != null) {
      final timeSinceLastPong = DateTime.now().difference(_lastPongReceived!).inMilliseconds;
      if (timeSinceLastPong > _pongTimeout) {
        _logger.w('Pong timeout detected, reconnecting...');
        _reconnectDueToPongTimeout();
      }
    }
  }

  /// Reconnect due to pong timeout
  void _reconnectDueToPongTimeout() {
    close(false); // Close without marking as manual
    _scheduleReconnect();
  }

  /// Schedule reconnection with exponential backoff
  void _scheduleReconnect() {
    if (_manualDisconnect || _reconnectAttempts >= maxReconnectAttempts) {
      if (_reconnectAttempts >= maxReconnectAttempts) {
        _logger.e('Maximum reconnection attempts reached: $maxReconnectAttempts');
        _emit(WebSocketEvent.maxReconnectAttemptsReached);
      }
      return;
    }

    _setState(WebSocketState.reconnecting);
    _reconnectAttempts++;

    final delay = min(
      _initialReconnectDelay * pow(2, _reconnectAttempts - 1).toInt(),
      _maxReconnectDelay,
    );

    _logger.i('Scheduling reconnection attempt $_reconnectAttempts/$maxReconnectAttempts in ${delay}ms');

    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(Duration(milliseconds: delay), () {
      _attemptReconnect();
    });
  }

  /// Attempt to reconnect
  Future<void> _attemptReconnect() async {
    try {
      await connect();
      _emit(WebSocketEvent.reconnect);
      _logger.i('Reconnection successful');
    } catch (e) {
      _logger.e('Reconnection attempt failed: $e');
      _scheduleReconnect();
    }
  }

  /// Close WebSocket connection
  void close([bool manual = true]) {
    _manualDisconnect = manual;
    _logger.i('Closing WebSocket connection (manual: $manual)');

    _stopHeartbeat();
    _reconnectTimer?.cancel();
    _reconnectTimer = null;

    _messageSubscription?.cancel();
    _messageSubscription = null;

    _channel?.sink.close();
    _channel = null;

    _setState(WebSocketState.disconnected);

    if (manual) {
      _emit(WebSocketEvent.manualDisconnect);
    }
  }

  /// Enable/disable message queuing
  void setMessageQueueEnabled(bool enabled) {
    _queueEnabled = enabled;
    if (!enabled) {
      _messageQueue.clear();
    }
  }

  /// Clear message queue
  void clearMessageQueue() {
    _messageQueue.clear();
  }

  /// Get connection statistics
  Map<String, dynamic> getConnectionStats() {
    return {
      'state': _state.toString(),
      'reconnectAttempts': _reconnectAttempts,
      'maxReconnectAttempts': maxReconnectAttempts,
      'subscriptionCount': _subscriptionCount,
      'maxSubscriptions': _maxSubscriptions,
      'queuedMessages': _messageQueue.length,
      'lastPongReceived': _lastPongReceived?.toIso8601String(),
      'isConnected': isConnected(),
    };
  }
}
