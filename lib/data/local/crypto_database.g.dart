// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $CryptoDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $CryptoDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $CryptoDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<CryptoDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorCryptoDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $CryptoDatabaseBuilderContract databaseBuilder(String name) =>
      _$CryptoDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $CryptoDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$CryptoDatabaseBuilder(null);
}

class _$CryptoDatabaseBuilder implements $CryptoDatabaseBuilderContract {
  _$CryptoDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $CryptoDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $CryptoDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<CryptoDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$CryptoDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$CryptoDatabase extends CryptoDatabase {
  _$CryptoDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CryptoDao? _daoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `coins` (`id` TEXT NOT NULL, `symbol` TEXT NOT NULL, `name` TEXT NOT NULL, `image` TEXT NOT NULL, `currentPrice` REAL NOT NULL, `priceChangePercentage24h` REAL NOT NULL, `high24h` REAL NOT NULL, `low24h` REAL NOT NULL, `marketCap` REAL NOT NULL, `volume` REAL NOT NULL, `sparkline` TEXT NOT NULL, `page` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CryptoDao get dao {
    return _daoInstance ??= _$CryptoDao(database, changeListener);
  }
}

class _$CryptoDao extends CryptoDao {
  _$CryptoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _cryptoEntityInsertionAdapter = InsertionAdapter(
            database,
            'coins',
            (CryptoEntity item) => <String, Object?>{
                  'id': item.id,
                  'symbol': item.symbol,
                  'name': item.name,
                  'image': item.image,
                  'currentPrice': item.currentPrice,
                  'priceChangePercentage24h': item.priceChangePercentage24h,
                  'high24h': item.high24h,
                  'low24h': item.low24h,
                  'marketCap': item.marketCap,
                  'volume': item.volume,
                  'sparkline': item.sparkline,
                  'page': item.page
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CryptoEntity> _cryptoEntityInsertionAdapter;

  @override
  Future<List<CryptoEntity>> getCoinsPage(
    int limit,
    int offset,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM coins ORDER BY page ASC, marketCap DESC LIMIT ?1 OFFSET ?2',
        mapper: (Map<String, Object?> row) => CryptoEntity(id: row['id'] as String, symbol: row['symbol'] as String, name: row['name'] as String, image: row['image'] as String, currentPrice: row['currentPrice'] as double, priceChangePercentage24h: row['priceChangePercentage24h'] as double, high24h: row['high24h'] as double, low24h: row['low24h'] as double, marketCap: row['marketCap'] as double, volume: row['volume'] as double, sparkline: row['sparkline'] as String, page: row['page'] as int),
        arguments: [limit, offset]);
  }

  @override
  Future<List<CryptoEntity>> searchCoins(String query) async {
    return _queryAdapter.queryList(
        'SELECT * FROM coins WHERE LOWER(name) LIKE LOWER(\'%\' || ?1 || \'%\') OR LOWER(symbol) LIKE LOWER(\'%\' || ?1 || \'%\') ORDER BY marketCap DESC',
        mapper: (Map<String, Object?> row) => CryptoEntity(id: row['id'] as String, symbol: row['symbol'] as String, name: row['name'] as String, image: row['image'] as String, currentPrice: row['currentPrice'] as double, priceChangePercentage24h: row['priceChangePercentage24h'] as double, high24h: row['high24h'] as double, low24h: row['low24h'] as double, marketCap: row['marketCap'] as double, volume: row['volume'] as double, sparkline: row['sparkline'] as String, page: row['page'] as int),
        arguments: [query]);
  }

  @override
  Stream<CryptoEntity?> getCoin(String id) {
    return _queryAdapter.queryStream('SELECT * FROM coins WHERE id = ?1',
        mapper: (Map<String, Object?> row) => CryptoEntity(
            id: row['id'] as String,
            symbol: row['symbol'] as String,
            name: row['name'] as String,
            image: row['image'] as String,
            currentPrice: row['currentPrice'] as double,
            priceChangePercentage24h: row['priceChangePercentage24h'] as double,
            high24h: row['high24h'] as double,
            low24h: row['low24h'] as double,
            marketCap: row['marketCap'] as double,
            volume: row['volume'] as double,
            sparkline: row['sparkline'] as String,
            page: row['page'] as int),
        arguments: [id],
        queryableName: 'coins',
        isView: false);
  }

  @override
  Future<void> clearCoins() async {
    await _queryAdapter.queryNoReturn('DELETE FROM coins');
  }

  @override
  Future<void> insertAll(List<CryptoEntity> coins) async {
    await _cryptoEntityInsertionAdapter.insertList(
        coins, OnConflictStrategy.replace);
  }
}
