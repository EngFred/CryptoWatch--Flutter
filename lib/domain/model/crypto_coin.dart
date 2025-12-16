import 'package:equatable/equatable.dart';

class CryptoCoin extends Equatable {
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
  final List<double> sparkline;

  const CryptoCoin({
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
  });

  @override
  List<Object?> get props => [id, name, symbol, currentPrice];
}
