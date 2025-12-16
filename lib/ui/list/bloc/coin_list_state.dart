part of 'coin_list_bloc.dart';

abstract class CoinListState extends Equatable {
  const CoinListState();
  @override
  List<Object?> get props => [];
}

class CoinListInitial extends CoinListState {}

class CoinListPageLoaded extends CoinListState {
  final List<CryptoCoin> items;
  final int? nextKey;
  final bool isSearch;

  const CoinListPageLoaded({
    required this.items,
    this.nextKey,
    this.isSearch = false,
  });

  @override
  List<Object?> get props => [items, nextKey, isSearch];
}

class CoinListError extends CoinListState {
  final dynamic error;
  const CoinListError(this.error);

  @override
  List<Object?> get props => [error];
}
