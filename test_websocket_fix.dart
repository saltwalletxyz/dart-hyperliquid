import 'dart:async';
import 'package:hyperliquid/hyperliquid.dart';
import 'package:logger/logger.dart';

Future<void> main() async {
  final logger = Logger();

  // Create Hyperliquid client with WebSocket enabled
  final client = Hyperliquid(const HyperliquidConfig(
    testnet: true, // Use testnet to match the CLI example
    enableWs: true,
  ));

  try {
    logger.i('Connecting to WebSocket...');
    await client.connect();

    if (!client.isWebSocketConnected()) {
      logger.e('Failed to connect to WebSocket');
      return;
    }

    logger.i('WebSocket connected successfully');

    // Subscribe to candle data for BTC with 15m interval
    logger.i('Subscribing to candle data for BTC 15m...');

    await client.subscriptions.subscribeToCandle('BTC', '15m', (data) {
      logger.i('Received candle data: $data');
    });

    logger.i('Subscription successful. Listening for data...');

    // Listen for 30 seconds to collect some data
    await Future.delayed(const Duration(seconds: 30));

    logger.i('Test completed. Disconnecting...');
  } catch (e) {
    logger.e('Error during WebSocket test: $e');
  } finally {
    client.disconnect();
    logger.i('Disconnected from WebSocket');
  }
}
