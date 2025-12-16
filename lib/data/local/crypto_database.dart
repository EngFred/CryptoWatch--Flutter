import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'crypto_entity.dart';
import 'crypto_dao.dart';

part 'crypto_database.g.dart';

@Database(version: 1, entities: [CryptoEntity])
abstract class CryptoDatabase extends FloorDatabase {
  CryptoDao get dao;
}
