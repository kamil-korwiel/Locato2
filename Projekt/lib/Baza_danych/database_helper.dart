import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  ///Stores database name.
  static final _databaseName = "/Baza_danych";
  ///Stores database version.
  static final _databaseVersion = 1;
  ///
  static int index;
  ///Constructor to create instance of DatabaseHelper.
  DatabaseHelper._privateConstructor();
  ///Stores instance of database.
  static DatabaseHelper instance;

  factory DatabaseHelper() {
    if (instance == null) {
      index = 0;
      instance = DatabaseHelper._privateConstructor();
    }
    return instance;
  }

  static Database _database;
  ///Create database object and provide it with a getter where we will instantiate the database if it's not.
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }
  ///Opens database and create it if it doesn't exist.
  _initDatabase() async {
    ///Stores documents directory name where application may place data.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    ///Stores path to database.
    String path = documentsDirectory.path + _databaseName;
    print("${index} path: " + path);
    ++index;
    //deleteDatabase(path);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }
  ///Used to create tables.
  Future _onCreate(
    ///Stores database.
    Database db, 
    ///Stores database version.
    int version) async {
    await db.execute('''
           CREATE TABLE Grupa (
     ID_Grupa     INTEGER   PRIMARY KEY,
     Nazwa_grupa  TEXT      NOT NULL,
     Ile_wykonane INTEGER   DEFAULT NULL
 )

           ''');
    await db.execute('''
            INSERT INTO Grupa (ID_Grupa,Nazwa_grupa,Ile_wykonane)
    VALUES (0,'Brak Grupy',0)
    ''');

    await db.execute('''
           CREATE TABLE Powiadomienia(
     ID_Powiadomienia     INTEGER   PRIMARY KEY,
     ID_Task              INTEGER NOT NULL,
     ID_Event             INTEGER NOT NULL,
     Czas                 TEXT    DEFAULT NULL
 )
           ''');

    await db.execute('''
           CREATE TABLE Lokalizacja (
     ID_Lokalizacji INTEGER   PRIMARY KEY,
     Latitude       DOUBLE    DEFAULT NULL,
     Longitude      DOUBLE    DEFAULT NULL,
     Nazwa          TEXT      DEFAULT NULL,
     Miasto         TEXT      DEFAULT NULL,
     Ulica          TEXT      DEFAULT NULL,
     JestesBlisko   BOOLEAN   DEFAULT NULL,
     WyslanoPowiadomienie BOOLEAN DEFAULT NULL
 )
           ''');

    await db.execute('''
            INSERT INTO Lokalizacja (ID_Lokalizacji,Nazwa,Miasto,Ulica,JestesBlisko,WyslanoPowiadomienie)
    VALUES (0,NULL,NULL,NULL,0,0)
    ''');
    await db.execute('''
           CREATE TABLE Task (
     ID_Task        INTEGER     PRIMARY KEY,
     Nazwa          TEXT        NOT NULL,
     Zrobione       BOOLEAN     NOT NULL,
     Do_Kiedy       TEXT        DEFAULT NULL,
     Opis           TEXT        DEFAULT NULL,
     Lokalizacja    INTEGER     DEFAULT NULL,
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
     Kolor         TEXT       DEFAULT NULL
 )
           '''); //D, D2, ... , D7,W,M,Y
//    FOREIGN KEY(Powiadomienie) REFERENCES Powiadomienia(ID_Powiadomienia),
  }
  ///Used to insert row into table.
  Future<int> insert(
    ///Stores table name.
    String table, 
    ///Stores contents of row to insert.
    Map<String, dynamic> row) async {
    ///Stores instance of database.
    Database db = await instance.database;
    return await db.insert(table, row);
  }
  ///Used to query all rows from table.
  Future<List<Map<String, dynamic>>> queryAllRows(
    ///Stores table name.
    String table) async {
    ///Stores instance of database.
    Database db = await instance.database;
    return await db.query(table);
  }

//  Future<List<Map<String, dynamic>>> queryIdNotifi(int id) async {
//    Database db = await instance.database;
//    return await db.rawQuery('SELECT * FROM Powiadomienia_Wydarzen WHERE $id');
//  }
  ///Used to query list of tasks from specific group.
  Future<List<Map<String, dynamic>>> queryIdRowsTask(int id) async {
    ///Stores instance of database.
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM Task WHERE Grupa=$id');
  }
  ///Used to query events from 7 days.
  Future<List<Map<String, dynamic>>> queryEventWeekend() async {
    ///Stores instance of database.
    Database db = await instance.database;
    return await db.rawQuery(
        "SELECT * FROM Wydarzenie WHERE date(Termin_od) >= date('now') AND date(Termin_od) <= date('now','+7 day')");
  }
  ///Used to query events from specific day.
  Future<List<Map<String, dynamic>>> queryEventDay(
    ///Stores day which we want to query events list.
    int day) async {
    ///Stores instance of database.
    Database db = await instance.database;
    return await db.rawQuery(
        "SELECT * FROM Wydarzenie WHERE date(Termin_od) = date('now','+$day day')");
  }
  ///
  Future<List<Map<String, int>>> queryTaskNotifiId(int id) async {
    ///Stores instance of database.
    Database db = await instance.database;
    return await db.rawQuery("SELECT * FROM Powiadomienia WHERE ID_Task= $id");
  }
  ///Used to query all tables from database
  Future<void> showalltables() async {
    ///Stores instance of database.
    Database db = await instance.database;
    List<Map<String, dynamic>> mapGroup =
        await db.rawQuery("SELECT * FROM Grupa");
    List<Map<String, dynamic>> mapNotifi =
        await db.rawQuery("SELECT * FROM Powiadomienia");
    List<Map<String, dynamic>> mapLocal =
        await db.rawQuery("SELECT * FROM Lokalizacja");
    List<Map<String, dynamic>> mapTask =
        await db.rawQuery("SELECT * FROM Task");
    List<Map<String, dynamic>> mapEvent =
        await db.rawQuery("SELECT * FROM Wydarzenie");

    print("\nID_Task\t"
        "Nazwa\t"
        "Zrobione\t"
        "Do_Kiedy\t"
        "Opis\t"
        "Lokalizacja\t"
        "Grupa\t");
    mapTask.forEach((m) {
      print("${m['ID_Task'].toString()}\t\t"
          "${m['Nazwa'].toString()}\t"
          "${m['Zrobione'].toString()}\t"
          "${m['Do_Kiedy'].toString()}\t"
          "${m['Opis'].toString()}\t"
          "${m['Lokalizacja'].toString()}\t"
          "${m['Grupa'].toString()}\t");
    });

    print("\nID_Wydarzenie\t" "Nazwa\t" "Termin_od\t" "Termin_do\t" "Opis\t");
    mapEvent.forEach((m) {
      print("${m['ID_Wydarzenie'].toString()}\t\t\t"
          "${m['Nazwa'].toString()}\t"
          "${m['Termin_od'].toString()}\t"
          "${m['Termin_do'].toString()}\t"
          "${m['Opis'].toString()}\t");
    });

    print("\nID_Grupa\t" "Nazwa_grupa\t");
    mapGroup.forEach((m) {
      print(
          "${m['ID_Grupa'].toString()}\t\t" "${m['Nazwa_grupa'].toString()}\t");
    });

    print("\nID_Lokalizacji\t"
        "Latitude\t"
        "Longitude\t"
        "Nazwa\t"
        "Miasto\t"
        "Ulica\t");
    mapLocal.forEach((m) {
      print("${m['ID_Lokalizacji'].toString()}\t\t\t\t"
          "${m['Latitude'].toString()}\t"
          "${m['Longitude'].toString()}\t"
          "${m['Nazwa'].toString()}\t"
          "${m['Miasto'].toString()}\t"
          "${m['Ulica'].toString()}\t"
          "${m['JestesBlisko'].toString()}\t"
          "${m['WyslanoPowiadomienie'].toString()}");
    });
    print("\nID_Powiadomienia\t" "ID_Task\t" "ID_Event\t" "Czas\t");
    mapNotifi.forEach((m) {
      print("${m['ID_Powiadomienia'].toString()}\t\t\t\t"
          "${m['ID_Task'].toString()}\t\t"
          "${m['ID_Event'].toString()}\t\t"
          "${m['Czas'].toString()}\t");
    });
  }
  ///Return row count in specific table.
  Future<int> query(
    ///Stores table name.
    String q) async {
    ///Stores instance of database.
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery(q));
  }
  ///Used to upated row in database.
  Future<int> update(
      ///Stores table name.
      String table, 
      ///Stores column id name in specific table.
      String columnId, 
      ///Stores row id to update.
      int id, 
      ///Stores contents of row to update.
      Map<String, dynamic> row) async {
    ///Stores instance of database.
    Database db = await instance.database;
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }
  ///Used to delete row from database.
  Future<int> delete(
    ///Stores table name.
    String table, 
    ///Stores column id name in specific table.
    String columnId, 
    ///Stores row id to delete.
    int id) async {
    ///Stores instance of database.
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
