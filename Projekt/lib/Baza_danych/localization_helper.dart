import 'package:pageview/Classes/Localization.dart';
import 'database_helper.dart';

class LocalizationHelper {
  static final dbHelper = DatabaseHelper.instance;

  static Future<void> add(Localization newLocalization) async {
    int IdLocalization =
        await dbHelper.query("SELECT MAX(ID_Lokalizacji) FROM Lokalizacja");

    dbHelper.insert('Lokalizacja', {
      'ID_Lokalizacji': IdLocalization + 1,
      'N': newLocalization.N,
      'E': newLocalization.E,
      'Nazwa': newLocalization.name,
      'Miasto': newLocalization.city,
      'Ulica': newLocalization.street,
    });
  }

  static Future<void> update(Localization updatedLocalization) async {
    dbHelper.update('Lokalizacja', 'ID_Lokalizacji', updatedLocalization.id, {
      'N': updatedLocalization.N,
      'E': updatedLocalization.E,
      'Nazwa': updatedLocalization.name,
      'Miasto': updatedLocalization.city,
      'Ulica': updatedLocalization.street,
    });
  }

  static Future<void> delete(int pickedIdLocalization) async {
    dbHelper.delete('Lokalizacja', 'ID_Lokalizacji', pickedIdLocalization);
  }

  static Future<List<Localization>> lists() async {
    final List<Map<String, dynamic>> maps =
        await dbHelper.queryAllRows('Lokalizacja');
    return List.generate(maps.length, (i) {
      return Localization(
        id: maps[i]['ID_Lokalizacji'],
        N: maps[i]['N'],
        E: maps[i]['E'],
        name: maps[i]['Nazwa'],
        city: maps[i]['Miasto'],
        street: maps[i]['Ulica'],
      );
    });
  }
}
