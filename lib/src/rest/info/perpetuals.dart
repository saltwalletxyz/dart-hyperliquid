import 'package:hyperliquid/src/utils/http_api.dart';
import 'package:hyperliquid/src/utils/symbol_conversion.dart';
import 'package:hyperliquid/src/constants.dart';
import 'package:hyperliquid/src/hyperliquid_base.dart';

class PerpetualsInfoAPI {
  final HttpApi httpApi;
  final SymbolConversion symbolConversion;
  final Hyperliquid parent;

  PerpetualsInfoAPI(this.httpApi, this.symbolConversion, this.parent);

  Future<dynamic> getMeta({bool rawResponse = false}) async {
    final response = await httpApi.makeRequest<dynamic>({'type': InfoType.meta});
    if (rawResponse) return response;
    return await symbolConversion.convertResponse(response, ['name', 'coin', 'symbol'], 'PERP');
  }

  Future<dynamic> getMetaAndAssetCtxs({bool rawResponse = false}) async {
    final response = await httpApi.makeRequest<dynamic>({'type': InfoType.perpsMetaAndAssetCtxs});
    if (rawResponse) return response;
    return await symbolConversion.convertResponse(response, ['name', 'coin', 'symbol'], 'PERP');
  }

  Future<dynamic> getClearinghouseState(String user, {bool rawResponse = false}) async {
    final response = await httpApi.makeRequest<dynamic>({'type': InfoType.perpsClearinghouseState, 'user': user});
    if (rawResponse) return response;
    return await symbolConversion.convertResponse(response);
  }

  Future<dynamic> getUserFunding(String user, int startTime, [int? endTime, bool rawResponse = false]) async {
    final payload = {'type': InfoType.userFunding, 'user': user, 'startTime': startTime, if (endTime != null) 'endTime': endTime};
    final response = await httpApi.makeRequest<dynamic>(payload, 20);
    if (rawResponse) return response;
    return await symbolConversion.convertResponse(response);
  }

  Future<dynamic> getUserNonFundingLedgerUpdates(String user, int startTime, [int? endTime, bool rawResponse = false]) async {
    final payload = {
      'type': InfoType.userNonFundingLedgerUpdates,
      'user': user,
      'startTime': startTime,
      if (endTime != null) 'endTime': endTime
    };
    final response = await httpApi.makeRequest<dynamic>(payload, 20);
    if (rawResponse) return response;
    return await symbolConversion.convertResponse(response);
  }

  Future<dynamic> getFundingHistory(String coin, int startTime, [int? endTime, bool rawResponse = false]) async {
    final response = await httpApi.makeRequest<dynamic>({
      'type': InfoType.fundingHistory,
      'coin': await symbolConversion.convertSymbol(coin, 'reverse'),
      'startTime': startTime,
      'endTime': endTime,
    }, 20);
    if (rawResponse) return response;
    return await symbolConversion.convertResponse(response);
  }

  Future<dynamic> getPredictedFundings({bool rawResponse = false}) async {
    final response = await httpApi.makeRequest<dynamic>({'type': InfoType.predictedFundings}, 20);
    if (rawResponse) return response;
    return await symbolConversion.convertResponse(response);
  }

  Future<List<dynamic>> getPerpsAtOpenInterestCap({bool rawResponse = false}) async {
    final response = await httpApi.makeRequest<dynamic>({'type': InfoType.perpsAtOpenInterestCap});
    if (rawResponse) return (response as List).cast<dynamic>();
    final list = (response as List).cast<String>();
    final converted = <String>[];
    for (final s in list) {
      converted.add(await symbolConversion.convertSymbol(s, '', 'PERP'));
    }
    return converted;
  }
}
