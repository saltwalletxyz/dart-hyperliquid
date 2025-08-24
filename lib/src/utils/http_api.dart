import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hyperliquid/src/utils/rate_limiter.dart';
import 'package:hyperliquid/src/constants.dart';

class HttpApi {
  final String baseUrl;
  final String endpoint;
  final RateLimiter rateLimiter;

  HttpApi(this.baseUrl, this.endpoint, this.rateLimiter);

  Future<T> makeRequest<T>(
    dynamic payload, [
    int weight = 2,
    String? overrideEndpoint,
  ]) async {
    await rateLimiter.waitForToken(weight);
    final normalized = _normalizePayload(payload);
    final response = await http.post(
      Uri.parse('$baseUrl${overrideEndpoint ?? endpoint}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(normalized),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data == null) {
        throw Exception('Received null response data');
      }
      return data as T;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<dynamic> post(dynamic body) async {
    return makeRequest<dynamic>(body, 2, null);
  }

  dynamic _normalizePayload(dynamic payload) {
    if (payload is Map<String, dynamic>) {
      final copy = Map<String, dynamic>.from(payload);
      if (copy['type'] is InfoType) {
        copy['type'] = (copy['type'] as InfoType).name; // e.g. allMids -> 'allMids'
      }
      return copy;
    }
    return payload;
  }
}
