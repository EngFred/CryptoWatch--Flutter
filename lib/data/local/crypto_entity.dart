import 'package:floor/floor.dart';

@Entity(tableName: 'coins')
class CryptoEntity {
  @primaryKey
  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;
  final double priceChangePercentage24h;
  final double high24h;
  final double low24h;
  final double marketCap;
  final double volume;
  final String
  sparkline; // Floor doesn't support List<double> directly, we store as JSON string
  final int page;

  CryptoEntity({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.priceChangePercentage24h,
    required this.high24h,
    required this.low24h,
    required this.marketCap,
    required this.volume,
    required this.sparkline,
    required this.page,
  });
}
