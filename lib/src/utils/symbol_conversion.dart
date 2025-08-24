import 'dart:async';
import 'package:hyperliquid/src/constants.dart';
import 'package:hyperliquid/src/utils/http_api.dart';
import 'package:hyperliquid/src/utils/rate_limiter.dart';

class SymbolConversion {
  final HttpApi _httpApi;
  final bool _disableAssetMapRefresh;
  int _refreshIntervalMs;

  Timer? _timer;
  bool _initialized = false;
  int _consecutiveFailures = 0;
  final int _maxConsecutiveFailures = 5;

  final Map<String, int> _assetToIndexMap = {};
  final Map<String, String> _exchangeToInternalNameMap = {};

  SymbolConversion(
    String baseUrl,
    RateLimiter rateLimiter, [
    this._disableAssetMapRefresh = false,
    this._refreshIntervalMs = 60000,
  ]) : _httpApi = HttpApi(baseUrl, Endpoints.info, rateLimiter);

  Future<void> initialize() async {
    if (_initialized) return;
    await _refreshAssetMaps();
    if (!_disableAssetMapRefresh) {
      _startPeriodicRefresh();
    }
    _initialized = true;
  }

  Future<void> _ensureInitialized() async {
    if (!_initialized) {
      await initialize();
    }
  }

  void _startPeriodicRefresh() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: _refreshIntervalMs), (_) async {
      try {
        await _refreshAssetMaps();
        _consecutiveFailures = 0;
      } catch (_) {
        _consecutiveFailures++;
        if (_consecutiveFailures >= _maxConsecutiveFailures) {
          disablePeriodicRefresh();
        }
      }
    });
  }

  void stopPeriodicRefresh() => disablePeriodicRefresh();

  void enablePeriodicRefresh() {
    if (!_disableAssetMapRefresh && _initialized) {
      _startPeriodicRefresh();
    }
  }

  void disablePeriodicRefresh() {
    _timer?.cancel();
    _timer = null;
  }

  bool isRefreshEnabled() => !_disableAssetMapRefresh && _timer != null;

  int getRefreshInterval() => _refreshIntervalMs;

  void setRefreshInterval(int intervalMs) {
    _refreshIntervalMs = intervalMs;
    if (_timer != null) {
      disablePeriodicRefresh();
      enablePeriodicRefresh();
    }
  }

  Future<String?> getInternalName(String exchangeName) async {
    await _ensureInitialized();
    return _exchangeToInternalNameMap[exchangeName];
  }

  Future<String> convertSymbol(String symbol, [String mode = '', String symbolMode = '']) async {
    await _ensureInitialized();
    String result;
    if (mode == 'reverse') {
      for (final entry in _exchangeToInternalNameMap.entries) {
        if (entry.value == symbol) return entry.key;
      }
      result = symbol;
    } else {
      result = _exchangeToInternalNameMap[symbol] ?? symbol;
    }
    if (symbolMode == 'SPOT' && !result.endsWith('-SPOT')) {
      result = '$symbol-SPOT';
    } else if (symbolMode == 'PERP' && !result.endsWith('-PERP')) {
      result = '$symbol-PERP';
    }
    return result;
  }

  Future<int?> getAssetIndex(String assetSymbol) async {
    await _ensureInitialized();
    return _assetToIndexMap[assetSymbol];
  }

  Future<Map<String, List<String>>> getAllAssets() async {
    await _ensureInitialized();
    final perp = <String>[];
    final spot = <String>[];
    for (final key in _assetToIndexMap.keys) {
      if (key.endsWith('-PERP')) perp.add(key);
      if (key.endsWith('-SPOT')) spot.add(key);
    }
    return {'perp': perp, 'spot': spot};
  }

  Future<dynamic> convertResponse(dynamic response,
      [List<String> symbolFields = const ['coin', 'symbol'], String symbolMode = '']) async {
    return _convertSymbolsInObject(response, symbolFields, symbolMode);
  }

  dynamic convertToNumber(dynamic value) {
    if (value is String) {
      final intVal = int.tryParse(value);
      if (intVal != null) return intVal;
      final doubleVal = double.tryParse(value);
      if (doubleVal != null) return doubleVal;
    }
    return value;
  }

  Future<dynamic> _convertSymbolsInObject(dynamic obj, List<String> symbolsFields, String symbolMode) async {
    if (obj == null) return null;
    if (obj is List) {
      return Future.wait(obj.map((e) => _convertSymbolsInObject(e, symbolsFields, symbolMode)));
    }
    if (obj is! Map) return convertToNumber(obj);
    final Map<String, dynamic> converted = {};
    for (final entry in obj.entries) {
      final key = entry.key as String;
      final value = entry.value;
      if (symbolsFields.contains(key) && value is String) {
        converted[key] = await convertSymbol(value, '', symbolMode);
      } else if (key == 'side' && value is String) {
        converted[key] = value == 'A'
            ? 'sell'
            : value == 'B'
                ? 'buy'
                : value;
      } else {
        converted[key] = await _convertSymbolsInObject(value, symbolsFields, symbolMode);
      }
    }
    return converted;
  }

  Future<void> _refreshAssetMaps() async {
    final perpMeta = await _httpApi.post({'type': InfoType.perpsMetaAndAssetCtxs});
    final spotMeta = await _httpApi.post({'type': InfoType.spotMetaAndAssetCtxs});

    _assetToIndexMap.clear();
    _exchangeToInternalNameMap.clear();

    if (perpMeta is List && perpMeta.isNotEmpty && perpMeta[0]['universe'] is List) {
      final List<dynamic> universe = (perpMeta[0]['universe'] as List).cast<dynamic>();
      for (var i = 0; i < universe.length; i++) {
        final item = universe[i] as Map<String, dynamic>;
        final name = item['name'] as String;
        final internal = '$name-PERP';
        _assetToIndexMap[internal] = i;
        _exchangeToInternalNameMap[name] = internal;
      }
    }

    if (spotMeta is List && spotMeta.isNotEmpty && spotMeta[0]['tokens'] is List && spotMeta[0]['universe'] is List) {
      final List<dynamic> tokens = (spotMeta[0]['tokens'] as List).cast<dynamic>();
      final List<dynamic> universe = (spotMeta[0]['universe'] as List).cast<dynamic>();
      for (final tokenRaw in tokens) {
        final token = tokenRaw as Map<String, dynamic>;
        final tokenName = token['name'] as String;
        final tokenIndex = token['index'] as int;
        Map<String, dynamic>? universeItem;
        for (final uRaw in universe) {
          final u = uRaw as Map<String, dynamic>;
          final uTokens = (u['tokens'] as List?)?.cast<dynamic>() ?? [];
          if (uTokens.isNotEmpty && uTokens.first == tokenIndex) {
            universeItem = u;
            break;
          }
        }
        if (universeItem != null) {
          final internal = '$tokenName-SPOT';
          final exchangeName = universeItem['name'] as String;
          final index = universeItem['index'] as int;
          _assetToIndexMap[internal] = 10000 + index;
          _exchangeToInternalNameMap[exchangeName] = internal;
        }
      }
    }
  }

  /// Test helper: manually register an asset mapping and mark initialized to avoid network calls.
  /// Not for production use.
  void registerTestAsset(String exchangeName, String internalName, int index) {
    _assetToIndexMap[internalName] = index;
    _exchangeToInternalNameMap[exchangeName] = internalName;
    _initialized = true;
  }
}
