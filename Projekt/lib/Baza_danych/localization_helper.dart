import 'package:pageview/Classes/Localization.dart';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

class LocalizationHelper {
  static final dbHelper = DatabaseHelper.instance;

  static Future<int> add(Localization newLocalization) async {
    int IdLocalization =
        await dbHelper.query("SELECT MAX(ID_Lokalizacji) FROM Lokalizacja");

    dbHelper.insert('Lokalizacja', {
      'ID_Lokalizacji': IdLocalization + 1,
      'Latitude': newLocalization.latitude,
      'Longitude': newLocalization.longitude,
      'Nazwa': newLocalization.name,
      'Miasto': newLocalization.city,
      'Ulica': newLocalization.street,
    });

    return IdLocalization + 1;
  }


  static Future<void> addlist(List<Localization> list) async {
    //await Future.delayed(Duration(seconds: 1));
    int IdLocalization = await dbHelper.query("SELECT MAX(ID_Lokalizacji) FROM Lokalizacja");
    list.forEach((l){
      dbHelper.insert('Lokalizacja', {
        'ID_Lokalizacji': IdLocalization + 1,
        'Latitude': l.latitude,
        'Longitude': l.longitude,
        'Nazwa': l.name,
        'Miasto': l.city,
        'Ulica': l.street,
      });
      IdLocalization++;
    });
  }


  static Future<void> update(Localization updatedLocalization) async {
    dbHelper.update('Lokalizacja', 'ID_Lokalizacji', updatedLocalization.id, {
      'Latitude': updatedLocalization.latitude,
      'Longitude': updatedLocalization.longitude,
      'Nazwa': updatedLocalization.name,
      'Miasto': updatedLocalization.city,
      'Ulica': updatedLocalization.street,
    });
  }

  static Future<void> delete(int pickedIdLocalization) async {
    dbHelper.delete('Lokalizacja', 'ID_Lokalizacji', pickedIdLocalization);
  }

  static Future<void> deleteAndReplaceIdTask(int id) async {
    Database db = await dbHelper.database;
    db.rawUpdate("UPDATE Task SET Lokalizacja = 0 WHERE Lokalizacja = $id");
    dbHelper.delete('Lokalizacja', 'ID_Lokalizacji', id);
  }


  static Future<List<Localization>> lists() async {
    final List<Map<String, dynamic>> maps =
        await dbHelper.queryAllRows('Lokalizacja');
    return List.generate(maps.length, (i) {
      return Localization(
        id: maps[i]['ID_Lokalizacji'],
        latitude: maps[i]['Latitude'],
        longitude: maps[i]['Longitude'],
        name: maps[i]['Nazwa'],
        city: maps[i]['Miasto'],
        street: maps[i]['Ulica'],
      );
    });
  }
}
