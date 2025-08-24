import '../utils/signing.dart';
import '../utils/symbol_conversion.dart';

/// Configuration for exchange method payload generation
class ExchangeMethodConfig {
  const ExchangeMethodConfig({
    required this.type,
    required this.signingMethod,
    this.signatureTypes,
    this.primaryType,
    this.payloadTransformer,
  });

  final String type;
  final String signingMethod;
  final List<Map<String, String>>? signatureTypes;
  final String? primaryType;
  final Future<Map<String, dynamic>> Function(Map<String, dynamic>, PayloadGeneratorContext)? payloadTransformer;
}

/// Context for payload generation
class PayloadGeneratorContext {
  PayloadGeneratorContext({
    required this.wallet,
    required this.isMainnet,
    required this.symbolConversion,
    this.vaultAddress,
    required this.generateNonce,
  });

  final Wallet wallet;
  final bool isMainnet;
  final SymbolConversion symbolConversion;
  final String? vaultAddress;
  final int Function() generateNonce;
}

/// Dynamic payload generator for WebSocket POST requests
///
/// This class provides a unified way to generate signed payloads for all exchange methods
/// without hardcoding each method. It dynamically creates payloads based on method
/// configurations and handles signing automatically.
class PayloadGenerator {
  PayloadGenerator(this.context);

  final PayloadGeneratorContext context;

  // Exchange method configurations
  static final Map<String, ExchangeMethodConfig> _exchangeMethodConfigs = {
    'placeOrder': const ExchangeMethodConfig(
      type: 'order',
      signingMethod: 'l1Action',
      payloadTransformer: _transformPlaceOrderPayload,
    ),
    'cancelOrder': const ExchangeMethodConfig(
      type: 'cancel',
      signingMethod: 'l1Action',
      payloadTransformer: _transformCancelOrderPayload,
    ),
    'cancelOrderByCloid': const ExchangeMethodConfig(
      type: 'cancelByCloid',
      signingMethod: 'l1Action',
    ),
    'modifyOrder': const ExchangeMethodConfig(
      type: 'modify',
      signingMethod: 'l1Action',
    ),
    'batchModify': const ExchangeMethodConfig(
      type: 'batchModify',
      signingMethod: 'l1Action',
    ),
    'updateLeverage': const ExchangeMethodConfig(
      type: 'updateLeverage',
      signingMethod: 'l1Action',
    ),
    'updateIsolatedMargin': const ExchangeMethodConfig(
      type: 'updateIsolatedMargin',
      signingMethod: 'l1Action',
    ),
    'usdTransfer': const ExchangeMethodConfig(
      type: 'usdSend',
      signingMethod: 'usdTransfer',
      signatureTypes: [
        {'name': 'hyperliquidChain', 'type': 'string'},
        {'name': 'destination', 'type': 'string'},
        {'name': 'amount', 'type': 'string'},
        {'name': 'time', 'type': 'uint64'},
      ],
      primaryType: 'HyperliquidTransaction:UsdSend',
    ),
    'spotTransfer': const ExchangeMethodConfig(
      type: 'spotSend',
      signingMethod: 'userSignedAction',
      signatureTypes: [
        {'name': 'hyperliquidChain', 'type': 'string'},
        {'name': 'destination', 'type': 'string'},
        {'name': 'token', 'type': 'string'},
        {'name': 'amount', 'type': 'string'},
        {'name': 'time', 'type': 'uint64'},
      ],
      primaryType: 'HyperliquidTransaction:SpotSend',
    ),
    'initiateWithdrawal': const ExchangeMethodConfig(
      type: 'withdraw3',
      signingMethod: 'userSignedAction',
      signatureTypes: [
        {'name': 'hyperliquidChain', 'type': 'string'},
        {'name': 'destination', 'type': 'string'},
        {'name': 'amount', 'type': 'string'},
        {'name': 'time', 'type': 'uint64'},
      ],
      primaryType: 'HyperliquidTransaction:Withdraw',
    ),
    'vaultTransfer': const ExchangeMethodConfig(
      type: 'vaultTransfer',
      signingMethod: 'l1Action',
    ),
    'createVault': const ExchangeMethodConfig(
      type: 'createVault',
      signingMethod: 'l1Action',
    ),
    'vaultDistribute': const ExchangeMethodConfig(
      type: 'vaultDistribute',
      signingMethod: 'l1Action',
    ),
    'vaultModify': const ExchangeMethodConfig(
      type: 'vaultModify',
      signingMethod: 'l1Action',
    ),
    'placeTwapOrder': const ExchangeMethodConfig(
      type: 'twapOrder',
      signingMethod: 'l1Action',
    ),
    'cancelTwapOrder': const ExchangeMethodConfig(
      type: 'twapCancel',
      signingMethod: 'l1Action',
    ),
    'approveAgent': const ExchangeMethodConfig(
      type: 'approveAgent',
      signingMethod: 'agent',
      signatureTypes: [
        {'name': 'hyperliquidChain', 'type': 'string'},
        {'name': 'agentAddress', 'type': 'address'},
        {'name': 'agentName', 'type': 'string'},
        {'name': 'nonce', 'type': 'uint64'},
      ],
      primaryType: 'HyperliquidTransaction:ApproveAgent',
    ),
    'approveBuilderFee': const ExchangeMethodConfig(
      type: 'approveBuilderFee',
      signingMethod: 'userSignedAction',
      signatureTypes: [
        {'name': 'hyperliquidChain', 'type': 'string'},
        {'name': 'builder', 'type': 'address'},
        {'name': 'maxFeeRate', 'type': 'string'},
        {'name': 'nonce', 'type': 'uint64'},
      ],
      primaryType: 'HyperliquidTransaction:ApproveBuilderFee',
    ),
    'createSubAccount': const ExchangeMethodConfig(
      type: 'createSubAccount',
      signingMethod: 'l1Action',
    ),
    'subAccountTransfer': const ExchangeMethodConfig(
      type: 'subAccountTransfer',
      signingMethod: 'l1Action',
    ),
    'subAccountSpotTransfer': const ExchangeMethodConfig(
      type: 'subAccountSpotTransfer',
      signingMethod: 'l1Action',
    ),
    'scheduleCancel': const ExchangeMethodConfig(
      type: 'scheduleCancel',
      signingMethod: 'l1Action',
    ),
    'cDeposit': const ExchangeMethodConfig(
      type: 'cDeposit',
      signingMethod: 'userSignedAction',
      signatureTypes: [
        {'name': 'hyperliquidChain', 'type': 'string'},
        {'name': 'wei', 'type': 'string'},
        {'name': 'nonce', 'type': 'uint64'},
      ],
      primaryType: 'HyperliquidTransaction:CDeposit',
    ),
    'cWithdraw': const ExchangeMethodConfig(
      type: 'cWithdraw',
      signingMethod: 'userSignedAction',
      signatureTypes: [
        {'name': 'hyperliquidChain', 'type': 'string'},
        {'name': 'wei', 'type': 'string'},
        {'name': 'nonce', 'type': 'uint64'},
      ],
      primaryType: 'HyperliquidTransaction:CWithdraw',
    ),
  };

  /// Generate a signed payload for any exchange method
  ///
  /// [methodName] - The name of the exchange method
  /// [params] - The parameters for the method
  ///
  /// Returns a signed payload ready for WebSocket POST
  Future<Map<String, dynamic>> generatePayload(String methodName, Map<String, dynamic> params) async {
    final config = _exchangeMethodConfigs[methodName];
    if (config == null) {
      throw Exception('Unknown exchange method: $methodName');
    }

    try {
      // Transform the parameters into the action object
      Map<String, dynamic> action;
      if (config.payloadTransformer != null) {
        action = await config.payloadTransformer!(params, context);
      } else {
        action = {'type': config.type, ...params};
      }

      // Generate nonce
      final nonce = context.generateNonce();
      final vaultAddress = context.vaultAddress;

      // Sign the action based on the signing method
      Map<String, dynamic> signature;
      switch (config.signingMethod) {
        case 'l1Action':
          final l1Signature = await signL1Action(context.wallet, action, vaultAddress, nonce, context.isMainnet);
          signature = l1Signature as Map<String, dynamic>;
          break;

        case 'userSignedAction':
          if (config.signatureTypes == null || config.primaryType == null) {
            throw Exception('Missing signature configuration for method: $methodName');
          }
          signature = await signUserSignedAction(
            context.wallet,
            action,
            config.signatureTypes!,
            config.primaryType!,
            context.isMainnet,
          );
          break;

        case 'agent':
          // For agent signing, we need special handling
          final agentSignature = await signL1Action(context.wallet, action, vaultAddress, nonce, context.isMainnet);
          signature = agentSignature as Map<String, dynamic>;
          break;

        case 'usdTransfer':
          signature = await signUserSignedAction(
            context.wallet,
            action,
            config.signatureTypes!,
            config.primaryType!,
            context.isMainnet,
          );
          break;

        default:
          throw Exception('Unknown signing method: ${config.signingMethod}');
      }

      // Return the complete payload
      return {
        'action': action,
        'nonce': nonce,
        'signature': signature,
        if (vaultAddress != null) 'vaultAddress': vaultAddress,
      };
    } catch (error) {
      throw Exception('Failed to generate payload for $methodName: $error');
    }
  }

  /// Get all available exchange methods
  List<String> getAvailableMethods() {
    return _exchangeMethodConfigs.keys.toList();
  }

  /// Check if a method is supported
  bool isMethodSupported(String methodName) {
    return _exchangeMethodConfigs.containsKey(methodName);
  }

  // Static payload transformers
  static Future<Map<String, dynamic>> _transformPlaceOrderPayload(
    Map<String, dynamic> params,
    PayloadGeneratorContext context,
  ) async {
    final orders = params['orders'] as List<dynamic>;
    final grouping = params['grouping'] ?? 'na';

    // Convert orders to wire format
    final wireOrders = <Map<String, dynamic>>[];
    for (final order in orders) {
      final orderMap = Map<String, dynamic>.from(order as Map<dynamic, dynamic>);

      // Convert symbol if needed
      if (orderMap.containsKey('coin')) {
        final coin = orderMap['coin'] as String;
        orderMap['coin'] = await context.symbolConversion.convertSymbol(coin);
      }

      wireOrders.add(orderMap);
    }

    return {
      'type': 'order',
      'orders': wireOrders,
      'grouping': grouping,
    };
  }

  static Future<Map<String, dynamic>> _transformCancelOrderPayload(
    Map<String, dynamic> params,
    PayloadGeneratorContext context,
  ) async {
    final cancels = params['cancels'] as List<dynamic>;

    // Convert cancel requests
    final wireCancels = <Map<String, dynamic>>[];
    for (final cancel in cancels) {
      final cancelMap = Map<String, dynamic>.from(cancel as Map<dynamic, dynamic>);

      // Convert symbol if needed
      if (cancelMap.containsKey('coin')) {
        final coin = cancelMap['coin'] as String;
        cancelMap['coin'] = await context.symbolConversion.convertSymbol(coin);
      }

      wireCancels.add(cancelMap);
    }

    return {
      'type': 'cancel',
      'cancels': wireCancels,
    };
  }
}
