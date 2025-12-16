import 'dart:convert';
import '../../domain/model/crypto_coin.dart';
import '../local/crypto_entity.dart';
import '../remote/dtos.dart';

extension CoinDtoMapper on CoinDto {
  CryptoEntity toEntity(int page) {
    return CryptoEntity(
      id: id,
      symbol: symbol.toUpperCase(),
      name: name,
      image: image,
      currentPrice: currentPrice ?? 0.0,
      priceChangePercentage24h: priceChangePercentage24h ?? 0.0,
      high24h: high24h ?? 0.0,
      low24h: low24h ?? 0.0,
      marketCap: marketCap ?? 0.0,
      volume: totalVolume ?? 0.0,
      sparkline: jsonEncode(
        sparklineIn7d?.price ?? [],
      ), // Convert List to String for DB
      page: page,
    );
  }
}

extension CryptoEntityMapper on CryptoEntity {
  CryptoCoin toDomain() {
    List<double> parsedSparkline = [];
    try {
      parsedSparkline = (jsonDecode(sparkline) as List)
          .map((e) => (e as num).toDouble())
          .toList();
    } catch (_) {}

    return CryptoCoin(
      id: id,
      symbol: symbol,
      name: name,
      image: image,
      currentPrice: currentPrice,
      priceChangePercentage24h: priceChangePercentage24h,
      high24h: high24h,
      low24h: low24h,
      marketCap: marketCap,
      volume: volume,
      sparkline: parsedSparkline,
    );
  }
}
