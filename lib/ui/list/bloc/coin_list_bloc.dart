import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../../domain/model/crypto_coin.dart';
import '../../../domain/usecase/get_coins_use_case.dart';

part 'coin_list_event.dart';
part 'coin_list_state.dart';

EventTransformer<E> debounce<E>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

@injectable
class CoinListBloc extends Bloc<CoinListEvent, CoinListState> {
  final GetCoinsUseCase _getCoinsUseCase;

  String _currentQuery = '';

  CoinListBloc(this._getCoinsUseCase) : super(CoinListInitial()) {
    on<CoinListLoadPage>((event, emit) async {
      try {
        final newItems = await _getCoinsUseCase(
          page: event.pageKey,
          query: _currentQuery,
        );

        final isLastPage = newItems.isEmpty;
        final nextKey = isLastPage ? null : event.pageKey + 1;

        emit(
          CoinListPageLoaded(
            items: newItems,
            nextKey: nextKey,
            isSearch: _currentQuery.isNotEmpty,
          ),
        );
      } catch (e) {
        emit(CoinListError(e));
      }
    });

    on<CoinListSearchChanged>((event, emit) {
      _currentQuery = event.query;
      // We don't emit a state here, we just update query.
      // The UI will refresh the PagingController, which triggers CoinListLoadPage(1)
    }, transformer: debounce(const Duration(milliseconds: 300)));
  }
}
