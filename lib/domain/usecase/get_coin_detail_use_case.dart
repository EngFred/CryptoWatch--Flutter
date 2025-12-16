import 'package:injectable/injectable.dart';
import '../model/crypto_coin.dart';
import '../repository/crypto_repository.dart';

@injectable
class GetCoinDetailUseCase {
  final CryptoRepository _repository;

  GetCoinDetailUseCase(this._repository);

  Stream<CryptoCoin?> call(String id) {
    return _repository.getCoin(id);
  }
}
