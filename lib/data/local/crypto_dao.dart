import 'package:floor/floor.dart';
import 'crypto_entity.dart';

@dao
abstract class CryptoDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAll(List<CryptoEntity> coins);

  @Query(
    'SELECT * FROM coins ORDER BY page ASC, marketCap DESC LIMIT :limit OFFSET :offset',
  )
  Future<List<CryptoEntity>> getCoinsPage(int limit, int offset);

  @Query(
    "SELECT * FROM coins WHERE name LIKE '%' || :query || '%' OR symbol LIKE '%' || :query || '%' ORDER BY marketCap DESC",
  )
  Future<List<CryptoEntity>> searchCoins(String query);

  @Query('SELECT * FROM coins WHERE id = :id')
  Stream<CryptoEntity?> getCoin(String id);

  @Query('DELETE FROM coins')
  Future<void> clearCoins();
}
