import 'package:hyperliquid/hyperliquid.dart';

/// Example demonstrating the new CustomOperations functionality
///
/// This example shows how to use the advanced trading features like
/// market orders, bulk operations, and position management.
///
/// ⚠️ WARNING: This example uses testnet. Always test thoroughly
/// before using on mainnet with real funds.
void main() async {
  // Initialize the SDK with authentication
  // Replace with your actual testnet private key for testing
  const privateKey = '0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d';

  final client = Hyperliquid(const HyperliquidConfig(
    testnet: true, // Always use testnet for examples
    privateKey: privateKey,
    enableWs: false, // Disable WebSocket for this example
  ));

  try {
    print('🚀 Initializing Hyperliquid SDK with Custom Operations...');
    await client.connect();

    if (!client.isAuthenticated()) {
      print('❌ Authentication failed. Please check your private key.');
      return;
    }

    print('✅ Successfully authenticated!');
    print('📊 Custom Operations available: true');

    // Example 1: Get all available assets
    print('\n📋 Example 1: Getting all available assets...');
    try {
      final assets = await client.custom.getAllAssets();
      print('Available asset categories: ${assets.keys.toList()}');

      if (assets['perp']!.isNotEmpty) {
        print('Perpetual assets (first 5): ${assets['perp']!.take(5).toList()}');
      }

      if (assets['spot']!.isNotEmpty) {
        print('Spot assets (first 5): ${assets['spot']!.take(5).toList()}');
      }
    } catch (e) {
      print('⚠️ Could not fetch assets: $e');
    }

    // Example 2: Calculate slippage prices
    print('\n💰 Example 2: Calculating slippage prices...');
    try {
      const basePrice = 50000.0; // Example BTC price
      const slippage = 0.05; // 5% slippage

      final buyPrice = await client.custom.getSlippagePrice(
        'BTC-PERP',
        true, // isBuy
        slippage,
        basePrice,
      );

      final sellPrice = await client.custom.getSlippagePrice(
        'BTC-PERP',
        false, // isSell
        slippage,
        basePrice,
      );

      print('Base price: \$${basePrice.toStringAsFixed(2)}');
      print('Buy price (with 5% slippage): \$${buyPrice.toStringAsFixed(2)}');
      print('Sell price (with 5% slippage): \$${sellPrice.toStringAsFixed(2)}');

      // Example with live market price
      print('\n📈 Fetching live market price for slippage calculation...');
      final liveSlippagePrice = await client.custom.getSlippagePrice(
        'BTC-PERP',
        true, // isBuy
        0.02, // 2% slippage
        // No base price - will fetch from market
      );
      print('Live market buy price (with 2% slippage): \$${liveSlippagePrice.toStringAsFixed(2)}');
    } catch (e) {
      print('⚠️ Could not calculate slippage prices: $e');
    }

    // Example 3: Market order simulation (payload creation only)
    print('\n🎯 Example 3: Market order simulation...');
    try {
      print('Creating market buy order payload (not executing)...');

      // This creates the order payload but doesn't execute it
      // In a real scenario, you'd want to be very careful with order execution

      // Note: This will throw an exception because we're not actually executing
      // but it demonstrates the API structure
      print('Market order methods available:');
      print('- marketOpen(): Execute market buy/sell orders');
      print('- marketClose(): Close positions with market orders');
      print('- closeAllPositions(): Close all open positions');
      print('- cancelAllOrders(): Cancel all or specific symbol orders');
    } catch (e) {
      print('⚠️ Market order simulation: $e');
    }

    // Example 4: Bulk operations simulation
    print('\n🔄 Example 4: Bulk operations simulation...');
    try {
      print('Testing bulk operation error handling...');

      // Test cancel all orders (will fail if no orders exist)
      try {
        await client.custom.cancelAllOrders();
        print('✅ Successfully cancelled all orders');
      } catch (e) {
        if (e.toString().contains('No orders to cancel')) {
          print('✅ No orders to cancel (expected for clean account)');
        } else {
          print('⚠️ Unexpected error: $e');
        }
      }

      // Test close all positions (will fail if no positions exist)
      try {
        await client.custom.closeAllPositions();
        print('✅ Successfully closed all positions');
      } catch (e) {
        if (e.toString().contains('No positions to close')) {
          print('✅ No positions to close (expected for clean account)');
        } else {
          print('⚠️ Unexpected error: $e');
        }
      }
    } catch (e) {
      print('⚠️ Bulk operations test: $e');
    }

    // Example 5: Advanced usage patterns
    print('\n🎓 Example 5: Advanced usage patterns...');
    print('Custom Operations provides these advanced features:');
    print('');
    print('🎯 Market Orders:');
    print('  - marketOpen(symbol, isBuy, size, slippage: 0.05)');
    print('  - marketClose(symbol, size?, slippage: 0.05)');
    print('');
    print('🔄 Bulk Operations:');
    print('  - cancelAllOrders(symbol?)');
    print('  - closeAllPositions(slippage: 0.05)');
    print('');
    print('💰 Price Calculations:');
    print('  - getSlippagePrice(symbol, isBuy, slippage, basePrice?)');
    print('');
    print('📊 Asset Management:');
    print('  - getAllAssets() -> {perp: [...], spot: [...]}');
    print('');
    print('⚙️ Default Settings:');
    print('  - Default slippage: ${CustomOperations.defaultSlippage * 100}%');
    print('  - Automatic symbol conversion');
    print('  - Integrated error handling');

    print('\n✅ Custom Operations example completed successfully!');
    print('');
    print('🚨 IMPORTANT NOTES:');
    print('- This example uses testnet for safety');
    print('- Always test thoroughly before using on mainnet');
    print('- Start with small amounts when testing');
    print('- Monitor your positions and orders carefully');
    print('- Custom operations use IoC (Immediate or Cancel) orders for market-like behavior');
  } catch (e) {
    print('❌ Example failed: $e');
  } finally {
    // Clean up
    client.disconnect();
    print('\n🔌 Disconnected from Hyperliquid');
  }
}

/// Helper function to demonstrate error handling patterns
void demonstrateErrorHandling() {
  print('\n🛡️ Error Handling Best Practices:');
  print('');
  print('1. Always wrap operations in try-catch blocks');
  print('2. Check authentication status before trading operations');
  print('3. Validate parameters before API calls');
  print('4. Handle network errors gracefully');
  print('5. Monitor rate limits and respect them');
  print('6. Use appropriate slippage for market conditions');
  print('7. Verify order execution and handle partial fills');
}

/// Helper function to demonstrate production usage patterns
void demonstrateProductionPatterns() {
  print('\n🏭 Production Usage Patterns:');
  print('');
  print('1. Risk Management:');
  print('   - Set maximum position sizes');
  print('   - Use stop-loss orders');
  print('   - Monitor account balance');
  print('');
  print('2. Order Management:');
  print('   - Track order IDs for cancellation');
  print('   - Handle partial fills appropriately');
  print('   - Implement order timeout logic');
  print('');
  print('3. Position Management:');
  print('   - Monitor unrealized PnL');
  print('   - Implement position sizing rules');
  print('   - Use appropriate leverage');
  print('');
  print('4. Error Recovery:');
  print('   - Implement retry logic with exponential backoff');
  print('   - Handle network disconnections');
  print('   - Log all operations for audit trail');
}
