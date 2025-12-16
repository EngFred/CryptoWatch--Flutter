// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinDto _$CoinDtoFromJson(Map<String, dynamic> json) => CoinDto(
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      currentPrice: (json['current_price'] as num?)?.toDouble(),
      priceChangePercentage24h:
          (json['price_change_percentage_24h'] as num?)?.toDouble(),
      high24h: (json['high_24h'] as num?)?.toDouble(),
      low24h: (json['low_24h'] as num?)?.toDouble(),
      marketCap: (json['market_cap'] as num?)?.toDouble(),
      totalVolume: (json['total_volume'] as num?)?.toDouble(),
      sparklineIn7d: json['sparkline_in_7d'] == null
          ? null
          : SparklineDto.fromJson(
              json['sparkline_in_7d'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CoinDtoToJson(CoinDto instance) => <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'name': instance.name,
      'image': instance.image,
      'current_price': instance.currentPrice,
      'price_change_percentage_24h': instance.priceChangePercentage24h,
      'high_24h': instance.high24h,
      'low_24h': instance.low24h,
      'market_cap': instance.marketCap,
      'total_volume': instance.totalVolume,
      'sparkline_in_7d': instance.sparklineIn7d,
    };

SparklineDto _$SparklineDtoFromJson(Map<String, dynamic> json) => SparklineDto(
      price: (json['price'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$SparklineDtoToJson(SparklineDto instance) =>
    <String, dynamic>{
      'price': instance.price,
    };

SearchResponseDto _$SearchResponseDtoFromJson(Map<String, dynamic> json) =>
    SearchResponseDto(
      coins: (json['coins'] as List<dynamic>)
          .map((e) => SearchCoinDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchResponseDtoToJson(SearchResponseDto instance) =>
    <String, dynamic>{
      'coins': instance.coins,
    };

SearchCoinDto _$SearchCoinDtoFromJson(Map<String, dynamic> json) =>
    SearchCoinDto(
      id: json['id'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
    );

Map<String, dynamic> _$SearchCoinDtoToJson(SearchCoinDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'symbol': instance.symbol,
    };
