import 'package:hyperliquid/hyperliquid.dart';

/// Example demonstrating WebSocket POST operations (wsPayloads)
///
/// This example shows how to use the advanced WebSocket POST functionality
/// for real-time trading operations with better performance than REST API.
///
/// ⚠️ WARNING: This example uses testnet. Always test thoroughly
/// before using on mainnet with real funds.
void main() async {
  // Initialize the SDK with authentication and WebSocket enabled
  // Replace with your actual testnet private key for testing
  const privateKey = '0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d';

  final client = Hyperliquid(const HyperliquidConfig(
    testnet: true, // Always use testnet for examples
    privateKey: privateKey,
    enableWs: true, // Enable WebSocket for POST operations
  ));

  try {
    print('🚀 Initializing Hyperliquid SDK with WebSocket POST Operations...');
    await client.connect();

    if (!client.isAuthenticated()) {
      print('❌ Authentication failed. Please check your private key.');
      return;
    }

    if (!client.enableWs) {
      print('❌ WebSocket not enabled. WebSocket POST operations require enableWs: true.');
      return;
    }

    print('✅ Successfully authenticated with WebSocket enabled!');
    print('📊 WebSocket POST operations available: true');

    // Example 1: List all available WebSocket POST methods
    print('\n📋 Example 1: Available WebSocket POST methods...');
    final availableMethods = client.wsPayloads.getAvailableMethods();
    print('Total available methods: ${availableMethods.length}');
    print('Methods: ${availableMethods.join(', ')}');

    // Check specific method support
    final keyMethods = ['placeOrder', 'cancelOrder', 'updateLeverage', 'usdTransfer', 'marketOpen'];
    for (final method in keyMethods) {
      final isSupported = client.wsPayloads.isMethodSupported(method);
      print('$method: ${isSupported ? '✅ Supported' : '❌ Not supported'}');
    }

    // Example 2: Generate order payload (without executing)
    print('\n🎯 Example 2: Generating order payload...');
    try {
      final orderParams = {
        'coin': 'BTC-PERP',
        'is_buy': true,
        'sz': 0.001, // Very small size for testing
        'limit_px': 50000,
        'order_type': {'limit': {}},
        'reduce_only': false,
      };

      final payload = await client.wsPayloads.generatePayload('placeOrder', {
        'orders': [orderParams]
      });

      print('✅ Order payload generated successfully');
      print('📋 Action type: ${payload['action']['type']}');
      print('🔢 Nonce: ${payload['nonce']}');
      print('✍️ Signature present: ${payload['signature'] != null}');

      // Show payload structure (without sensitive data)
      print('📦 Payload structure:');
      print('  - action: ${payload['action']['type']}');
      print('  - orders count: ${payload['action']['orders']?.length ?? 0}');
      print('  - grouping: ${payload['action']['grouping']}');
    } catch (e) {
      print('⚠️ Payload generation failed: $e');
    }

    // Example 3: Generate cancel payload
    print('\n❌ Example 3: Generating cancel payload...');
    try {
      final cancelParams = {
        'coin': 'BTC-PERP',
        'o': 123456789, // Example order ID
      };

      final payload = await client.wsPayloads.generatePayload('cancelOrder', {
        'cancels': [cancelParams]
      });

      print('✅ Cancel payload generated successfully');
      print('📋 Action type: ${payload['action']['type']}');
      print('🎯 Cancels count: ${payload['action']['cancels']?.length ?? 0}');
    } catch (e) {
      print('⚠️ Cancel payload generation failed: $e');
    }

    // Example 4: Generate leverage update payload
    print('\n⚖️ Example 4: Generating leverage update payload...');
    try {
      final payload = await client.wsPayloads.generatePayload('updateLeverage', {
        'coin': 'BTC-PERP',
        'leverage': 10,
        'isCross': true,
      });

      print('✅ Leverage update payload generated successfully');
      print('📋 Action type: ${payload['action']['type']}');
      print('🎯 Leverage: ${payload['action']['leverage']}');
      print('🔄 Cross margin: ${payload['action']['isCross']}');
    } catch (e) {
      print('⚠️ Leverage update payload generation failed: $e');
    }

    // Example 5: Generate USD transfer payload
    print('\n💸 Example 5: Generating USD transfer payload...');
    try {
      final payload = await client.wsPayloads.generatePayload('usdTransfer', {
        'destination': '0x1234567890123456789012345678901234567890',
        'amount': '1.0',
      });

      print('✅ USD transfer payload generated successfully');
      print('📋 Action type: ${payload['action']['type']}');
      print('💰 Amount: ${payload['action']['amount']}');
      print('📍 Destination: ${payload['action']['destination']}');
    } catch (e) {
      print('⚠️ USD transfer payload generation failed: $e');
    }

    // Example 6: WebSocket POST method categories
    print('\n🎓 Example 6: WebSocket POST method categories...');
    print('');
    print('📋 Order Management (6 methods):');
    print('  - placeOrder() - Place single order');
    print('  - placeOrders() - Place multiple orders');
    print('  - cancelOrder() - Cancel single order');
    print('  - cancelOrders() - Cancel multiple orders');
    print('  - modifyOrder() - Modify existing order');
    print('  - batchModify() - Batch modify orders');
    print('');
    print('⚖️ Leverage & Margin (2 methods):');
    print('  - updateLeverage() - Update position leverage');
    print('  - updateIsolatedMargin() - Update isolated margin');
    print('');
    print('💸 Transfers (2 methods):');
    print('  - usdTransfer() - Transfer USD between accounts');
    print('  - spotTransfer() - Transfer spot tokens');
    print('');
    print('🏦 Vault Operations (4 methods):');
    print('  - vaultTransfer() - Transfer to/from vault');
    print('  - createVault() - Create new vault');
    print('  - vaultDistribute() - Distribute vault funds');
    print('  - vaultModify() - Modify vault settings');
    print('');
    print('📈 TWAP Orders (2 methods):');
    print('  - placeTwapOrder() - Place TWAP order');
    print('  - cancelTwapOrder() - Cancel TWAP order');
    print('');
    print('🤖 Agent Operations (2 methods):');
    print('  - approveAgent() - Approve trading agent');
    print('  - approveBuilderFee() - Approve builder fee');
    print('');
    print('👥 Sub-Account Operations (3 methods):');
    print('  - createSubAccount() - Create sub-account');
    print('  - subAccountTransfer() - Transfer to sub-account');
    print('  - subAccountSpotTransfer() - Spot transfer to sub-account');
    print('');
    print('💰 Staking Operations (2 methods):');
    print('  - cDeposit() - Deposit into staking');
    print('  - cWithdraw() - Withdraw from staking');
    print('');
    print('🎯 Custom Market Operations (3 methods):');
    print('  - marketOpen() - Market buy/sell with slippage');
    print('  - marketClose() - Close position with market order');
    print('  - closeAllPositions() - Close all positions');

    // Example 7: Error handling demonstration
    print('\n🛡️ Example 7: Error handling...');
    try {
      await client.wsPayloads.generatePayload('invalidMethod', {});
    } catch (e) {
      print('✅ Invalid method error handled: ${e.toString().split(':').first}');
    }

    try {
      await client.wsPayloads.generatePayload('placeOrder', {}); // Missing orders
    } catch (e) {
      print('✅ Missing parameters error handled: ${e.toString().split(':').first}');
    }

    print('\n✅ WebSocket POST operations example completed successfully!');
    print('');
    print('🚨 IMPORTANT NOTES:');
    print('- WebSocket POST operations provide better performance than REST');
    print('- All operations are signed and authenticated automatically');
    print('- Payloads can be generated without executing for testing');
    print('- 24 different exchange methods are available via WebSocket POST');
    print('- Custom market operations integrate with the payload system');
    print('- Error handling is built-in for invalid methods and parameters');
    print('- Always test on testnet before using on mainnet');
  } catch (e) {
    print('❌ Example failed: $e');
  } finally {
    // Clean up
    client.disconnect();
    print('\n🔌 Disconnected from Hyperliquid');
  }
}

/// Helper function to demonstrate WebSocket POST vs REST comparison
void demonstrateWebSocketPostAdvantages() {
  print('\n🏆 WebSocket POST vs REST API Comparison:');
  print('');
  print('📈 Performance:');
  print('  - WebSocket POST: Lower latency, persistent connection');
  print('  - REST API: Higher latency, connection overhead per request');
  print('');
  print('🔄 Real-time Operations:');
  print('  - WebSocket POST: Immediate execution, real-time responses');
  print('  - REST API: Request-response cycle, potential delays');
  print('');
  print('📊 Throughput:');
  print('  - WebSocket POST: Higher throughput, multiplexed requests');
  print('  - REST API: Limited by HTTP connection limits');
  print('');
  print('🛡️ Reliability:');
  print('  - WebSocket POST: Built-in reconnection, message queuing');
  print('  - REST API: Manual retry logic required');
  print('');
  print('💡 Use Cases:');
  print('  - WebSocket POST: High-frequency trading, real-time operations');
  print('  - REST API: Simple operations, one-off requests');
}

/// Helper function to demonstrate production usage patterns
void demonstrateProductionUsage() {
  print('\n🏭 Production Usage Patterns:');
  print('');
  print('1. Order Management:');
  print('   - Use placeOrders() for batch order placement');
  print('   - Use cancelOrders() for bulk cancellations');
  print('   - Monitor order status via WebSocket subscriptions');
  print('');
  print('2. Risk Management:');
  print('   - Use updateLeverage() for dynamic risk adjustment');
  print('   - Use closeAllPositions() for emergency exits');
  print('   - Implement position size limits');
  print('');
  print('3. Performance Optimization:');
  print('   - Batch operations when possible');
  print('   - Use WebSocket POST for time-sensitive operations');
  print('   - Implement proper error handling and retries');
  print('');
  print('4. Monitoring:');
  print('   - Log all WebSocket POST operations');
  print('   - Monitor payload generation times');
  print('   - Track success/failure rates');
}
