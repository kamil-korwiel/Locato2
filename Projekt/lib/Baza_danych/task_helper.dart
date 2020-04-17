import 'package:intl/intl.dart';
import 'package:pageview/Classes/Task.dart';

import 'database_helper.dart';

class TaskHelper {
  static final dbHelper = DatabaseHelper.instance;


  static Future<void> add( Task newTask ) async {
    int IdTask = await dbHelper.query("SELECT max(ID_Task) FROM Task");
    IdTask = IdTask == null ? 0 : IdTask;
    dbHelper.insert('Task', {
      'ID_Task': IdTask + 1,
      'Nazwa': newTask.name,
      'Zrobione': newTask.done,
      'Do_Kiedy': DateFormat("yyyy-MM-dd hh:mm").format(newTask.endTime),
      'Opis': newTask.description,
      'Lokalizacja': newTask.idLocalizaton,
      'Powiadomienie': newTask.idNotification,
      'Grupa': newTask.idGroup,
    });
  }

  static Future<void> update( updatedTask ) async {
    dbHelper.update('Task', 'ID_Task', updatedTask.id,{
      'Nazwa': updatedTask.name,
      'Zrobione': updatedTask.done,
      'Do_Kiedy': updatedTask.endTime,
      'Opis': updatedTask.description,
      'Powiadomienie': updatedTask.idNotification,
      'Lokalizacja': updatedTask.idLocalizaton,
      'Grupa': updatedTask.idGroup,
    });
  }

  static Future<void> delete(int pickedIdTask,) async {
    dbHelper.delete('Task', 'ID_Task', pickedIdTask);
  }



  static Future<List<Task>> lists() async {
    final List<Map<String, dynamic>> maps = await dbHelper.queryAllRows('Task');
    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['ID_Task'],
        done: maps[i]['Zrobione'],
        name: maps[i]['Nazwa'],
        endTime: new DateFormat("yyyy-MM-dd hh:mm").parse(maps[i]['Do_Kiedy']),
        description: maps[i]['Opis'],
        idLocalizaton: maps[i]['Lokalizacja'],
        idNotification: maps[i]['Powiadomienie'],
        idGroup: maps[i]['Grupa'],
      );
    });
  }

  static Future<List<Task>> listsID(int id) async {
    final List<Map<String, dynamic>> maps = await dbHelper.queryIdRowsTask(id);
    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['ID_Task'],
        done: maps[i]['Zrobione'],
        name: maps[i]['Nazwa'],
        endTime: new DateFormat("yyyy-MM-dd hh:mm").parse(maps[i]['Do_Kiedy']),
        description: maps[i]['Opis'],
        idLocalizaton: maps[i]['Lokalizacja'],
        idNotification: maps[i]['Powiadomienie'],
        idGroup: maps[i]['Grupa'],
      );
    });
  }

//  static Future<List<Task>> listsWeekend() async {
//    final List<Map<String, dynamic>> maps = await dbHelper.queryTaskWeekend();
//    return List.generate(maps.length, (i) {
//      return Task(
//        id: maps[i]['ID_Task'],
//        done: maps[i]['Zrobione'],
//        name: maps[i]['Nazwa'],
//        endTime: maps[i]['Do_Kiedy'],
//        description: maps[i]['Opis'],
//        idLocalizaton: maps[i]['Lokalizacja'],
//        idNotification: maps[i]['Powiadomienie'],
//        idGroup: maps[i]['Grupa'],
//      );
//    });
//  }

}
