import 'package:hyperliquid/src/utils/http_api.dart';
import 'package:hyperliquid/src/utils/symbol_conversion.dart';
// import 'package:hyperliquid/src/types/index.dart';
import 'package:hyperliquid/src/hyperliquid_base.dart';
import 'package:hyperliquid/src/constants.dart';
import 'package:hyperliquid/src/types/general.dart';

class GeneralInfoAPI {
  final HttpApi httpApi;
  final SymbolConversion symbolConversion;
  final Hyperliquid parent;

  GeneralInfoAPI(this.httpApi, this.symbolConversion, this.parent);

  Future<dynamic> getAllMids({bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.post({
      'type': InfoType.allMids,
    });
    if (rawResponse) {
      return response;
    }
    // The API returns mids directly as a flat map, so we need to wrap it
    final midsMap = Map<String, String>.from(response as Map);
    return AllMids(mids: midsMap);
  }

  Future<dynamic> getUserOpenOrders(String user, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.post({
      'type': InfoType.openOrders,
      'user': user,
    });
    if (rawResponse) {
      return response;
    }
    return UserOpenOrders.fromJson({'orders': response});
  }

  Future<dynamic> getFrontendOpenOrders(String user, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.post({
      'type': InfoType.frontendOpenOrders,
      'user': user,
    });
    if (rawResponse) {
      return response;
    }
    return FrontendOpenOrders.fromJson({'orders': response});
  }

  Future<dynamic> getUserFills(String user, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.post({
      'type': InfoType.userFills,
      'user': user,
    });
    if (rawResponse) {
      return response;
    }
    return UserFills.fromJson({'fills': response});
  }

  Future<dynamic> getUserFillsByTime(String user, int startTime, int endTime, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.post({
      'type': InfoType.userFillsByTime,
      'user': user,
      'startTime': startTime,
      'endTime': endTime,
    });
    if (rawResponse) {
      return response;
    }
    return UserFills.fromJson({'fills': response});
  }

  Future<dynamic> getUserRateLimit(String user, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.post({
      'type': InfoType.userRateLimit,
      'user': user,
    });
    if (rawResponse) {
      return response;
    }
    return UserRateLimit.fromJson(Map<String, dynamic>.from(response as Map));
  }

  Future<dynamic> getOrderStatus(String user, int oid, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.post({
      'type': InfoType.orderStatus,
      'user': user,
      'oid': oid,
    });
    if (rawResponse) {
      return response;
    }
    return OrderStatus.fromJson(Map<String, dynamic>.from(response as Map));
  }

  Future<dynamic> getL2Book(String coin, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.post({
      'type': InfoType.l2Book,
      'coin': coin,
    });
    if (rawResponse) {
      return response;
    }
    return L2Book.fromJson(Map<String, dynamic>.from(response as Map));
  }

  Future<dynamic> getCandleSnapshot(String coin, String interval, int startTime, int endTime, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.post({
      'type': InfoType.candleSnapshot,
      'req': {
        'coin': coin,
        'interval': interval,
        'startTime': startTime,
        'endTime': endTime,
      }
    });
    if (rawResponse) {
      return response;
    }
    return CandleSnapshot.fromJson({'candles': response});
  }

  // Additional endpoints for parity with TS SDK (dynamic typing for now)

  Future<dynamic> getMaxBuilderFee(String user, String builder, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.makeRequest<dynamic>({
      'type': InfoType.maxBuilderFee,
      'user': user,
      'builder': builder,
    });
    return rawResponse ? response : symbolConversion.convertToNumber(response);
  }

  Future<dynamic> getHistoricalOrders(String user, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.makeRequest<dynamic>({
      'type': InfoType.historicalOrders,
      'user': user,
    });
    return rawResponse ? response : symbolConversion.convertResponse(response);
  }

  Future<dynamic> getUserTwapSliceFills(String user, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.makeRequest<dynamic>({
      'type': InfoType.userTwapSliceFills,
      'user': user,
    });
    return rawResponse ? response : symbolConversion.convertResponse(response);
  }

  Future<dynamic> getSubAccounts(String user, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.makeRequest<dynamic>({
      'type': InfoType.subAccounts,
      'user': user,
    });
    return rawResponse ? response : symbolConversion.convertResponse(response);
  }

  Future<dynamic> getVaultDetails(String vaultAddress, [String? user, bool rawResponse = false]) async {
    await parent.ensureInitialized();
    final payload = {
      'type': InfoType.vaultDetails,
      'vaultAddress': vaultAddress,
      if (user != null) 'user': user,
    };
    final response = await httpApi.makeRequest<dynamic>(payload);
    return rawResponse ? response : symbolConversion.convertResponse(response);
  }

  Future<dynamic> getUserVaultEquities(String user, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.makeRequest<dynamic>({
      'type': InfoType.userVaultEquities,
      'user': user,
    });
    return rawResponse ? response : symbolConversion.convertResponse(response);
  }

  Future<dynamic> getUserRole(String user, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.makeRequest<dynamic>({
      'type': InfoType.userRole,
      'user': user,
    });
    return rawResponse ? response : symbolConversion.convertResponse(response);
  }

  Future<dynamic> getDelegations(String user, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.makeRequest<dynamic>({
      'type': InfoType.delegations,
      'user': user,
    });
    return rawResponse ? response : symbolConversion.convertResponse(response);
  }

  Future<dynamic> getDelegatorSummary(String user, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.makeRequest<dynamic>({
      'type': InfoType.delegatorSummary,
      'user': user,
    });
    return rawResponse ? response : symbolConversion.convertResponse(response);
  }

  Future<dynamic> getDelegatorHistory(String user, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.makeRequest<dynamic>({
      'type': InfoType.delegatorHistory,
      'user': user,
    });
    return rawResponse ? response : symbolConversion.convertResponse(response);
  }

  Future<dynamic> getDelegatorRewards(String user, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.makeRequest<dynamic>({
      'type': InfoType.delegatorRewards,
      'user': user,
    });
    return rawResponse ? response : symbolConversion.convertResponse(response);
  }

  Future<dynamic> validatorSummaries({bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.makeRequest<dynamic>({'type': InfoType.validatorSummaries});
    return rawResponse ? response : symbolConversion.convertResponse(response);
  }

  Future<dynamic> vaultSummaries({bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.makeRequest<dynamic>({'type': InfoType.vaultSummaries});
    return rawResponse ? response : symbolConversion.convertResponse(response);
  }

  Future<dynamic> userFees(String user, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.makeRequest<dynamic>({'type': InfoType.userFees, 'user': user});
    return rawResponse ? response : symbolConversion.convertResponse(response);
  }

  Future<dynamic> portfolio(String user, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.makeRequest<dynamic>({'type': InfoType.portfolio, 'user': user});
    return rawResponse ? response : symbolConversion.convertResponse(response);
  }

  Future<dynamic> preTransferCheck(String user, String source, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.makeRequest<dynamic>({'type': InfoType.preTransferCheck, 'user': user, 'source': source});
    return rawResponse ? response : symbolConversion.convertResponse(response);
  }

  Future<dynamic> referral(String user, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.makeRequest<dynamic>({'type': InfoType.referral, 'user': user});
    return rawResponse ? response : symbolConversion.convertResponse(response);
  }

  Future<dynamic> extraAgents(String user, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.makeRequest<dynamic>({'type': InfoType.extraAgents, 'user': user});
    return rawResponse ? response : symbolConversion.convertResponse(response);
  }

  Future<dynamic> isVip(String user, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.makeRequest<dynamic>({'type': InfoType.isVip, 'user': user});
    return rawResponse ? response : symbolConversion.convertResponse(response);
  }

  Future<dynamic> legalCheck(String user, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.makeRequest<dynamic>({'type': InfoType.legalCheck, 'user': user});
    return rawResponse ? response : symbolConversion.convertResponse(response);
  }

  Future<dynamic> userTwapSliceFillsByTime(String user, int startTime,
      [int? endTime, bool? aggregateByTime, bool rawResponse = false]) async {
    await parent.ensureInitialized();
    final payload = {
      'type': InfoType.userTwapSliceFillsByTime,
      'user': user,
      'startTime': startTime,
      if (endTime != null) 'endTime': endTime,
      if (aggregateByTime != null) 'aggregateByTime': aggregateByTime,
    };
    final response = await httpApi.makeRequest<dynamic>(payload);
    return rawResponse ? response : symbolConversion.convertResponse(response);
  }

  Future<dynamic> twapHistory(String user, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.makeRequest<dynamic>({'type': InfoType.twapHistory, 'user': user});
    return rawResponse ? response : symbolConversion.convertResponse(response);
  }

  Future<dynamic> userToMultiSigSigners(String user, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response = await httpApi.makeRequest<dynamic>({'type': InfoType.userToMultiSigSigners, 'user': user});
    return rawResponse ? response : symbolConversion.convertResponse(response);
  }

  Future<dynamic> getBuilderFeeApproval(String user, String builderAddress, {bool rawResponse = false}) async {
    await parent.ensureInitialized();
    final response =
        await httpApi.makeRequest<dynamic>({'type': InfoType.builderFeeApproval, 'user': user, 'builderAddress': builderAddress});
    return rawResponse ? response : symbolConversion.convertResponse(response);
  }

  Future<dynamic> getUserOrderHistory(String user, int startTime, [int? endTime, bool rawResponse = false]) async {
    await parent.ensureInitialized();
    final payload = {
      'type': InfoType.userOrderHistory,
      'user': user,
      'startTime': startTime,
      if (endTime != null) 'endTime': endTime
    };
    final response = await httpApi.makeRequest<dynamic>(payload, 20);
    return rawResponse ? response : symbolConversion.convertResponse(response);
  }
}
