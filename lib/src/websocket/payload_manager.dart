import 'payload_generator.dart';
import 'subscriptions.dart';
import '../rest/custom_operations.dart';

/// WebSocket payload manager for executing exchange operations via WebSocket POST
///
/// This class provides a high-level interface for executing any exchange operation
/// through WebSocket POST requests, offering better performance and real-time execution
/// compared to REST API calls.
class WebSocketPayloadManager {
  final PayloadGenerator payloadGenerator;
  final WebSocketSubscriptions subscriptions;
  final CustomOperations? customOperations;
  String? vaultAddress;

  WebSocketPayloadManager({
    required this.payloadGenerator,
    required this.subscriptions,
    this.customOperations,
    this.vaultAddress,
  });

  /// Execute any exchange method via WebSocket POST
  ///
  /// [methodName] - The exchange method name
  /// [params] - The method parameters
  /// [timeout] - Optional timeout in milliseconds (default: 30000)
  ///
  /// Returns the response from the WebSocket POST request
  Future<dynamic> executeMethod(String methodName, Map<String, dynamic> params, [int timeout = 30000]) async {
    try {
      // Generate the signed payload
      final payload = await payloadGenerator.generatePayload(methodName, params);

      // Send via WebSocket POST
      final response = await subscriptions.postRequest('action', payload, timeout);

      return response;
    } catch (error) {
      throw Exception('Failed to execute $methodName: $error');
    }
  }

  // ==================== ORDER MANAGEMENT ====================

  /// Place an order via WebSocket POST
  Future<dynamic> placeOrder(Map<String, dynamic> orderParams) async {
    final orders = [orderParams];
    return executeMethod('placeOrder', {'orders': orders});
  }

  /// Place multiple orders via WebSocket POST
  Future<dynamic> placeOrders(List<Map<String, dynamic>> orders, [String grouping = 'na']) async {
    return executeMethod('placeOrder', {'orders': orders, 'grouping': grouping});
  }

  /// Cancel an order via WebSocket POST
  Future<dynamic> cancelOrder(Map<String, dynamic> cancelParams) async {
    final cancels = [cancelParams];
    return executeMethod('cancelOrder', {'cancels': cancels});
  }

  /// Cancel multiple orders via WebSocket POST
  Future<dynamic> cancelOrders(List<Map<String, dynamic>> cancels) async {
    return executeMethod('cancelOrder', {'cancels': cancels});
  }

  /// Cancel order by client order ID via WebSocket POST
  Future<dynamic> cancelOrderByCloid(String coin, String cloid) async {
    return executeMethod('cancelOrderByCloid', {'coin': coin, 'cloid': cloid});
  }

  /// Modify an order via WebSocket POST
  Future<dynamic> modifyOrder(Map<String, dynamic> modifyParams) async {
    return executeMethod('modifyOrder', modifyParams);
  }

  /// Batch modify orders via WebSocket POST
  Future<dynamic> batchModify(List<Map<String, dynamic>> modifies) async {
    return executeMethod('batchModify', {'modifies': modifies});
  }

  // ==================== LEVERAGE AND MARGIN ====================

  /// Update leverage via WebSocket POST
  Future<dynamic> updateLeverage(String coin, int leverage, bool isCross) async {
    return executeMethod('updateLeverage', {
      'coin': coin,
      'leverage': leverage,
      'isCross': isCross,
    });
  }

  /// Update isolated margin via WebSocket POST
  Future<dynamic> updateIsolatedMargin(String coin, bool isBuy, double ntli) async {
    return executeMethod('updateIsolatedMargin', {
      'coin': coin,
      'isBuy': isBuy,
      'ntli': ntli,
    });
  }

  // ==================== TRANSFERS ====================

  /// USD transfer via WebSocket POST
  Future<dynamic> usdTransfer(String destination, double amount) async {
    return executeMethod('usdTransfer', {
      'destination': destination,
      'amount': amount.toString(),
    });
  }

  /// Spot transfer via WebSocket POST
  Future<dynamic> spotTransfer(String destination, String token, double amount) async {
    return executeMethod('spotTransfer', {
      'destination': destination,
      'token': token,
      'amount': amount.toString(),
    });
  }

  // ==================== VAULT OPERATIONS ====================

  /// Vault transfer via WebSocket POST
  Future<dynamic> vaultTransfer(String vaultAddress, bool isDeposit, double usd) async {
    return executeMethod('vaultTransfer', {
      'vaultAddress': vaultAddress,
      'isDeposit': isDeposit,
      'usd': usd,
    });
  }

  /// Create vault via WebSocket POST
  Future<dynamic> createVault(String name, String description, double initialUsd) async {
    return executeMethod('createVault', {
      'name': name,
      'description': description,
      'initialUsd': initialUsd,
    });
  }

  /// Vault distribute via WebSocket POST
  Future<dynamic> vaultDistribute(String vaultAddress, double amount) async {
    return executeMethod('vaultDistribute', {
      'vaultAddress': vaultAddress,
      'amount': amount,
    });
  }

  /// Vault modify via WebSocket POST
  Future<dynamic> vaultModify(String vaultAddress, Map<String, dynamic> modifications) async {
    return executeMethod('vaultModify', {
      'vaultAddress': vaultAddress,
      ...modifications,
    });
  }

  // ==================== TWAP ORDERS ====================

  /// Place TWAP order via WebSocket POST
  Future<dynamic> placeTwapOrder(Map<String, dynamic> twapParams) async {
    return executeMethod('placeTwapOrder', twapParams);
  }

  /// Cancel TWAP order via WebSocket POST
  Future<dynamic> cancelTwapOrder(String coin, int twapId) async {
    return executeMethod('cancelTwapOrder', {
      'coin': coin,
      'twapId': twapId,
    });
  }

  // ==================== AGENT OPERATIONS ====================

  /// Approve an agent via WebSocket POST
  Future<dynamic> approveAgent(String agentAddress, String agentName) async {
    return executeMethod('approveAgent', {
      'agentAddress': agentAddress,
      'agentName': agentName,
    });
  }

  /// Approve builder fee via WebSocket POST
  Future<dynamic> approveBuilderFee(String builder, String maxFeeRate) async {
    return executeMethod('approveBuilderFee', {
      'builder': builder,
      'maxFeeRate': maxFeeRate,
    });
  }

  // ==================== WITHDRAWAL ====================

  /// Initiate withdrawal via WebSocket POST
  Future<dynamic> initiateWithdrawal(String destination, double amount) async {
    return executeMethod('initiateWithdrawal', {
      'destination': destination,
      'amount': amount.toString(),
    });
  }

  // ==================== SUB-ACCOUNT OPERATIONS ====================

  /// Create sub-account via WebSocket POST
  Future<dynamic> createSubAccount(String name) async {
    return executeMethod('createSubAccount', {'name': name});
  }

  /// Sub-account transfer via WebSocket POST
  Future<dynamic> subAccountTransfer(String subAccount, bool isDeposit, double usd) async {
    return executeMethod('subAccountTransfer', {
      'subAccount': subAccount,
      'isDeposit': isDeposit,
      'usd': usd,
    });
  }

  /// Sub-account spot transfer via WebSocket POST
  Future<dynamic> subAccountSpotTransfer(String subAccount, String token, bool isDeposit, double amount) async {
    return executeMethod('subAccountSpotTransfer', {
      'subAccount': subAccount,
      'token': token,
      'isDeposit': isDeposit,
      'amount': amount,
    });
  }

  // ==================== SCHEDULE OPERATIONS ====================

  /// Schedule cancel via WebSocket POST
  Future<dynamic> scheduleCancel(int? time) async {
    return executeMethod('scheduleCancel', {'time': time});
  }

  // ==================== STAKING OPERATIONS ====================

  /// Deposit into staking via WebSocket POST
  Future<dynamic> cDeposit(BigInt wei) async {
    return executeMethod('cDeposit', {'wei': wei.toString()});
  }

  /// Withdraw from staking via WebSocket POST
  Future<dynamic> cWithdraw(BigInt wei) async {
    return executeMethod('cWithdraw', {'wei': wei.toString()});
  }

  // ==================== CUSTOM MARKET OPERATIONS ====================

  /// Market buy/sell via WebSocket POST
  /// This is a custom composite operation that uses native methods
  Future<dynamic> marketOpen(
    String symbol,
    bool isBuy,
    double size, {
    double? px,
    double slippage = 0.05,
    String? cloid,
  }) async {
    if (customOperations == null) {
      throw Exception('Custom operations not available. Ensure the client is authenticated.');
    }
    return customOperations!.marketOpen(symbol, isBuy, size, px: px, slippage: slippage, cloid: cloid);
  }

  /// Market close position via WebSocket POST
  /// This is a custom composite operation that uses native methods
  Future<dynamic> marketClose(
    String symbol, {
    double? size,
    double? px,
    double slippage = 0.05,
    String? cloid,
  }) async {
    if (customOperations == null) {
      throw Exception('Custom operations not available. Ensure the client is authenticated.');
    }
    return customOperations!.marketClose(symbol, size: size, px: px, slippage: slippage, cloid: cloid);
  }

  /// Close all positions via WebSocket POST
  /// This is a custom composite operation that uses native methods
  Future<dynamic> closeAllPositions({double slippage = 0.05}) async {
    if (customOperations == null) {
      throw Exception('Custom operations not available. Ensure the client is authenticated.');
    }
    return customOperations!.closeAllPositions(slippage: slippage);
  }

  // ==================== UTILITY METHODS ====================

  /// Get all available exchange methods
  List<String> getAvailableMethods() {
    return payloadGenerator.getAvailableMethods();
  }

  /// Check if a method is supported
  bool isMethodSupported(String methodName) {
    return payloadGenerator.isMethodSupported(methodName);
  }

  /// Execute a custom method with raw parameters
  /// Useful for methods not yet wrapped in convenience functions
  Future<dynamic> executeCustomMethod(String methodName, Map<String, dynamic> params, [int timeout = 30000]) async {
    return executeMethod(methodName, params, timeout);
  }

  /// Generate payload without executing (for testing/debugging)
  Future<Map<String, dynamic>> generatePayload(String methodName, Map<String, dynamic> params) async {
    return payloadGenerator.generatePayload(methodName, params);
  }

  /// Update vault address
  void setVaultAddress(String? newVaultAddress) {
    vaultAddress = newVaultAddress;
  }
}
