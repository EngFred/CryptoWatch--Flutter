// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_cryptowatch/core/logger.dart' as _i177;
import 'package:flutter_cryptowatch/data/local/crypto_database.dart' as _i260;
import 'package:flutter_cryptowatch/data/remote/coin_gecko_api.dart' as _i1023;
import 'package:flutter_cryptowatch/data/repository/crypto_repository_impl.dart'
    as _i299;
import 'package:flutter_cryptowatch/di/module.dart' as _i1007;
import 'package:flutter_cryptowatch/domain/repository/crypto_repository.dart'
    as _i624;
import 'package:flutter_cryptowatch/domain/usecase/get_coin_detail_use_case.dart'
    as _i910;
import 'package:flutter_cryptowatch/domain/usecase/get_coins_use_case.dart'
    as _i318;
import 'package:flutter_cryptowatch/ui/detail/bloc/coin_detail_bloc.dart'
    as _i476;
import 'package:flutter_cryptowatch/ui/list/bloc/coin_list_bloc.dart' as _i151;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singleton<_i361.Dio>(() => registerModule.dio);
    await gh.singletonAsync<_i260.CryptoDatabase>(
      () => registerModule.db,
      preResolve: true,
    );
    gh.singleton<_i177.AppLogger>(() => _i177.AppLogger());
    gh.singleton<_i1023.CoinGeckoApi>(
        () => registerModule.getApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i624.CryptoRepository>(() => _i299.CryptoRepositoryImpl(
          gh<_i1023.CoinGeckoApi>(),
          gh<_i260.CryptoDatabase>(),
          gh<_i177.AppLogger>(),
        ));
    gh.factory<_i910.GetCoinDetailUseCase>(
        () => _i910.GetCoinDetailUseCase(gh<_i624.CryptoRepository>()));
    gh.factory<_i318.GetCoinsUseCase>(
        () => _i318.GetCoinsUseCase(gh<_i624.CryptoRepository>()));
    gh.factory<_i476.CoinDetailBloc>(
        () => _i476.CoinDetailBloc(gh<_i910.GetCoinDetailUseCase>()));
    gh.factory<_i151.CoinListBloc>(
        () => _i151.CoinListBloc(gh<_i318.GetCoinsUseCase>()));
    return this;
  }
}

class _$RegisterModule extends _i1007.RegisterModule {}
