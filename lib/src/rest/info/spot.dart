import 'package:hyperliquid/src/utils/http_api.dart';
import 'package:hyperliquid/src/utils/symbol_conversion.dart';
import 'package:hyperliquid/src/constants.dart';

class SpotInfoAPI {
  final HttpApi httpApi;
  final SymbolConversion symbolConversion;
  SpotInfoAPI(this.httpApi, this.symbolConversion);

  Future<dynamic> getSpotMeta({bool rawResponse = false}) async {
    final response = await httpApi.makeRequest<dynamic>({'type': InfoType.spotMeta});
    if (rawResponse) return response;
    return await symbolConversion.convertResponse(response, ['name', 'coin', 'symbol'], 'SPOT');
  }

  Future<dynamic> getSpotClearinghouseState(String user, {bool rawResponse = false}) async {
    final response = await httpApi.makeRequest<dynamic>({'type': InfoType.spotClearinghouseState, 'user': user});
    if (rawResponse) return response;
    return await symbolConversion.convertResponse(response, ['name', 'coin', 'symbol'], 'SPOT');
  }

  Future<dynamic> getSpotMetaAndAssetCtxs({bool rawResponse = false}) async {
    final response = await httpApi.makeRequest<dynamic>({'type': InfoType.spotMetaAndAssetCtxs});
    if (rawResponse) return response;
    return await symbolConversion.convertResponse(response);
  }

  Future<dynamic> getTokenDetails(String tokenId, {bool rawResponse = false}) async {
    final response = await httpApi.makeRequest<dynamic>({'type': InfoType.tokenDetails, 'tokenId': tokenId}, 20);
    if (rawResponse) return response;
    return await symbolConversion.convertResponse(response);
  }

  Future<dynamic> getSpotDeployState(String user, {bool rawResponse = false}) async {
    final response = await httpApi.makeRequest<dynamic>({'type': InfoType.spotDeployState, 'user': user}, 20);
    if (rawResponse) return response;
    return await symbolConversion.convertResponse(response);
  }
}
