import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "/Baza_danych";
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE Task (
    ID_Task     INTEGER    PRIMARY KEY
                           DEFAULT NULL,
    Nazwa       CHAR (50)  DEFAULT NULL,
    Do_Kiedy    DATE       DEFAULT NULL,
    Lokalizacja INTEGER    DEFAULT NULL,
    Opis        CHAR (160) DEFAULT NULL,
    Grupa       INTEGER    DEFAULT NULL
)
          ''');

    await db.execute('''
          CREATE TABLE Wydarzenie (
    ID_Wydarzenie INTEGER    PRIMARY KEY
                             DEFAULT NULL,
    Nazwa         CHAR (50)  DEFAULT NULL,
    Godzina_od    TIME       DEFAULT NULL,
    Godzina_do    TIME       DEFAULT NULL,
    Cykl          INTEGER    DEFAULT NULL,
    Kolor         INTEGER    DEFAULT NULL,
    Opis          CHAR (160) DEFAULT NULL,
    Powiadomienie BOOLEAN    DEFAULT NULL
)
          ''');

    await db.execute('''
          CREATE TABLE Grupa (
    ID_Grupy     INTEGER   DEFAULT NULL
                           PRIMARY KEY,
    Nazwa_grupy  CHAR (50) DEFAULT NULL,
    Termin_grupa DATE      DEFAULT NULL,
    Kolor_grupa  INTEGER   DEFAULT NULL
)

          ''');
  }

  Future<int> insert(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> queryRowCount(String table) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }


  Future<int> update(
      String table, String columnId, int id, Map<String, dynamic> row) async {
    Database db = await instance.database;

    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(String table, String columnId, int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
