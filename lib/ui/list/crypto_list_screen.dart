import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:go_router/go_router.dart';
import '../../di/injection.dart';
import '../../domain/model/crypto_coin.dart';
import 'bloc/coin_list_bloc.dart';
import 'components/crypto_list_item.dart';
import 'components/offline_banner.dart';

class CryptoListScreen extends StatelessWidget {
  const CryptoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CoinListBloc>(),
      child: const _CryptoListScreenBody(),
    );
  }
}

class _CryptoListScreenBody extends StatefulWidget {
  const _CryptoListScreenBody();

  @override
  State<_CryptoListScreenBody> createState() => _CryptoListScreenBodyState();
}

class _CryptoListScreenBodyState extends State<_CryptoListScreenBody> {
  final TextEditingController _searchController = TextEditingController();
  late final PagingController<int, CryptoCoin> _pagingController;

  @override
  void initState() {
    super.initState();
    _pagingController = PagingController<int, CryptoCoin>(
      getNextPageKey: (state) {
        final isSearch = _searchController.text.isNotEmpty;
        final pages = state.pages ?? [];
        if (pages.isEmpty) {
          return 1;
        }
        if (isSearch) {
          return null;
        }
        final lastPageIsEmpty = pages.last.isEmpty;
        if (lastPageIsEmpty) {
          return null;
        }
        final keys = state.keys ?? [];
        if (keys.isEmpty) {
          return null;
        }
        return keys.last + 1;
      },
      fetchPage: (pageKey) async {
        final bloc = context.read<CoinListBloc>();
        final completer = Completer<List<CryptoCoin>>();
        StreamSubscription<CoinListState>? subscription;
        subscription = bloc.stream.listen((state) {
          if (state is CoinListPageLoaded) {
            completer.complete(state.items);
            subscription?.cancel();
          } else if (state is CoinListError) {
            completer.completeError(state.error);
            subscription?.cancel();
          }
        });
        bloc.add(CoinListLoadPage(pageKey));
        final items = await completer.future;
        return items;
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _searchController,
                onChanged: (val) {
                  // 3. Search Logic
                  context.read<CoinListBloc>().add(CoinListSearchChanged(val));
                  _pagingController.refresh();
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search coins...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: const Color(0xFF1E1E1E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // List
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => Future.sync(() => _pagingController.refresh()),
                backgroundColor: const Color(0xFF1E1E1E),
                color: Colors.white,
                child: PagingListener<int, CryptoCoin>(
                  controller: _pagingController,
                  builder: (context, state, fetchNextPage) {
                    return PagedListView<int, CryptoCoin>(
                      state: state,
                      fetchNextPage: fetchNextPage,
                      builderDelegate: PagedChildBuilderDelegate<CryptoCoin>(
                        itemBuilder: (context, item, index) => Column(
                          children: [
                            CryptoListItem(
                              coin: item,
                              onTap: (id) => context.push('/detail/$id'),
                            ),
                            const Divider(height: 1, color: Colors.white24),
                          ],
                        ),
                        firstPageErrorIndicatorBuilder: (_) => Center(
                          child: const OfflineBanner(
                            message:
                                "Failed to load data. Check internet connection.",
                          ),
                        ),
                        noItemsFoundIndicatorBuilder: (_) => const Center(
                          child: Text(
                            "No coins found",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        newPageErrorIndicatorBuilder: (context) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const Text(
                                "Load failed",
                                style: TextStyle(color: Colors.red),
                              ),
                              TextButton(
                                onPressed: fetchNextPage,
                                child: const Text("Retry"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
