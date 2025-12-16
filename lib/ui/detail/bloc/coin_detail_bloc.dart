import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/model/crypto_coin.dart';
import '../../../domain/usecase/get_coin_detail_use_case.dart';

part 'coin_detail_event.dart';
part 'coin_detail_state.dart';

@injectable
class CoinDetailBloc extends Bloc<CoinDetailEvent, CoinDetailState> {
  final GetCoinDetailUseCase _useCase;

  CoinDetailBloc(this._useCase) : super(CoinDetailLoading()) {
    on<CoinDetailLoadRequested>((event, emit) async {
      emit(CoinDetailLoading());

      await emit.forEach<CryptoCoin?>(
        _useCase(event.id),
        onData: (coin) {
          if (coin != null) {
            return CoinDetailLoaded(coin);
          } else {
            return const CoinDetailError("Coin not found in Database");
          }
        },
        onError: (error, stackTrace) {
          return CoinDetailError(error.toString());
        },
      );
    });
  }
}
