part of 'coin_detail_bloc.dart';

abstract class CoinDetailEvent extends Equatable {
  const CoinDetailEvent();
  @override
  List<Object?> get props => [];
}

class CoinDetailLoadRequested extends CoinDetailEvent {
  final String id;
  const CoinDetailLoadRequested(this.id);
  @override
  List<Object?> get props => [id];
}
