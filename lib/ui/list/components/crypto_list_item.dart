import 'package:flutter/material.dart';
import '../../../domain/model/crypto_coin.dart';
import '../../common/coin_image.dart';
import '../../common/sparkline_chart.dart';

class CryptoListItem extends StatelessWidget {
  final CryptoCoin coin;
  final Function(String) onTap;

  const CryptoListItem({super.key, required this.coin, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isPositive = coin.priceChangePercentage24h >= 0;
    final changeColor = isPositive
        ? const Color(0xFF00C853)
        : const Color(0xFFD50000);

    return InkWell(
      onTap: () => onTap(coin.id),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CoinImage(url: coin.image),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coin.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    coin.symbol.toUpperCase(),
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
            // Sparkline
            SizedBox(
              width: 80,
              height: 40,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SparklineChart(data: coin.sparkline, color: changeColor),
              ),
            ),
            // Price Column
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "\$${coin.currentPrice}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "${coin.priceChangePercentage24h.toStringAsFixed(2)}%",
                  style: TextStyle(color: changeColor, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
