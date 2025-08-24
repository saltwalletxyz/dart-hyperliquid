import 'package:hyperliquid/src/utils/rate_limiter.dart';
import 'package:hyperliquid/src/utils/http_api.dart';
import 'package:hyperliquid/src/utils/symbol_conversion.dart';
import 'package:hyperliquid/src/constants.dart';
import 'package:hyperliquid/src/hyperliquid_base.dart';
import 'package:hyperliquid/src/utils/signing.dart';

class ExchangeAPI {
  final HttpApi _httpApi;
  final SymbolConversion symbolConversion;
  final Hyperliquid parent;
  final bool isMainnet;
  final Wallet wallet;
  final String? walletAddress;
  final String? vaultAddress;

  int _lastNonceTs = 0;

  ExchangeAPI(
    bool testnet,
    String privateKey,
    dynamic info,
    RateLimiter rateLimiter,
    this.symbolConversion,
    this.walletAddress,
    this.parent,
    this.vaultAddress,
  )   : isMainnet = !testnet,
        wallet = Wallet(privateKey),
        _httpApi = HttpApi(testnet ? BaseUrls.testnet : BaseUrls.production, Endpoints.exchange, rateLimiter);

  int _uniqueNonce() {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (now <= _lastNonceTs) {
      _lastNonceTs += 1;
      return _lastNonceTs;
    }
    _lastNonceTs = now;
    return now;
  }

  // Test helper to expose nonce generation without reflection. Not part of public stable API.
  int testNextNonce() => _uniqueNonce();

  String? _getVaultAddress() => vaultAddress;

  Future<int> _getAssetIndex(String symbol) async {
    final idx = await symbolConversion.getAssetIndex(symbol);
    if (idx == null) {
      throw Exception('Unknown asset: $symbol');
    }
    return idx;
  }

  // Orders
  Future<dynamic> placeOrder(dynamic orderRequest) async {
    await parent.ensureInitialized();
    final vault = _getVaultAddress();
    final grouping = (orderRequest is Map && orderRequest.containsKey('grouping')) ? (orderRequest['grouping'] as String) : 'na';
    Map<String, dynamic>? builder = (orderRequest is Map && orderRequest['builder'] is Map)
        ? Map<String, dynamic>.from(orderRequest['builder'] as Map)
        : null;
    if (builder != null && builder['address'] != null) {
      builder = {
        ...builder,
        'address': (builder['address'] as String).toLowerCase(),
      };
    }

    final List<dynamic> ordersArray = (orderRequest is Map && orderRequest['orders'] is List)
        ? List<dynamic>.from(orderRequest['orders'] as List)
        : <dynamic>[orderRequest];

    final Map<String, int> assetIndexCache = {};

    final orderWires = <Map<String, dynamic>>[];
    for (final dynamic o in ordersArray) {
      final order = Map<String, dynamic>.from(o as Map);
      final coin = order['coin'] as String;
      int assetIndex;
      if (assetIndexCache.containsKey(coin)) {
        assetIndex = assetIndexCache[coin]!;
      } else {
        assetIndex = await _getAssetIndex(coin);
        assetIndexCache[coin] = assetIndex;
      }
      orderWires.add(orderToWire(order, assetIndex));
    }

    final actions = orderWireToAction(orderWires, grouping, builder);
    final nonce = _uniqueNonce();
    final signature = await signL1Action(wallet, actions, vault, nonce, isMainnet);
    final payload = {'action': actions, 'nonce': nonce, 'signature': signature, 'vaultAddress': vault};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> getOrderPayload(dynamic orderRequest) async {
    await parent.ensureInitialized();
    final vault = _getVaultAddress();
    final grouping = (orderRequest is Map && orderRequest.containsKey('grouping')) ? (orderRequest['grouping'] as String) : 'na';
    Map<String, dynamic>? builder = (orderRequest is Map && orderRequest['builder'] is Map)
        ? Map<String, dynamic>.from(orderRequest['builder'] as Map)
        : null;
    if (builder != null && builder['address'] != null) {
      builder = {
        ...builder,
        'address': (builder['address'] as String).toLowerCase(),
      };
    }
    final List<dynamic> ordersArray = (orderRequest is Map && orderRequest['orders'] is List)
        ? List<dynamic>.from(orderRequest['orders'] as List)
        : <dynamic>[orderRequest];
    final Map<String, int> assetIndexCache = {};
    final orderWires = <Map<String, dynamic>>[];
    for (final dynamic o in ordersArray) {
      final order = Map<String, dynamic>.from(o as Map);
      final coin = order['coin'] as String;
      int assetIndex;
      if (assetIndexCache.containsKey(coin)) {
        assetIndex = assetIndexCache[coin]!;
      } else {
        assetIndex = await _getAssetIndex(coin);
        assetIndexCache[coin] = assetIndex;
      }
      orderWires.add(orderToWire(order, assetIndex));
    }
    final actions = orderWireToAction(orderWires, grouping, builder);
    final nonce = _uniqueNonce();
    final signature = await signL1Action(wallet, actions, vault, nonce, isMainnet);
    return {'action': actions, 'nonce': nonce, 'signature': signature, 'vaultAddress': vault};
  }

  Future<dynamic> cancelOrder(dynamic cancelRequests) async {
    await parent.ensureInitialized();
    final cancels = cancelRequests is List ? cancelRequests : [cancelRequests];
    final vault = _getVaultAddress();
    final cancelsWithIndices = <Map<String, dynamic>>[];
    for (final dynamic cr in cancels) {
      final req = Map<String, dynamic>.from(cr as Map);
      final a = await _getAssetIndex(req['coin'] as String);
      cancelsWithIndices.add({'a': a, 'o': req['o']});
    }
    final action = {'type': 'cancel', 'cancels': cancelsWithIndices};
    final nonce = _uniqueNonce();
    final signature = await signL1Action(wallet, action, vault, nonce, isMainnet);
    final payload = {'action': action, 'nonce': nonce, 'signature': signature, 'vaultAddress': vault};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> getCancelOrderPayload(dynamic cancelRequests) async {
    await parent.ensureInitialized();
    final cancels = cancelRequests is List ? cancelRequests : [cancelRequests];
    final vault = _getVaultAddress();
    final cancelsWithIndices = <Map<String, dynamic>>[];
    for (final dynamic cr in cancels) {
      final req = Map<String, dynamic>.from(cr as Map);
      final a = await _getAssetIndex(req['coin'] as String);
      cancelsWithIndices.add({'a': a, 'o': req['o']});
    }
    final action = {'type': 'cancel', 'cancels': cancelsWithIndices};
    final nonce = _uniqueNonce();
    final signature = await signL1Action(wallet, action, vault, nonce, isMainnet);
    return {'action': action, 'nonce': nonce, 'signature': signature, 'vaultAddress': vault};
  }

  Future<dynamic> getCancelAllPayload() async {
    await parent.ensureInitialized();
    final vault = _getVaultAddress();
    final action = {'type': 'cancelAll'};
    final nonce = _uniqueNonce();
    final signature = await signL1Action(wallet, action, vault, nonce, isMainnet);
    return {'action': action, 'nonce': nonce, 'signature': signature, 'vaultAddress': vault};
  }

  Future<dynamic> cancelOrderByCloid(String symbol, String cloid) async {
    await parent.ensureInitialized();
    final assetIndex = await _getAssetIndex(symbol);
    final vault = _getVaultAddress();
    final action = {
      'type': 'cancelByCloid',
      'cancels': [
        {'asset': assetIndex, 'cloid': cloid}
      ]
    };
    final nonce = _uniqueNonce();
    final signature = await signL1Action(wallet, action, vault, nonce, isMainnet);
    final payload = {'action': action, 'nonce': nonce, 'signature': signature, 'vaultAddress': vault};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> modifyOrder(dynamic oid, Map<String, dynamic> orderRequest) async {
    await parent.ensureInitialized();
    final assetIndex = await _getAssetIndex(orderRequest['coin'] as String);
    final vault = _getVaultAddress();
    final orderWire = orderToWire(orderRequest, assetIndex);
    final action = {'type': 'modify', 'oid': oid, 'order': orderWire};
    final nonce = _uniqueNonce();
    final signature = await signL1Action(wallet, action, vault, nonce, isMainnet);
    final payload = {'action': action, 'nonce': nonce, 'signature': signature, 'vaultAddress': vault};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> batchModifyOrders(List<Map<String, dynamic>> modifies) async {
    await parent.ensureInitialized();
    final vault = _getVaultAddress();
    final modifiesWire = <Map<String, dynamic>>[];
    for (final m in modifies) {
      final oid = m['oid'];
      final order = Map<String, dynamic>.from(m['order'] as Map);
      final asset = await _getAssetIndex(order['coin'] as String);
      modifiesWire.add({'oid': oid, 'order': orderToWire(order, asset)});
    }
    final action = {'type': 'batchModify', 'modifies': modifiesWire};
    final nonce = _uniqueNonce();
    final signature = await signL1Action(wallet, action, vault, nonce, isMainnet);
    final payload = {'action': action, 'nonce': nonce, 'signature': signature, 'vaultAddress': vault};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> updateLeverage(String symbol, String leverageMode, int leverage) async {
    await parent.ensureInitialized();
    final assetIndex = await _getAssetIndex(symbol);
    final vault = _getVaultAddress();
    final action = {'type': 'updateLeverage', 'asset': assetIndex, 'isCross': leverageMode == 'cross', 'leverage': leverage};
    final nonce = _uniqueNonce();
    final signature = await signL1Action(wallet, action, vault, nonce, isMainnet);
    final payload = {'action': action, 'nonce': nonce, 'signature': signature, 'vaultAddress': vault};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> updateIsolatedMargin(String symbol, bool isBuy, num ntli) async {
    await parent.ensureInitialized();
    final assetIndex = await _getAssetIndex(symbol);
    final vault = _getVaultAddress();
    final action = {'type': 'updateIsolatedMargin', 'asset': assetIndex, 'isBuy': isBuy, 'ntli': ntli};
    final nonce = _uniqueNonce();
    final signature = await signL1Action(wallet, action, vault, nonce, isMainnet);
    final payload = {'action': action, 'nonce': nonce, 'signature': signature, 'vaultAddress': vault};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> usdTransfer(String destination, num amount) async {
    await parent.ensureInitialized();
    final action = {
      'type': 'usdSend',
      'hyperliquidChain': isMainnet ? 'Mainnet' : 'Testnet',
      'signatureChainId': isMainnet ? ChainIds.arbitrumMainnet : ChainIds.arbitrumTestnet,
      'destination': destination,
      'amount': amount.toString(),
      'time': getTimestampMs(),
    };
    final signature = await signUsdTransferAction(wallet, action, isMainnet);
    final payload = {'action': action, 'nonce': action['time'], 'signature': signature};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> spotTransfer(String destination, String token, String amount) async {
    await parent.ensureInitialized();
    final action = {
      'type': 'spotSend',
      'hyperliquidChain': isMainnet ? 'Mainnet' : 'Testnet',
      'signatureChainId': isMainnet ? ChainIds.arbitrumMainnet : ChainIds.arbitrumTestnet,
      'destination': destination,
      'token': token,
      'amount': amount,
      'time': getTimestampMs(),
    };
    final signature = await signUserSignedAction(
      wallet,
      action,
      [
        {'name': 'hyperliquidChain', 'type': 'string'},
        {'name': 'destination', 'type': 'string'},
        {'name': 'token', 'type': 'string'},
        {'name': 'amount', 'type': 'string'},
        {'name': 'time', 'type': 'uint64'},
      ],
      'HyperliquidTransaction:SpotSend',
      isMainnet,
    );
    final payload = {'action': action, 'nonce': action['time'], 'signature': signature};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> initiateWithdrawal(String destination, num amount) async {
    await parent.ensureInitialized();
    final action = {
      'type': 'withdraw',
      'hyperliquidChain': isMainnet ? 'Mainnet' : 'Testnet',
      'signatureChainId': isMainnet ? ChainIds.arbitrumMainnet : ChainIds.arbitrumTestnet,
      'destination': destination,
      'amount': amount.toString(),
      'time': getTimestampMs(),
    };
    final signature = await signWithdrawFromBridgeAction(wallet, action, isMainnet);
    final payload = {'action': action, 'nonce': action['time'], 'signature': signature};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> scheduleCancel(int? timeMs) async {
    await parent.ensureInitialized();
    final action = {'type': 'scheduleCancel', 'time': timeMs};
    final nonce = _uniqueNonce();
    final signature = await signL1Action(wallet, action, null, nonce, isMainnet);
    final payload = {'action': action, 'nonce': nonce, 'signature': signature};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> vaultTransfer(String vaultAddress, bool isDeposit, num usd) async {
    await parent.ensureInitialized();
    final action = {'type': 'vaultTransfer', 'vaultAddress': vaultAddress, 'isDeposit': isDeposit, 'usd': usd};
    final nonce = _uniqueNonce();
    final signature = await signL1Action(wallet, action, null, nonce, isMainnet);
    final payload = {'action': action, 'nonce': nonce, 'signature': signature};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> createVault(String name, String description, num initialUsd) async {
    await parent.ensureInitialized();
    final nonce = _uniqueNonce();
    final action = {'type': 'createVault', 'name': name, 'description': description, 'initialUsd': initialUsd, 'nonce': nonce};
    final signature = await signL1Action(wallet, action, null, nonce, isMainnet);
    final payload = {'action': action, 'nonce': nonce, 'signature': signature};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> vaultDistribute(String vaultAddress, num usd) async {
    await parent.ensureInitialized();
    final action = {'type': 'vaultDistribute', 'vaultAddress': vaultAddress, 'usd': usd};
    final nonce = _uniqueNonce();
    final signature = await signL1Action(wallet, action, null, nonce, isMainnet);
    final payload = {'action': action, 'nonce': nonce, 'signature': signature};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> vaultModify(String vaultAddress, bool? allowDeposits, bool? alwaysCloseOnWithdraw) async {
    await parent.ensureInitialized();
    final action = {
      'type': 'vaultModify',
      'vaultAddress': vaultAddress,
      'allowDeposits': allowDeposits,
      'alwaysCloseOnWithdraw': alwaysCloseOnWithdraw
    };
    final nonce = _uniqueNonce();
    final signature = await signL1Action(wallet, action, null, nonce, isMainnet);
    final payload = {'action': action, 'nonce': nonce, 'signature': signature};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> setReferrer([String code = sdkCode]) async {
    await parent.ensureInitialized();
    final action = {'type': 'setReferrer', 'code': code};
    final nonce = _uniqueNonce();
    final signature = await signL1Action(wallet, action, null, nonce, isMainnet);
    final payload = {'action': action, 'nonce': nonce, 'signature': signature};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> registerReferrer(String code) async {
    await parent.ensureInitialized();
    final action = {'type': 'registerReferrer', 'code': code};
    final nonce = _uniqueNonce();
    final signature = await signL1Action(wallet, action, null, nonce, isMainnet);
    final payload = {'action': action, 'nonce': nonce, 'signature': signature};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> modifyUserEvm(bool usingBigBlocks) async {
    await parent.ensureInitialized();
    final action = {'type': 'evmUserModify', 'usingBigBlocks': usingBigBlocks};
    final nonce = _uniqueNonce();
    final signature = await signL1Action(wallet, action, null, nonce, isMainnet);
    final payload = {'action': action, 'nonce': nonce, 'signature': signature};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> placeTwapOrder(Map<String, dynamic> orderRequest) async {
    await parent.ensureInitialized();
    final assetIndex = await _getAssetIndex(orderRequest['coin'] as String);
    final vault = _getVaultAddress();
    final twapWire = {
      'a': assetIndex,
      'b': orderRequest['is_buy'],
      's': (orderRequest['sz'] as num).toString(),
      'r': orderRequest['reduce_only'],
      'm': orderRequest['minutes'],
      't': orderRequest['randomize'],
    };
    final action = {'type': 'twapOrder', 'twap': twapWire};
    final nonce = _uniqueNonce();
    final signature = await signL1Action(wallet, action, vault, nonce, isMainnet);
    final payload = {'action': action, 'nonce': nonce, 'signature': signature, 'vaultAddress': vault};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> cancelTwapOrder(Map<String, dynamic> cancelRequest) async {
    await parent.ensureInitialized();
    final assetIndex = await _getAssetIndex(cancelRequest['coin'] as String);
    final vault = _getVaultAddress();
    final action = {'type': 'twapCancel', 'a': assetIndex, 't': cancelRequest['twap_id']};
    final nonce = _uniqueNonce();
    final signature = await signL1Action(wallet, action, vault, nonce, isMainnet);
    final payload = {'action': action, 'nonce': nonce, 'signature': signature, 'vaultAddress': vault};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> approveAgent(Map<String, dynamic> request) async {
    await parent.ensureInitialized();
    final nonce = _uniqueNonce();
    final action = {
      'type': 'approveAgent',
      'hyperliquidChain': isMainnet ? 'Mainnet' : 'Testnet',
      'signatureChainId': isMainnet ? ChainIds.arbitrumMainnet : ChainIds.arbitrumTestnet,
      'agentAddress': request['agentAddress'],
      'agentName': request['agentName'],
      'nonce': nonce,
    };
    final signature = await signAgent(wallet, action, isMainnet);
    final payload = {'action': action, 'nonce': action['nonce'], 'signature': signature};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> approveBuilderFee(Map<String, dynamic> request) async {
    await parent.ensureInitialized();
    final nonce = DateTime.now().millisecondsSinceEpoch;
    final builderAddress = (request['builder'] as String).toLowerCase();
    final maxFeeRate = (request['maxFeeRate'] as String).endsWith('%') ? request['maxFeeRate'] : '${request['maxFeeRate']}%';
    final action = {
      'type': 'approveBuilderFee',
      'hyperliquidChain': isMainnet ? 'Mainnet' : 'Testnet',
      'signatureChainId': isMainnet ? ChainIds.arbitrumMainnet : ChainIds.arbitrumTestnet,
      'maxFeeRate': maxFeeRate,
      'builder': builderAddress,
      'nonce': nonce,
    };
    final signature = await signUserSignedAction(
      wallet,
      action,
      [
        {'name': 'hyperliquidChain', 'type': 'string'},
        {'name': 'maxFeeRate', 'type': 'string'},
        {'name': 'builder', 'type': 'address'},
        {'name': 'nonce', 'type': 'uint64'},
      ],
      'HyperliquidTransaction:ApproveBuilderFee',
      isMainnet,
    );
    final payload = {'action': action, 'nonce': action['nonce'], 'signature': signature};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> claimRewards() async {
    await parent.ensureInitialized();
    final action = {'type': 'claimRewards'};
    final nonce = _uniqueNonce();
    final signature = await signL1Action(wallet, action, null, nonce, isMainnet);
    final payload = {'action': action, 'nonce': nonce, 'signature': signature};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> createSubAccount(String name) async {
    await parent.ensureInitialized();
    final action = {'type': 'createSubAccount', 'name': name};
    final nonce = _uniqueNonce();
    final signature = await signL1Action(wallet, action, null, nonce, isMainnet);
    final payload = {'action': action, 'nonce': nonce, 'signature': signature};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> setDisplayName(String displayName) async {
    await parent.ensureInitialized();
    final action = {'type': 'setDisplayName', 'displayName': displayName};
    final nonce = _uniqueNonce();
    final signature = await signL1Action(wallet, action, null, nonce, isMainnet);
    final payload = {'action': action, 'nonce': nonce, 'signature': signature};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> spotUser(bool optOut) async {
    await parent.ensureInitialized();
    final action = {
      'type': 'spotUser',
      'toggleSpotDusting': {'optOut': optOut}
    };
    final nonce = _uniqueNonce();
    final signature = await signL1Action(wallet, action, null, nonce, isMainnet);
    final payload = {'action': action, 'nonce': nonce, 'signature': signature};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> cDeposit(BigInt wei) async {
    await parent.ensureInitialized();
    final nonce = _uniqueNonce();
    final action = {
      'type': 'cDeposit',
      'hyperliquidChain': isMainnet ? 'Mainnet' : 'Testnet',
      'signatureChainId': isMainnet ? ChainIds.arbitrumMainnet : ChainIds.arbitrumTestnet,
      'wei': wei.toString(),
      'nonce': nonce,
    };
    final signature = await signUserSignedAction(
      wallet,
      action,
      [
        {'name': 'hyperliquidChain', 'type': 'string'},
        {'name': 'wei', 'type': 'string'},
        {'name': 'nonce', 'type': 'uint64'}
      ],
      'HyperliquidTransaction:CDeposit',
      isMainnet,
    );
    final payload = {'action': action, 'nonce': action['nonce'], 'signature': signature};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> cWithdraw(BigInt wei) async {
    await parent.ensureInitialized();
    final nonce = _uniqueNonce();
    final action = {
      'type': 'cWithdraw',
      'hyperliquidChain': isMainnet ? 'Mainnet' : 'Testnet',
      'signatureChainId': isMainnet ? ChainIds.arbitrumMainnet : ChainIds.arbitrumTestnet,
      'wei': wei.toString(),
      'nonce': nonce,
    };
    final signature = await signUserSignedAction(
      wallet,
      action,
      [
        {'name': 'hyperliquidChain', 'type': 'string'},
        {'name': 'wei', 'type': 'string'},
        {'name': 'nonce', 'type': 'uint64'}
      ],
      'HyperliquidTransaction:CWithdraw',
      isMainnet,
    );
    final payload = {'action': action, 'nonce': action['nonce'], 'signature': signature};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> tokenDelegate(String validator, bool isUndelegate, BigInt wei) async {
    await parent.ensureInitialized();
    final nonce = _uniqueNonce();
    final action = {
      'type': 'tokenDelegate',
      'validator': validator,
      'isUndelegate': isUndelegate,
      'wei': wei.toString(),
      'nonce': nonce
    };
    final signature = await signL1Action(wallet, action, null, nonce, isMainnet);
    final payload = {'action': action, 'nonce': nonce, 'signature': signature};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> subAccountSpotTransfer(String subAccountUser, bool isDeposit, int token, String amount) async {
    await parent.ensureInitialized();
    final nonce = _uniqueNonce();
    final action = {
      'type': 'subAccountSpotTransfer',
      'subAccountUser': subAccountUser,
      'isDeposit': isDeposit,
      'token': token,
      'amount': amount
    };
    final signature = await signL1Action(wallet, action, null, nonce, isMainnet);
    final payload = {'action': action, 'nonce': nonce, 'signature': signature};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> reserveRequestWeight(num weight) async {
    await parent.ensureInitialized();
    final vault = _getVaultAddress();
    final action = {'type': 'reserveRequestWeight', 'weight': weight};
    final nonce = _uniqueNonce();
    final signature = await signL1Action(wallet, action, vault, nonce, isMainnet);
    final payload = {'action': action, 'nonce': nonce, 'signature': signature, 'vaultAddress': vault};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> subAccountTransfer(String subAccountUser, bool isDeposit, num usd) async {
    await parent.ensureInitialized();
    final nonce = _uniqueNonce();
    final action = {'type': 'subAccountTransfer', 'subAccountUser': subAccountUser, 'isDeposit': isDeposit, 'usd': usd};
    final signature = await signL1Action(wallet, action, null, nonce, isMainnet);
    final payload = {'action': action, 'nonce': nonce, 'signature': signature};
    return _httpApi.makeRequest(payload, 1);
  }

  Future<dynamic> transferBetweenSpotAndPerp(num usdc, bool toPerp) async {
    await parent.ensureInitialized();
    final nonce = _uniqueNonce();
    final action = {
      'type': 'usdClassTransfer',
      'hyperliquidChain': isMainnet ? 'Mainnet' : 'Testnet',
      'signatureChainId': isMainnet ? ChainIds.arbitrumMainnet : ChainIds.arbitrumTestnet,
      'amount': usdc.toString(),
      'toPerp': toPerp,
      'nonce': nonce,
    };
    final signature = await signUserSignedAction(
      wallet,
      action,
      [
        {'name': 'hyperliquidChain', 'type': 'string'},
        {'name': 'amount', 'type': 'string'},
        {'name': 'toPerp', 'type': 'bool'},
        {'name': 'nonce', 'type': 'uint64'}
      ],
      'HyperliquidTransaction:UsdClassTransfer',
      isMainnet,
    );
    final payload = {'action': action, 'nonce': action['nonce'], 'signature': signature};
    return _httpApi.makeRequest(payload, 1);
  }
}
