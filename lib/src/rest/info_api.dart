import 'package:hyperliquid/src/utils/rate_limiter.dart';
import 'package:hyperliquid/src/utils/http_api.dart';
import 'package:hyperliquid/src/utils/symbol_conversion.dart';
import 'package:hyperliquid/src/constants.dart';
import 'package:hyperliquid/src/hyperliquid_base.dart';
import 'package:hyperliquid/src/rest/info/general.dart' as general;
import 'package:hyperliquid/src/rest/info/spot.dart' as spot;
import 'package:hyperliquid/src/rest/info/perpetuals.dart' as perps;

class InfoAPI {
  late final general.GeneralInfoAPI generalAPI;
  late final spot.SpotInfoAPI spotAPI;
  late final perps.PerpetualsInfoAPI perpetualsAPI;
  final HttpApi _httpApi;
  final SymbolConversion symbolConversion;
  final Hyperliquid parent;

  InfoAPI(String baseUrl, RateLimiter rateLimiter, this.symbolConversion, this.parent)
      : _httpApi = HttpApi(baseUrl, Endpoints.info, rateLimiter) {
    generalAPI = general.GeneralInfoAPI(_httpApi, symbolConversion, parent);
    spotAPI = spot.SpotInfoAPI(_httpApi, symbolConversion);
    perpetualsAPI = perps.PerpetualsInfoAPI(_httpApi, symbolConversion, parent);
  }

  Future<int?> getAssetIndex(String assetName) async {
    await parent.ensureInitialized();
    return symbolConversion.getAssetIndex(assetName);
  }

  Future<String?> getInternalName(String exchangeName) async {
    await parent.ensureInitialized();
    return symbolConversion.getInternalName(exchangeName);
  }

  Future<Map<String, List<String>>> getAllAssets() async {
    await parent.ensureInitialized();
    return symbolConversion.getAllAssets();
  }

  // General info proxies for convenience
  Future<dynamic> getAllMids({bool rawResponse = false}) => generalAPI.getAllMids(rawResponse: rawResponse);
  Future<dynamic> getUserOpenOrders(String user, {bool rawResponse = false}) =>
      generalAPI.getUserOpenOrders(user, rawResponse: rawResponse);
  Future<dynamic> getFrontendOpenOrders(String user, {bool rawResponse = false}) =>
      generalAPI.getFrontendOpenOrders(user, rawResponse: rawResponse);
  Future<dynamic> getUserFills(String user, {bool rawResponse = false}) =>
      generalAPI.getUserFills(user, rawResponse: rawResponse);
  Future<dynamic> getUserFillsByTime(String user, int startTime, int endTime, {bool rawResponse = false}) =>
      generalAPI.getUserFillsByTime(user, startTime, endTime, rawResponse: rawResponse);
  Future<dynamic> getUserRateLimit(String user, {bool rawResponse = false}) =>
      generalAPI.getUserRateLimit(user, rawResponse: rawResponse);
  Future<dynamic> getOrderStatus(String user, int oid, {bool rawResponse = false}) =>
      generalAPI.getOrderStatus(user, oid, rawResponse: rawResponse);
  Future<dynamic> getL2Book(String coin, {bool rawResponse = false}) => generalAPI.getL2Book(coin, rawResponse: rawResponse);
  Future<dynamic> getCandleSnapshot(String coin, String interval, int startTime, int endTime, {bool rawResponse = false}) =>
      generalAPI.getCandleSnapshot(coin, interval, startTime, endTime, rawResponse: rawResponse);
}
