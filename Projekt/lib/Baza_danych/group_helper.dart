import 'package:pageview/Classes/Group.dart';
import 'package:pageview/Classes/Task.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

class GroupHelper {
  static final dbHelper = DatabaseHelper.instance;


  static Future<int> add(Group newGroup) async {
    int IdGroup = await dbHelper.query("SELECT max(ID_Grupa) FROM Grupa");
    IdGroup = IdGroup == null ? 0: IdGroup;
    dbHelper.insert('Grupa', {
      'ID_Grupa': IdGroup + 1,
      'Nazwa_grupa': newGroup.name,
      'Ile_wykonane': newGroup.howMuchDone,
    });
    return IdGroup + 1;
  }

  static Future<void> addlist(List<Group> list) async {
    //await Future.delayed(Duration(seconds: 1));
    int IdGroup = await dbHelper.query("SELECT max(ID_Grupa) FROM Grupa");
    IdGroup = IdGroup == null ? 0: IdGroup;
    list.forEach((g) {
      dbHelper.insert('Grupa', {
        'ID_Grupa': IdGroup + 1,
        'Nazwa_grupa': g.name,
        'Ile_wykonane': g.howMuchDone,
      });
      IdGroup++;
    });
  }


  static Future<void> update(Group updatedGroup) async {

    dbHelper.update('Grupa', 'ID_Grupa', updatedGroup.id, {
      'Nazwa_grupa': updatedGroup.name,
      'Ile_wykonane': updatedGroup.howMuchDone,
    });
  }

  static Future<void> delete(int pickedIdGroup,) async {


    dbHelper.delete('Grupa', 'ID_Grupa', pickedIdGroup);

  }



  static Future<void> deleteAndReplaceIdTask(int id) async {
    Database db = await dbHelper.database;
    db.rawUpdate("UPDATE Task SET Grupa = 0 WHERE Grupa = $id");
    dbHelper.delete('Grupa', 'ID_Grupa', id);
  }

  static Future<int> getPercent(int id) async {
    int countdone = await dbHelper.query("SELECT COUNT(*) FROM Task WHERE Grupa=$id AND Zrobione=1");
    int countALL = await dbHelper.query("SELECT COUNT(*) FROM Task WHERE Grupa=$id");

    return (100 * (countdone/countALL)).round();
  }

  static Future<List<Group>> lists() async {
    final List<Map<String, dynamic>> maps = await dbHelper.queryAllRows('Grupa');
    return List.generate(maps.length, (i) {
      return Group(
        id: maps[i]['ID_Grupa'],
        name: maps[i]['Nazwa_grupa'],
        howMuchDone: maps[i]['Ile_wykonane'],
      );
    });
  }



}
