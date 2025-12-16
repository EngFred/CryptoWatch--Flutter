import 'package:flutter_cryptowatch/data/local/crypto_entity.dart';
import 'package:injectable/injectable.dart';
import '../../core/logger.dart';
import '../../domain/model/crypto_coin.dart';
import '../../domain/repository/crypto_repository.dart';
import '../local/crypto_database.dart';
import '../remote/coin_gecko_api.dart';
import '../mapper/mappers.dart';

@LazySingleton(as: CryptoRepository)
class CryptoRepositoryImpl implements CryptoRepository {
  final CoinGeckoApi _api;
  final CryptoDatabase _db;
  final AppLogger _logger;

  CryptoRepositoryImpl(this._api, this._db, this._logger);

  @override
  Future<List<CryptoCoin>> getCoins({int page = 1, String query = ''}) async {
    // First, try to fetch from Local DB
    List<CryptoEntity> localData;
    if (query.isNotEmpty) {
      localData = await _db.dao.searchCoins(query);
    } else {
      final int pageSize = 20;
      final int offset = (page - 1) * pageSize;
      localData = await _db.dao.getCoinsPage(pageSize, offset);
    }
    if (localData.isEmpty) {
      try {
        await _fetchAndSaveFromApi(page, query);
        if (query.isNotEmpty) {
          localData = await _db.dao.searchCoins(query);
        } else {
          localData = await _db.dao.getCoinsPage(20, (page - 1) * 20);
        }
      } catch (e) {
        _logger.error("Network Error: $e", e);
        if (localData.isEmpty) {
          rethrow;
        }
        // If local data exists, continue with it (offline support)
      }
    }
    return localData.map((e) => e.toDomain()).toList();
  }

  Future<void> _fetchAndSaveFromApi(int page, String query) async {
    if (query.isEmpty) {
      final remoteCoins = await _api.getCoins(page: page, perPage: 20);
      final entities = remoteCoins.map((e) => e.toEntity(page)).toList();
      await _db.dao.insertAll(entities);
    } else {
      final searchResult = await _api.searchGlobal(query);
      final topIds = searchResult.coins.take(10).map((e) => e.id).join(",");
      if (topIds.isNotEmpty) {
        final details = await _api.getCoins(ids: topIds);
        final entities = details.map((e) => e.toEntity(1)).toList();
        await _db.dao.insertAll(entities);
      }
    }
  }

  @override
  Stream<CryptoCoin?> getCoin(String id) {
    return _db.dao.getCoin(id).map((entity) => entity?.toDomain());
  }

  @override
  Future<void> triggerSync() async {
    try {
      final coins = await _api.getCoins(page: 1, perPage: 50);
      await _db.dao.insertAll(coins.map((e) => e.toEntity(1)).toList());
    } catch (e) {
      _logger.error("Sync failed: $e", e);
      rethrow;
    }
  }
}
