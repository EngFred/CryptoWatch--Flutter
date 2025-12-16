import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../data/local/crypto_database.dart';
import '../data/remote/coin_gecko_api.dart';

@module
abstract class RegisterModule {
  @singleton
  Dio get dio => Dio();

  @singleton
  CoinGeckoApi getApi(Dio dio) => CoinGeckoApi(dio);

  @preResolve
  @singleton
  Future<CryptoDatabase> get db =>
      $FloorCryptoDatabase.databaseBuilder('crypto_db.db').build();
}
