import 'package:intl/intl.dart';
import 'package:pageview/Classes/Notification.dart';
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
      'Zrobione': newTask.done ? 1 : 0,
      'Do_Kiedy': DateFormat("yyyy-MM-dd hh:mm").format(newTask.endTime),
      'Opis': newTask.description,
      'Lokalizacja': newTask.idLocalizaton,
      'Grupa': newTask.idGroup,
    });


  }

  static Future<void> update( updatedTask ) async {
    dbHelper.update('Task', 'ID_Task', updatedTask.id, {
      'Nazwa': updatedTask.name,
      'Zrobione': updatedTask.done ? 1 : 0,
      'Do_Kiedy': DateFormat("yyyy-MM-dd hh:mm").format(updatedTask.endTime),
      'Opis': updatedTask.description,
      'Lokalizacja': updatedTask.idLocalizaton,
      'Grupa': updatedTask.idGroup,
    });
  }


  static Future<void> delete(int pickedIdTask,) async {
    dbHelper.delete('Task', 'ID_Task', pickedIdTask);
    dbHelper.delete('Powiadomienia_Taskow', 'ID_Task', pickedIdTask);
  }



  List<MyNotification> listofNotifi(int idTask)  {
    dbHelper.queryIdNotifi(idTask).then((maps) {
      return List.generate(maps.length, (i) {
        return MyNotification(
          id: maps[i]['ID_Powiadomienia'],
          when: new DateFormat("dd hh:mm").parse(maps[i]['Czas']),
        );
      });
    });
  }

  static Future<List<Task>> lists() async {
    final List<Map<String, dynamic>> maps = await dbHelper.queryAllRows('Task');

    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['ID_Task'],
        done: maps[i]['Zrobione']  == 1 ? true : false,
        name: maps[i]['Nazwa'],
        endTime: new DateFormat("yyyy-MM-dd hh:mm").parse(maps[i]['Do_Kiedy']),
        description: maps[i]['Opis'],
        idLocalizaton: maps[i]['Lokalizacja'],
        idGroup: maps[i]['Grupa'],
      );
    });
  }

  static Future<List<Task>> listsID(int id) async {
    final List<Map<String, dynamic>> maps = await dbHelper.queryIdRowsTask(id);
    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['ID_Task'],
        done: maps[i]['Zrobione']  == 1 ? true : false,
        name: maps[i]['Nazwa'],
        endTime: new DateFormat("yyyy-MM-dd hh:mm").parse(maps[i]['Do_Kiedy']),
        description: maps[i]['Opis'],
        idLocalizaton: maps[i]['Lokalizacja'],
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
