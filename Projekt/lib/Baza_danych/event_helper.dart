import 'package:intl/intl.dart';
import 'package:pageview/Classes/Event.dart';

import 'database_helper.dart';

class EventHelper {
  static final dbHelper = DatabaseHelper.instance;


  static Future<void> add(Event newEvent) async {
    int IdEvent = await dbHelper.query("SELECT MAX(ID_Wydarzenie) FROM Wydarzenie");
    //pickedIdEvent = pickedIdEvent == null ? 0 : pickedIdEvent;
    //print("LOLLLLLLLL: $pickedIdEvent");
    IdEvent = IdEvent == null ? 0 : IdEvent;
    dbHelper.insert('Wydarzenie', {
      'ID_Wydarzenie': IdEvent + 1,
      'Nazwa': newEvent.name,
      'Termin_od': DateFormat("yyyy-MM-dd hh:mm").format(newEvent.beginTime),
      'Termin_do': DateFormat("yyyy-MM-dd hh:mm").format(newEvent.endTime),
      'Cykl': newEvent.cycle,
      'Powiadomienie':newEvent.idNotification,
      'Kolor': newEvent.color,
      'Opis': newEvent.description,
    });
  }

  static Future<void> update(Event updatedEvent) async {
    dbHelper.update('Wydarzenie', 'ID_Wydarzenie', updatedEvent.id, {
      'Nazwa': updatedEvent.name,
      'Termin_od': DateFormat("yyyy-MM-dd hh:mm").format(updatedEvent.beginTime),
      'Termin_do': DateFormat("yyyy-MM-dd hh:mm").format(updatedEvent.endTime),
      'Cykl': updatedEvent.cycle,
      'Powiadomienie':updatedEvent.idNotification,
      'Kolor': updatedEvent.color,
      'Opis': updatedEvent.description,
    });
  }

  static Future<void> delete(int pickedIdEvent) async {
    dbHelper.delete('Wydarzenie', 'ID_Wydarzenie', pickedIdEvent);
  }

  static Future<List<Event>> lists() async {
    final List<Map<String, dynamic>> maps =
    await dbHelper.queryAllRows('Wydarzenie');
    return List.generate(maps.length, (i) {
      return Event(
        id: maps[i]['ID_Wydarzenie'],
        name: maps[i]['Nazwa'],
        beginTime: new DateFormat("yyyy-MM-dd hh:mm").parse(maps[i]['Termin_od']),
        endTime: new DateFormat("yyyy-MM-dd hh:mm").parse(maps[i]['Termin_do']),
        cycle: maps[i]['Cykl'],
        color: maps[i]['Kolor'],
        idNotification: maps[i]['Powiadomienie'],
        description: maps[i]['Opis'],
      );
    });
  }

  static Future<List<Event>> listsDay(int day) async {
    final List<Map<String, dynamic>> maps = await dbHelper.queryEventDay(day);
    return List.generate(maps.length, (i) {
      return Event(
        id: maps[i]['ID_Wydarzenie'],
        name: maps[i]['Nazwa'],
        beginTime: maps[i]['Termin_od'],
        endTime: maps[i]['Termin_do'],
        cycle: maps[i]['Cykl'],
        color: maps[i]['Kolor'],
        idNotification: maps[i]['Powiadomienie'],
        description: maps[i]['Opis'],
      );
    });
  }

}
