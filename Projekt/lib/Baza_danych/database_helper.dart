// import 'dart:io';

// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';

// class DatabaseHelper {
//   static final _databaseName = "/Baza_danych";
//   static final _databaseVersion = 1;

//   DatabaseHelper._privateConstructor();
//   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

//   static Database _database;
//   Future<Database> get database async {
//     if (_database != null) return _database;
//     _database = await _initDatabase();
//     return _database;
//   }

//   _initDatabase() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, _databaseName);
//     return await openDatabase(path,
//         version: _databaseVersion, onCreate: _onCreate);
//   }

//   Future _onCreate(Database db, int version) async {
//     await db.execute('''
//           CREATE TABLE Task (
//     ID_Task     INTEGER    PRIMARY KEY
//                            DEFAULT NULL,
//     Nazwa       CHAR (50)  DEFAULT NULL,
//     Do_Kiedy    DATE       DEFAULT NULL,
//     ID_Lokalizacja INTEGER    DEFAULT NULL,
//     Grupa       INTEGER    DEFAULT NULL
// )
//           ''');

//     await db.execute('''
//           CREATE TABLE Wydarzenie (
//     ID_Wydarzenie INTEGER    PRIMARY KEY
//                              DEFAULT NULL,
//     Nazwa         CHAR (50)  DEFAULT NULL,
//     Godzina_od    TIME       DEFAULT NULL,
//     Godzina_do    TIME       DEFAULT NULL,
//     Cykl          CHAR(2)    DEFAULT NULL, 
//     Kolor         INTEGER    DEFAULT NULL,
//     Opis          CHAR (160) DEFAULT NULL
// )
//           '''); //D, D2, ... , D7,W,M,Y
//     await db.execute('''
//           CREATE TABLE Grupa (
//     ID_Grupa     INTEGER   DEFAULT NULL
//                            PRIMARY KEY,
//     Nazwa_grupa  CHAR (50) DEFAULT NULL,
//     Ile_wykonane INTEGER DEFAULT NULL
// )

//           ''');
//     await db.execute('''
//           CREATE TABLE Powiadomienia (
//     ID_Powiadomienia     INTEGER   DEFAULT NULL
//                            PRIMARY KEY,
//     Czas  DATE DEFAULT NULL
// )
//           ''');

//     await db.execute('''
//           CREATE TABLE Lokalizacja (
//     ID_Lokalizacji     INTEGER   DEFAULT NULL
//                            PRIMARY KEY,
//     N  DOUBLE DEFAULT NULL,
//     E  DOUBLE DEFAULT NULL,
//     Nazwa CHAR(50) DEFAULT NULL,
//     Miasto CHAR(50) DEFAULT NULL,
//     Ulica CHAR(50) DEFAULT NULL
// )
//           ''');
//   }

//   Future<int> insert(String table, Map<String, dynamic> row) async {
//     Database db = await instance.database;
//     return await db.insert(table, row);
//   }

//   Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
//     Database db = await instance.database;
//     return await db.query(table);
//   }

//   Future<int> queryRowCount(String table) async {
//     Database db = await instance.database;
//     return Sqflite.firstIntValue(
//         await db.rawQuery('SELECT COUNT(*) FROM $table'));
//   }

//   Future<int> update(
//       String table, String columnId, int id, Map<String, dynamic> row) async {
//     Database db = await instance.database;

//     return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
//   }

//   Future<int> delete(String table, String columnId, int id) async {
//     Database db = await instance.database;
//     return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
//   }
// }
