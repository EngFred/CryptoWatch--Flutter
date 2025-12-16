import 'package:injectable/injectable.dart';
import '../model/crypto_coin.dart';
import '../repository/crypto_repository.dart';

@injectable
class GetCoinsUseCase {
  final CryptoRepository _repository;

  GetCoinsUseCase(this._repository);

  // We invoke this to get a page of data
  Future<List<CryptoCoin>> call({int page = 1, String query = ''}) {
    return _repository.getCoins(page: page, query: query);
  }
}
