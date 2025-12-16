import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../di/injection.dart';
import '../../util/currency_utils.dart';
import '../../ui/common/sparkline_chart.dart';
import 'bloc/coin_detail_bloc.dart';
import 'components/stat_card.dart';
import 'components/time_tab.dart';

class CryptoDetailScreen extends StatelessWidget {
  final String coinId;

  const CryptoDetailScreen({super.key, required this.coinId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<CoinDetailBloc>()..add(CoinDetailLoadRequested(coinId)),
      child: const _CryptoDetailView(),
    );
  }
}

class _CryptoDetailView extends StatelessWidget {
  const _CryptoDetailView();

  @override
  Widget build(BuildContext context) {
    final coinState = context.watch<CoinDetailBloc>().state;
    final coinName = coinState is CoinDetailLoaded ? coinState.coin.name : '';

    final double bottomInset = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          coinName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // Sticky Trade button at the bottom
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 16 + bottomInset),
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2979FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              /* TODO: Trade Action */
            },
            child: const Text(
              "Trade",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<CoinDetailBloc, CoinDetailState>(
        builder: (context, state) {
          if (state is CoinDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF2979FF)),
            );
          } else if (state is CoinDetailError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state is CoinDetailLoaded) {
            final coin = state.coin;
            final isPositive = coin.priceChangePercentage24h >= 0;
            final color = isPositive
                ? const Color(0xFF00C853)
                : const Color(0xFFD50000);

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Header Price Section
                  Text(
                    "\$${coin.currentPrice}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${isPositive ? "+" : ""}${coin.priceChangePercentage24h.toStringAsFixed(2)}%",
                        style: TextStyle(
                          color: color,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "24h",
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // 2. Chart Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        // Chart
                        SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: SparklineChart(
                            data: coin.sparkline,
                            color: color,
                            strokeWidth: 2.5,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Time Range Tabs
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TimeTab(text: "1H", isSelected: false),
                            TimeTab(text: "1D", isSelected: true),
                            TimeTab(text: "1W", isSelected: false),
                            TimeTab(text: "1Y", isSelected: false),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 3. Stats Grid (2x2)
                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align to top
                    children: [
                      StatCard(
                        title: "Market Cap",
                        value: CurrencyUtils.formatLargeNumber(coin.marketCap),
                      ),
                      const SizedBox(width: 16),
                      StatCard(title: "High 24h", value: "\$${coin.high24h}"),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StatCard(title: "Low 24h", value: "\$${coin.low24h}"),
                      const SizedBox(width: 16),
                      StatCard(
                        title: "Volume",
                        value: CurrencyUtils.formatLargeNumber(coin.volume),
                      ),
                    ],
                  ),
                  const SizedBox(height: 88),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
