import 'package:intl/intl.dart';
import 'package:pageview/Classes/Notifi.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

class NotifiHelper {
  static final dbHelper = DatabaseHelper.instance;


  static Future<void> add(Notifi notifi) async {
    int IdNotifi = await dbHelper.query("SELECT MAX(ID_Powiadomienia) FROM Powiadomienia");
    IdNotifi = IdNotifi == null ? 0 : IdNotifi;
    dbHelper.insert('Powiadomienia', {
      'ID_Powiadomienia': IdNotifi + 1,
      'ID_Task': notifi.idTask,
      'ID_Event': notifi.idEvent,
      'Czas': notifi.duration.toString(),

    });
  }

  static Future<void> update(Notifi notifi) async {
    dbHelper.update('Wydarzenie', 'ID_Wydarzenie', notifi.id, {
      'ID_Task': notifi.idTask,
      'ID_Event': notifi.idEvent,
      'Czas': notifi.duration.toString(),
    });
  }

  static Future<void> updateTask(Notifi notifi) async {
    Database db = await dbHelper.database;
    db.rawUpdate('UPDATE Powiadomienia SET  Czas = ?  WHERE  ID_Task = ? AND ID_Powiadomienia = ?',
        [
          notifi.duration.toString(),
          notifi.idTask,
          notifi.id
        ]);
  }

  static Future<void> updateEvent(Notifi notifi) async {
    Database db = await dbHelper.database;
    db.rawUpdate('UPDATE Powiadomienia SET Czas = ? WHERE  ID_Event = ? AND ID_Powiadomienia = ?',
        [
          notifi.duration.toString(),
          notifi.idEvent,
          notifi.id
        ]);
  }

  static Future<void> delete(int id) async {
    dbHelper.delete('Powiadomienia', 'ID_Powiadomienia', id);
  }

  static Future<void> deleteTask(Notifi notifi) async {
    Database db = await dbHelper.database;
    db.rawDelete('DELETE FROM Powiadomienia WHERE ID_Task = ? AND ID_Powiadomienia = ?',
        [
          notifi.idTask,
          notifi.id
        ]);
  }

  static Future<void> deleteEvent(Notifi notifi) async {
    Database db = await dbHelper.database;
    db.rawDelete('DELETE FROM Powiadomienia WHERE ID_Event = ? AND ID_Powiadomienia = ?',
        [
          notifi.idEvent,
          notifi.id
        ]);
  }

  static Future<List<Notifi>> lists() async {
    final List<Map<String, dynamic>> maps =
    await dbHelper.queryAllRows('Powiadomienia');
    return List.generate(maps.length, (i) {
      return Notifi(
        id: maps[i]['ID_Powiadomienia'],
        idTask: maps[i]['ID_Task'],
        idEvent: maps[i]['ID_Event'],
        duration: Duration(),
      );
    });
  }

  static Future<List<Notifi>> listsTaskID(int id) async {
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM Powiadomienia WHERE ID_Task=$id');
    return List.generate(maps.length, (i) {
      return Notifi(
        id: maps[i]['ID_Powiadomienia'],
        idTask: maps[i]['ID_Task'],
        idEvent: maps[i]['ID_Event'],
        duration: Duration(),
      );
    });
  }

  static Future<List<Notifi>> listsEventID(int id) async {
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM Powiadomienia WHERE ID_Event=$id');
    return List.generate(maps.length, (i) {
      return Notifi(
        id: maps[i]['ID_Powiadomienia'],
        idTask: maps[i]['ID_Task'],
        idEvent: maps[i]['ID_Event'],
        duration: Duration(),
      );
    });
  }


  static Future<int> getMaxID() async {
    return await dbHelper.query("SELECT MAX(ID_Powiadomienia) FROM Powiadomienia");
  }

}
