import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "/Baza_danych";
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static DatabaseHelper instance ;

  factory DatabaseHelper(){
    if(instance == null){
      instance = DatabaseHelper._privateConstructor();
    }
    return instance;
  }

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path +  _databaseName;
    print("path: " + path);
    deleteDatabase(path);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {

    await db.execute('''
           CREATE TABLE Grupa (
     ID_Grupa     INTEGER   PRIMARY KEY,
     Nazwa_grupa  TEXT      NOT NULL,
     Ile_wykonane INTEGER   DEFAULT NULL
 )

           ''');
    await db.execute('''
           CREATE TABLE Powiadomienia (
     ID_Powiadomienia     INTEGER   PRIMARY KEY,
     Czas                 TEXT    DEFAULT NULL
 )
           ''');

    await db.execute('''
           CREATE TABLE Lokalizacja (
     ID_Lokalizacji INTEGER   PRIMARY KEY,
     N              DOUBLE    NOT NULL,
     E              DOUBLE    NOT NULL,
     Nazwa          TEXT      DEFAULT NULL,
     Miasto         TEXT      DEFAULT NULL,
     Ulica          TEXT      DEFAULT NULL
 )
           ''');
    await db.execute('''
           CREATE TABLE Task (
     ID_Task        INTEGER     PRIMARY KEY,
     Nazwa          TEXT        NOT NULL,
     Zrobione       BOOLEAN     NOT NULL,
     Do_Kiedy       TEXT        DEFAULT NULL,
     Opis           TEXT        DEFAULT NULL,
     Lokalizacja    INTEGER     DEFAULT NULL,
     Powiadomienie  INTEGER     DEFAULT NULL,
     Grupa          INTEGER     DEFAULT NULL,
     FOREIGN KEY(Grupa) REFERENCES Grupa(ID_Grupa),
     FOREIGN KEY(Lokalizacja) REFERENCES Lokalizacja(ID_Lokalizacji)
 )
           ''');
//    --FOREIGN KEY(Grupa) REFERENCES Grupa(ID_Grupa),
//    --FOREIGN KEY(Lokalizacja) REFERENCES Lokalizacja(ID_Lokalizacji)

    await db.execute('''
           CREATE TABLE Wydarzenie (
     ID_Wydarzenie INTEGER    PRIMARY KEY,
     Nazwa         TEXT       NOT NULL,
     Termin_od     TEXT       DEFAULT NULL,
     Termin_do     TEXT       DEFAULT NULL,
     Opis          TEXT       DEFAULT NULL,
     Cykl          VARCHAR(2) DEFAULT NULL,
     Powiadomienie INTEGER    DEFAULT NULL,
     Kolor         TEXT       DEFAULT NULL,
     FOREIGN KEY(Powiadomienie) REFERENCES Powiadomienia(ID_Powiadomienia)
 )
           '''); //D, D2, ... , D7,W,M,Y
//    FOREIGN KEY(Powiadomienie) REFERENCES Powiadomienia(ID_Powiadomienia),
  }

  Future<int> insert(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

   Future<List<Map<String, dynamic>>> queryIdRowsTask(int id) async {
     Database db = await instance.database;
     return await db.rawQuery('SELECT * FROM Task WHERE ID_Task=$id');
   }

  Future<List<Map<String, dynamic>>> queryEventWeekend() async {
    Database db = await instance.database;
    return await db.rawQuery("SELECT * FROM Wydarzenie WHERE date(Termin_od) >= date('now') AND date(Termin_od) <= date('now','+7 day')");
  }

  Future<List<Map<String, dynamic>>> queryEventDay(int day) async {
    Database db = await instance.database;
    return await db.rawQuery("SELECT * FROM Wydarzenie WHERE date(Termin_od) = date('now','+$day day')");
  }

  Future<int> query(String q) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery(q));
  }


  Future<int> update(String table, String columnId, int id, Map<String, dynamic> row) async {
    Database db = await instance.database;

    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(String table, String columnId, int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
