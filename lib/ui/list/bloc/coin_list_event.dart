part of 'coin_list_bloc.dart';

abstract class CoinListEvent extends Equatable {
  const CoinListEvent();
  @override
  List<Object?> get props => [];
}

class CoinListLoadPage extends CoinListEvent {
  final int pageKey;
  const CoinListLoadPage(this.pageKey);

  @override
  List<Object?> get props => [pageKey];
}

class CoinListSearchChanged extends CoinListEvent {
  final String query;
  const CoinListSearchChanged(this.query);

  @override
  List<Object?> get props => [query];
}
