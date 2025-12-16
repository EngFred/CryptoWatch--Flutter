import 'package:json_annotation/json_annotation.dart';

part 'dtos.g.dart';

@JsonSerializable()
class CoinDto {
  final String id;
  final String symbol;
  final String name;
  final String image;
  @JsonKey(name: 'current_price')
  final double? currentPrice;
  @JsonKey(name: 'price_change_percentage_24h')
  final double? priceChangePercentage24h;
  @JsonKey(name: 'high_24h')
  final double? high24h;
  @JsonKey(name: 'low_24h')
  final double? low24h;
  @JsonKey(name: 'market_cap')
  final double? marketCap;
  @JsonKey(name: 'total_volume')
  final double? totalVolume;
  @JsonKey(name: 'sparkline_in_7d')
  final SparklineDto? sparklineIn7d;

  CoinDto({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    this.currentPrice,
    this.priceChangePercentage24h,
    this.high24h,
    this.low24h,
    this.marketCap,
    this.totalVolume,
    this.sparklineIn7d,
  });

  factory CoinDto.fromJson(Map<String, dynamic> json) =>
      _$CoinDtoFromJson(json);
}

@JsonSerializable()
class SparklineDto {
  final List<double>? price;
  SparklineDto({this.price});
  factory SparklineDto.fromJson(Map<String, dynamic> json) =>
      _$SparklineDtoFromJson(json);
}

@JsonSerializable()
class SearchResponseDto {
  final List<SearchCoinDto> coins;
  SearchResponseDto({required this.coins});
  factory SearchResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseDtoFromJson(json);
}

@JsonSerializable()
class SearchCoinDto {
  final String id;
  final String name;
  final String symbol;
  SearchCoinDto({required this.id, required this.name, required this.symbol});
  factory SearchCoinDto.fromJson(Map<String, dynamic> json) =>
      _$SearchCoinDtoFromJson(json);
}
