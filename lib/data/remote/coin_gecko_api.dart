import 'package:dio/dio.dart';
import 'dtos.dart';

class CoinGeckoApi {
  final Dio _dio;
  final String baseUrl;

  CoinGeckoApi(this._dio, {this.baseUrl = "https://api.coingecko.com/api/v3/"});

  Future<List<CoinDto>> getCoins({
    String currency = "usd",
    String order = "market_cap_desc",
    int perPage = 20,
    int page = 1,
    bool sparkline = true,
    String? ids,
  }) async {
    try {
      final response = await _dio.get(
        '${baseUrl}coins/markets',
        queryParameters: {
          'vs_currency': currency,
          'order': order,
          'per_page': perPage,
          'page': page,
          'sparkline': sparkline,
          if (ids != null) 'ids': ids,
        },
      );

      // Dio automatically decodes JSON, we just map it to our DTOs
      final List<dynamic> data = response.data;
      return data.map((json) => CoinDto.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<SearchResponseDto> searchGlobal(String query) async {
    try {
      final response = await _dio.get(
        '${baseUrl}search',
        queryParameters: {'query': query},
      );

      return SearchResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
