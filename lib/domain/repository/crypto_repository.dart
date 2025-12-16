import '../model/crypto_coin.dart';

abstract class CryptoRepository {
  // In Flutter, we typically return a Stream of List<CryptoCoin> for the UI
  // to listen to database updates, similar to Flow.
  // The 'page' argument handles the pagination request.
  Future<List<CryptoCoin>> getCoins({int page = 1, String query = ''});

  Stream<CryptoCoin?> getCoin(String id);

  Future<void> triggerSync();
}
