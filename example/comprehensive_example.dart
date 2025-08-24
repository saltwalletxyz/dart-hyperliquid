import 'dart:io';
import 'package:hyperliquid/hyperliquid.dart';

/// Comprehensive example demonstrating all major features of the Hyperliquid Dart SDK
///
/// This example shows:
/// - Basic client setup and configuration
/// - Security features and validation
/// - Error handling and retry mechanisms
/// - Structured logging
/// - REST API operations
/// - WebSocket real-time data
/// - Advanced trading operations
/// - Production best practices
void main() async {
  print('🚀 Hyperliquid Dart SDK - Comprehensive Example');
  print('=' * 60);

  // Get private key from environment variable for security
  final privateKey = Platform.environment['HYPERLIQUID_PRIVATE_KEY'];
  if (privateKey == null) {
    print('❌ Please set HYPERLIQUID_PRIVATE_KEY environment variable');
    print('   Example: export HYPERLIQUID_PRIVATE_KEY="0x..."');
    return;
  }

  // Initialize client with comprehensive configuration
  final client = Hyperliquid(HyperliquidConfig(
    privateKey: privateKey,
    testnet: true, // Always use testnet for examples
    enableWs: true,
    maxReconnectAttempts: 5,
  ));

  try {
    await demonstrateSecurityFeatures(client);
    await demonstrateErrorHandling(client);
    await demonstrateStructuredLogging(client);
    await demonstrateRestApiOperations(client);
    await demonstrateWebSocketOperations(client);
    await demonstrateAdvancedTrading(client);
  } catch (e, stackTrace) {
    print('❌ Fatal error: $e');
    print('Stack trace: $stackTrace');
  } finally {
    print('\n🔌 Disconnecting from Hyperliquid...');
    client.disconnect();
    print('✅ Disconnected successfully');
  }
}

/// Demonstrate security features and validation
Future<void> demonstrateSecurityFeatures(Hyperliquid client) async {
  print('\n🛡️ Security Features Demo');
  print('-' * 30);

  // Get security statistics
  final securityStats = client.security.getSecurityStats();
  print('📊 Security Stats: $securityStats');

  // Demonstrate input validation
  try {
    await client.security.validateTradingParameters(
      symbol: 'BTC-PERP',
      size: 0.1,
      price: 50000.0,
      leverage: 10,
      slippage: 0.01,
    );
    print('✅ Trading parameters validated successfully');
  } catch (e) {
    print('❌ Validation failed: $e');
  }

  // Demonstrate input sanitization
  final dangerousInput = '<script>alert("xss")</script>';
  final sanitized = client.security.sanitizeInput(dangerousInput);
  print('🧹 Sanitized input: "$dangerousInput" -> "$sanitized"');

  // Generate secure nonce
  final nonce = client.security.generateSecureNonce();
  print('🔢 Secure nonce generated: $nonce');
}

/// Demonstrate error handling and retry mechanisms
Future<void> demonstrateErrorHandling(Hyperliquid client) async {
  print('\n🔄 Error Handling Demo');
  print('-' * 25);

  // Configure error handling
  client.errorHandler.updateConfiguration(
    enableAutoRecovery: true,
    maxRetryAttempts: 3,
    baseRetryDelay: const Duration(seconds: 1),
  );

  // Demonstrate automatic retry with error handling
  try {
    final result = await client.errorHandler.handleError<dynamic>(
      'get-all-mids',
      () => client.info.getAllMids(),
      maxRetries: 2,
    );

    if (result != null) {
      print('✅ Operation succeeded with retry mechanism');
      print('   Market data retrieved successfully');
    }
  } catch (e) {
    print('❌ Operation failed after retries: $e');
  }

  // Get error statistics
  final errorStats = client.errorHandler.getErrorStats();
  print('📈 Error Stats: ${errorStats['totalErrors']} total errors');
}

/// Demonstrate structured logging capabilities
Future<void> demonstrateStructuredLogging(Hyperliquid client) async {
  print('\n📝 Structured Logging Demo');
  print('-' * 30);

  // Add global context for all log messages
  client.structuredLogger.addGlobalContext({
    'strategy': 'demo-strategy',
    'version': '1.0.0',
    'environment': 'testnet',
  });

  // Log different types of events
  client.structuredLogger.info('Demo started', {
    'timestamp': DateTime.now().toIso8601String(),
    'user': 'demo-user',
  });

  client.structuredLogger.logTradingOperation(
    'demo-order',
    symbol: 'BTC-PERP',
    amount: 0.1,
    price: 50000.0,
    status: 'simulated',
  );

  client.structuredLogger.logSecurityEvent(
    'demo-validation',
    severity: 'info',
    source: 'example',
  );

  client.structuredLogger.logPerformance(
    'api-call',
    const Duration(milliseconds: 150),
    success: true,
    metrics: {'responseSize': 1024},
  );

  print('✅ Structured logging examples completed');
}

/// Demonstrate REST API operations
Future<void> demonstrateRestApiOperations(Hyperliquid client) async {
  print('\n🌐 REST API Operations Demo');
  print('-' * 35);

  try {
    // Get market data
    print('📊 Fetching market data...');
    final allMids = await client.info.getAllMids();
    print('   BTC-PERP: \$${allMids['BTC-PERP']}');
    print('   ETH-PERP: \$${allMids['ETH-PERP']}');

    // Get account information (using perpetuals API)
    print('\n👤 Fetching account information...');
    if (client.walletAddress != null) {
      final userState = await client.info.perpetualsAPI.getClearinghouseState(client.walletAddress!);
      print('   User state retrieved successfully');

      // Get open orders
      print('\n📋 Fetching open orders...');
      final openOrders = await client.info.getUserOpenOrders(client.walletAddress!);
      print('   Open Orders data retrieved');

      // Get recent fills
      print('\n💰 Fetching recent fills...');
      final fills = await client.info.getUserFills(client.walletAddress!);
      print('   Recent Fills data retrieved');
    } else {
      print('   ⚠️ No wallet address available for user-specific data');
    }
  } catch (e) {
    print('❌ REST API error: $e');
  }
}

/// Demonstrate WebSocket real-time operations
Future<void> demonstrateWebSocketOperations(Hyperliquid client) async {
  print('\n📡 WebSocket Operations Demo');
  print('-' * 35);

  try {
    // Subscribe to user events (orders, fills, etc.)
    if (client.walletAddress != null) {
      print('🔔 Subscribing to user events...');
      await client.subscriptions.subscribe('user', (dynamic data) {
        client.structuredLogger.info('User event received', {
          'type': 'user_event',
          'data': data.toString(),
        });
        print('   📨 User Event: ${data.runtimeType}');
      }, {'user': client.walletAddress});
    }

    // Subscribe to price updates
    print('💹 Subscribing to price updates...');
    await client.subscriptions.subscribe('allMids', (dynamic data) {
      print('   📈 Price update received');
    });

    // Subscribe to trades for BTC-PERP
    print('📊 Subscribing to BTC-PERP trades...');
    await client.subscriptions.subscribe('trades', (dynamic data) {
      print('   🔄 Trade data received');
    }, {'coin': 'BTC-PERP'});

    // Wait for some real-time data
    print('⏳ Listening for real-time data (5 seconds)...');
    await Future<void>.delayed(const Duration(seconds: 5));
  } catch (e) {
    print('❌ WebSocket error: $e');
  }
}

/// Demonstrate advanced trading operations
Future<void> demonstrateAdvancedTrading(Hyperliquid client) async {
  print('\n⚡ Advanced Trading Demo');
  print('-' * 30);

  try {
    // Note: These are simulation examples - orders won't actually be placed
    print('📝 Simulating advanced trading operations...');

    // Simulate order placement with validation
    print('\n1️⃣ Order Placement Simulation');
    final orderValidation = await client.security.validateTradingParameters(
      symbol: 'BTC-PERP',
      size: 0.01, // Small size for demo
      price: 45000.0,
      leverage: 5,
    );

    if (orderValidation.isValid) {
      print('   ✅ Order parameters validated');
      print('   📊 Would place: 0.01 BTC-PERP @ \$45,000 (5x leverage)');
    }

    // Simulate batch operations
    print('\n2️⃣ Batch Operations Simulation');
    print('   📦 Would batch modify multiple orders');
    print('   🔄 Would update leverage for multiple symbols');

    // Simulate risk management
    print('\n3️⃣ Risk Management Simulation');
    if (client.walletAddress != null) {
      await client.info.perpetualsAPI.getClearinghouseState(client.walletAddress!);
      print('   💰 Account data retrieved for risk analysis');
      print('   ⚠️ Risk management rules would be applied here');
    }

    // Simulate portfolio analysis
    print('\n4️⃣ Portfolio Analysis Simulation');
    print('   📊 Portfolio analysis would be performed here');
    print('   📈 Position sizing and risk metrics calculated');
  } catch (e) {
    print('❌ Advanced trading error: $e');
  }
}
