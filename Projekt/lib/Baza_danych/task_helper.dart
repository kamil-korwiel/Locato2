import 'package:intl/intl.dart';
import 'package:Locato/Background/notification_helper_background.dart';
import 'package:Locato/Baza_danych/group_helper.dart';
import 'package:Locato/Baza_danych/localization_helper.dart';
import 'package:Locato/Classes/Group.dart';
import 'package:Locato/Classes/Localization.dart';
import 'package:Locato/Classes/Task.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';
import 'notification_helper.dart';

class TaskHelper {
  static final dbHelper = DatabaseHelper.instance;


  static Future<void> add( Task newTask ) async {
    int IdTask = await dbHelper.query("SELECT max(ID_Task) FROM Task");
    IdTask = IdTask == null ? 0 : IdTask;

    int IdGroup = newTask.group.id == null ? await GroupHelper.add(newTask.group) : newTask.group.id;
      //print("IDGROUP : $IdGroup");

    int IdLocal =  newTask.localization.id == null ? await LocalizationHelper.add(newTask.localization) : newTask.localization.id;


    dbHelper.insert('Task', {
      'ID_Task': ++IdTask ,
      'Nazwa': newTask.name,
      'Zrobione': newTask.done ? 1 : 0,
      'Do_Kiedy': newTask.endTime!=null?DateFormat("yyyy-MM-dd hh:mm").format(newTask.endTime):null,
      'Opis': newTask.description,
      'Lokalizacja': IdLocal,
      'Grupa': IdGroup,
    });

    newTask.listNotifi.forEach((n) => n.idTask = IdTask);
    NotifiHelper.addListNotifiTask(newTask);
  }



  static Future<void> updateDone( updatedTask ) async {
    dbHelper.update('Task', 'ID_Task', updatedTask.id, {
      'Zrobione': updatedTask.done ? 1 : 0,
    });
  }




  static Future<void> update( updatedTask ) async {

    int IdGroup = updatedTask.group.id == null ? await GroupHelper.add(updatedTask.group) : updatedTask.group.id;

    int IdLocal =  updatedTask.localization.id == null ? await LocalizationHelper.add(updatedTask.localization) : updatedTask.localization.id;

    dbHelper.update('Task', 'ID_Task', updatedTask.id, {
      'Nazwa': updatedTask.name,
      'Zrobione': updatedTask.done ? 1 : 0,
      'Do_Kiedy': DateFormat("yyyy-MM-dd hh:mm").format(updatedTask.endTime),
      'Opis': updatedTask.description,
      'Lokalizacja': IdLocal,
      'Grupa': IdGroup,
    });

    updatedTask.listNotifi.forEach((n) => n.idTask = updatedTask.id);
    NotifiHelper.addListNotifiTask(updatedTask);
    
  }

  static Future<void> delete(int pickedIdTask) async {
    dbHelper.delete('Task', 'ID_Task', pickedIdTask);
    await Notifications_helper_background.deleteTask(pickedIdTask);
  }

  static Future<void> deleteDoneTaskToday() async {
    Database db = await dbHelper.database;
    db.rawDelete("DELETE FROM Task WHERE date(Do_Kiedy) = date('now') AND Zrobione = 1" );
  }

//  List<MyNotification> listofNotifi(int idTask)  {
//    dbHelper.queryIdNotifi(idTask).then((maps) {
//      return List.generate(maps.length, (i) {
//        return MyNotification(
//          id: maps[i]['ID_Powiadomienia'],
//          when: new DateFormat("dd hh:mm").parse(maps[i]['Czas']),
//        );
//      });
//    });
//  }

  static Future<List<Task>> lists() async {
    //final List<Map<String, dynamic>> maps2 = await dbHelper.queryAllRows('Task');
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db
        .rawQuery('''
        SELECT t.ID_Task, t.Nazwa, t.Zrobione, t.Do_Kiedy, t.Opis, t.Lokalizacja, t.Grupa,
        l.Nazwa AS Nazwa_Lokalizacji, l.Miasto, l.Ulica,
        g.Nazwa_grupa
        FROM Task AS t 
        INNER JOIN Lokalizacja AS l ON (l.ID_Lokalizacji = t.Lokalizacja) 
        INNER JOIN Grupa AS g ON (g.ID_Grupa = t.Grupa)''');
//
//    print("Maps: ${maps.length}");
//    print("Maps: ${maps2.length}");
//
//    maps2.forEach((m) {
//      print("ID " + m['ID_Task'].toString());
//      print("Name " + m['Nazwa'].toString());
//      print("done " + m['Zrobione'].toString());
//      print("time " + m['Do_Kiedy'].toString());
//      print("group " + m['Grupa'].toString());
//      print("locla " +m['Lokalizacja'].toString());
//    });

    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['ID_Task'],
        done: maps[i]['Zrobione']  == 1 ? true : false,
        name: maps[i]['Nazwa'],
        endTime: maps[i]['Do_Kiedy'] != null ? new DateFormat("yyyy-MM-dd hh:mm").parse(maps[i]['Do_Kiedy']) : null,
        description: maps[i]['Opis'],
        localization: Localization(
            id: maps[i]['Lokalizacja'],
            name: maps[i]['Nazwa_Lokalizacji'],
            city: maps[i]['Miasto'],
            street: maps[i]['Ulica'],
            isSelected: true,
        ),
        group: Group(
            id: maps[i]['Grupa'],
            name: maps[i]['Nazwa_grupa'],
            isSelected: true,
        ),
      );
    });
  }

  static Future<List<Task>> listsID(int id) async {
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db
        .rawQuery('''
        SELECT t.ID_Task, t.Nazwa, t.Zrobione, t.Do_Kiedy, t.Opis, t.Lokalizacja, t.Grupa,
        l.Nazwa AS Nazwa_Lokalizacji, l.Miasto, l.Ulica, l.JestesBlisko,
        g.Nazwa_grupa
        FROM Task AS t 
        INNER JOIN Lokalizacja AS l ON (l.ID_Lokalizacji = t.Lokalizacja) 
        INNER JOIN Grupa AS g ON (g.ID_Grupa = t.Grupa)
        WHERE Grupa = ?
        ''', [id]);

    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['ID_Task'],
        done: maps[i]['Zrobione']  == 1 ? true : false,
        name: maps[i]['Nazwa'],
        endTime: maps[i]['Do_Kiedy'] != null ? new DateFormat("yyyy-MM-dd hh:mm").parse(maps[i]['Do_Kiedy']) : null,
        description: maps[i]['Opis'],
        localization: Localization(
          id: maps[i]['Lokalizacja'],
          name: maps[i]['Nazwa_Lokalizacji'],
          city: maps[i]['Miasto'],
          street: maps[i]['Ulica'],
          isNearBy: maps[i]['JestesBlisko']== 1? true:false,
          isSelected: true,
        ),
        group: Group(
          id: maps[i]['Grupa'],
          name: maps[i]['Nazwa_grupa'],
          isSelected: true,
        ),
      );
    });
  }



  static Future<List<Task>> listsIDLocal(int idloca) async {
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db
        .rawQuery('''
        SELECT t.ID_Task, t.Nazwa, t.Zrobione, t.Do_Kiedy, t.Opis,
        g.Nazwa_grupa
        FROM Task AS t 
        INNER JOIN Grupa AS g ON (g.ID_Grupa = t.Grupa)
        WHERE Lokalizacja = ?
        ''', [idloca]);

    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['ID_Task'],
        done: maps[i]['Zrobione']  == 1 ? true : false,
        name: maps[i]['Nazwa'],
        description: maps[i]['Opis'],
        group: Group(
          name: maps[i]['Nazwa_grupa'],
        ),
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
//        _idNotification: maps[i]['Powiadomienie'],
//        idGroup: maps[i]['Grupa'],
//      );
//    });
//  }

}
