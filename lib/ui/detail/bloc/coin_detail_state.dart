part of 'coin_detail_bloc.dart';

abstract class CoinDetailState extends Equatable {
  const CoinDetailState();
  @override
  List<Object?> get props => [];
}

class CoinDetailLoading extends CoinDetailState {}

class CoinDetailLoaded extends CoinDetailState {
  final CryptoCoin coin;
  const CoinDetailLoaded(this.coin);
  @override
  List<Object?> get props => [coin];
}

class CoinDetailError extends CoinDetailState {
  final String message;
  const CoinDetailError(this.message);
  @override
  List<Object?> get props => [message];
}
