import 'package:hyperliquid/hyperliquid.dart';

/// Example demonstrating WebSocket subscription functionality
///
/// This example shows how to subscribe to real-time market data using the
/// corrected WebSocket subscription methods that properly handle symbol names.
///
/// ⚠️ WARNING: This example uses testnet. Always test thoroughly
/// before using on mainnet with real funds.
void main() async {
  // Initialize the SDK with WebSocket enabled
  final client = Hyperliquid(const HyperliquidConfig(
    testnet: true, // Always use testnet for examples
    enableWs: true, // Enable WebSocket for real-time data
  ));

  try {
    print('🚀 Initializing Hyperliquid SDK with WebSocket Subscriptions...');
    await client.connect();

    print('✅ Successfully connected to Hyperliquid!');
    print('📡 WebSocket subscriptions available: ${client.enableWs}');

    // Example 1: Subscribe to all market prices
    print('\n📊 Example 1: All Market Prices...');
    await client.subscriptions.subscribeToAllMids((data) {
      print('   📈 All mids updated - BTC: \$${data.mids['BTC-PERP'] ?? 'N/A'}');
    });

    // Example 2: Subscribe to BTC trades
    print('\n🔄 Example 2: BTC Trade Stream...');
    await client.subscriptions.subscribeToTrades('BTC', (data) {
      print('   💰 BTC Trade data received');
    });

    // Example 3: Subscribe to BTC order book
    print('\n📋 Example 3: BTC Order Book...');
    await client.subscriptions.subscribeToL2Book('BTC', (data) {
      print('   📊 BTC Order Book update received');
    });

    // Example 4: Subscribe to BTC candles (15-minute)
    print('\n🕯️ Example 4: BTC Candles (15m)...');
    await client.subscriptions.subscribeToCandle('BTC', '15m', (data) {
      print('   📈 BTC 15m Candle: O:\$${data.o} H:\$${data.h} L:\$${data.l} C:\$${data.c}');
    });

    // Example 5: Subscribe to BTC BBO (Best Bid/Offer)
    print('\n🎯 Example 5: BTC BBO Stream...');
    await client.subscriptions.subscribeToBBO('BTC', (data) {
      print('   🎯 BTC BBO: Bid \$${data.bidPx} (${data.bidSz}) | Ask \$${data.askPx} (${data.askSz})');
    });

    // Example 6: Subscribe to funding rates
    print('\n💰 Example 6: BTC Funding Rates...');
    await client.subscriptions.subscribeToFundingRates('BTC', (data) {
      print('   💸 BTC Funding Rate: ${data.fundingRate}');
    });

    // Example 7: Subscribe to liquidations
    print('\n⚠️ Example 7: BTC Liquidations...');
    await client.subscriptions.subscribeToLiquidations('BTC', (data) {
      print('   🚨 BTC Liquidation data received');
    });

    // Example 8: Subscribe to oracle prices
    print('\n🔮 Example 8: BTC Oracle Prices...');
    await client.subscriptions.subscribeToOraclePrices('BTC', (data) {
      print('   🔮 BTC Oracle Price: \$${data.price}');
    });

    // Example 9: Multiple asset subscriptions
    print('\n🌟 Example 9: Multi-Asset Subscriptions...');
    await client.subscriptions.subscribeToTrades('ETH', (data) {
      print('   💎 ETH Trade data received');
    });

    await client.subscriptions.subscribeToCandle('ETH', '5m', (data) {
      print('   📊 ETH 5m Candle: \$${data.c}');
    });

    // Example 10: User-specific subscriptions (requires authentication)
    if (client.isAuthenticated() && client.walletAddress != null) {
      print('\n👤 Example 10: User-Specific Subscriptions...');

      await client.subscriptions.subscribeToUserEvents(client.walletAddress!, (data) {
        print('   📨 User Event: ${data.type}');
      });

      await client.subscriptions.subscribeToUserFills(client.walletAddress!, (data) {
        print('   💰 User Fill: ${data.length} fills');
      });

      await client.subscriptions.subscribeToUserPositions(client.walletAddress!, (data) {
        print('   📊 Position Update: ${data.length} positions');
      });
    } else {
      print('\n👤 Example 10: User subscriptions skipped (not authenticated)');
    }

    // Wait for real-time data
    print('\n⏳ Listening for real-time data (30 seconds)...');
    print('   You should see market data updates above...');

    await Future<void>.delayed(const Duration(seconds: 30));

    // Example 11: Subscription management
    print('\n🔧 Example 11: Subscription Management...');
    final activeSubs = client.subscriptions.getActiveSubscriptions();
    final subCount = client.subscriptions.getSubscriptionCount();

    print('   📊 Active subscriptions: $activeSubs');
    print('   🔢 Subscription count: $subCount');

    // Get connection statistics
    final connectionStats = client.subscriptions.getConnectionStats();
    print('   📡 Connection stats: $connectionStats');

    // Example 12: Selective unsubscription
    print('\n🗑️ Example 12: Selective Unsubscription...');
    await client.subscriptions.unsubscribeFromTrades('ETH');
    await client.subscriptions.unsubscribeFromCandle('ETH', '5m');
    print('   ✅ Unsubscribed from ETH trades and candles');

    // Wait a bit more to see remaining subscriptions
    await Future<void>.delayed(const Duration(seconds: 10));

    print('\n✅ WebSocket subscription example completed successfully!');
    print('');
    print('🚨 IMPORTANT NOTES:');
    print('- WebSocket subscriptions provide real-time market data');
    print('- All subscription methods now use raw coin symbols (e.g., "BTC" not "BTC-PERP")');
    print('- The 422 error has been fixed by removing incorrect symbol conversion');
    print('- Subscriptions automatically reconnect on connection loss');
    print('- Always unsubscribe from unused subscriptions to free up connection resources');
    print('- Test on testnet before using on mainnet');
  } catch (e) {
    print('❌ Example failed: $e');
    print('Stack trace: ${StackTrace.current}');
  } finally {
    // Clean up
    print('\n🔌 Unsubscribing from all subscriptions...');
    await client.subscriptions.unsubscribeAll();

    print('🔌 Disconnecting from Hyperliquid...');
    client.disconnect();
    print('✅ Disconnected successfully');
  }
}

/// Helper function demonstrating subscription patterns
void demonstrateSubscriptionPatterns() {
  print('\n📚 WebSocket Subscription Patterns:');

  print('\n1. Market Data Subscriptions:');
  print('   - subscribeToAllMids() - All asset prices');
  print('   - subscribeToTrades(coin) - Trade stream for specific coin');
  print('   - subscribeToL2Book(coin) - Order book for specific coin');
  print('   - subscribeToCandle(coin, interval) - Candlestick data');
  print('   - subscribeToBBO(coin) - Best bid/offer stream');

  print('\n2. Advanced Market Data:');
  print('   - subscribeToFundingRates(coin) - Funding rate updates');
  print('   - subscribeToLiquidations(coin) - Liquidation events');
  print('   - subscribeToOraclePrices(coin) - Oracle price feeds');

  print('\n3. User-Specific Data (requires authentication):');
  print('   - subscribeToUserEvents(user) - Order/fill/liquidation events');
  print('   - subscribeToUserFills(user) - Fill notifications');
  print('   - subscribeToUserPositions(user) - Position updates');
  print('   - subscribeToUserBalances(user) - Balance changes');

  print('\n4. Subscription Management:');
  print('   - getActiveSubscriptions() - List active subscriptions');
  print('   - getSubscriptionCount() - Get subscription count');
  print('   - unsubscribeFrom[Type]() - Unsubscribe from specific feed');
  print('   - unsubscribeAll() - Unsubscribe from everything');

  print('\n5. Connection Monitoring:');
  print('   - getConnectionStats() - Connection health metrics');
  print('   - WebSocket events - Connection state changes');
}

/// Helper function demonstrating error handling patterns
void demonstrateErrorHandling() {
  print('\n🛡️ Error Handling Patterns:');

  print('\n1. Connection Errors:');
  print('   try {');
  print('     await client.subscriptions.subscribeToTrades("BTC", callback);');
  print('   } catch (e) {');
  print('     print("Subscription failed: \$e");');
  print('     // Handle reconnection or fallback logic');
  print('   }');

  print('\n2. Invalid Parameters:');
  print('   try {');
  print('     await client.subscriptions.subscribeToCandle("INVALID", "1m", callback);');
  print('   } catch (e) {');
  print('     print("Invalid coin or interval: \$e");');
  print('   }');

  print('\n3. Rate Limiting:');
  print('   // SDK handles rate limiting automatically');
  print('   // Monitor connection stats for rate limit issues');

  print('\n4. Network Issues:');
  print('   // SDK automatically reconnects on network issues');
  print('   // Monitor WebSocket events for reconnection status');
}
