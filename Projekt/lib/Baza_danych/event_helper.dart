// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'event.dart';
// import 'database_helper.dart';

// class EventHelper {
//   static final dbHelper = DatabaseHelper.instance;
//   static List<Event> _events = [];
//   List<Event> get events {
//     return [..._events];
//   }

//   Future<void> addWydarzenia(
//     String pickedName,
//     //DateTime pickedTerm,
//     DateTime pickedBeginTime,
//     DateTime pickedEndTime,
//     String pickedCycle,
//     int pickedColor,
//     String pickedDescription,
//   ) async {
//     int pickedIdEvent = await dbHelper.queryRowCount('Wydarzenie');
//     final newEvent = Event(
//       idEvent: pickedIdEvent + 1,
//       name: pickedName,
//       //term: pickedTerm,
//       beginTime: pickedBeginTime,
//       endTime: pickedEndTime,
//       cycle: pickedCycle,
//       color: pickedColor,
//       description: pickedDescription,
//     );
//     _events.add(newEvent);
//     dbHelper.insert('Wydarzenie', {
//       'ID_Wydarzenie': newEvent.idEvent,
//       'Nazwa': newEvent.name,
//       //'Termin': newEvent.term,
//       'Godzina_od': newEvent.beginTime,
//       'Godzina_do': newEvent.endTime,
//       'Cykl': newEvent.cycle,
//       'Kolor': newEvent.color,
//       'Opis': newEvent.description,
//     });
//   }

//   Future<void> updateEvent(
//     int pickedIdEvent,
//     String pickedName,
//     //DateTime pickedTerm,
//     DateTime pickedBeginTime,
//     DateTime pickedEndTime,
//     String pickedCycle,
//     int pickedColor,
//     String pickedDescription,
//   ) async {
//     final updatedEvent = Event(
//       idEvent: pickedIdEvent,
//       name: pickedName,
//       //term: pickedTerm,
//       beginTime: pickedBeginTime,
//       endTime: pickedEndTime,
//       cycle: pickedCycle,
//       color: pickedColor,
//       description: pickedDescription,
//     );
//     dbHelper.update('Wydarzenie', 'ID_Wydarzenie', pickedIdEvent, {
//       'Nazwa': updatedEvent.name,
//       //'Termin': updatedEvent.term,
//       'Godzina_od': updatedEvent.beginTime,
//       'Godzina_do': updatedEvent.endTime,
//       'Cykl': updatedEvent.cycle,
//       'Kolor': updatedEvent.color,
//       'Opis': updatedEvent.description,
//     });
//   }

//   Future<void> deleteEvent(
//     int pickedIdEvent,
//   ) async {
//     dbHelper.delete('Wydarzenie', 'ID_Wydarzenie', pickedIdEvent);
//   }

//   static Future<List<Event>> listsEvents() async {
//     final List<Map<String, dynamic>> maps =
//         await dbHelper.queryAllRows('Wydarzenie');
//     return List.generate(maps.length, (i) {
//       return Event(
//         idEvent: maps[i]['ID_Wydarzenie'],
//         name: maps[i]['Nazwa'],
//         //term: maps[i]['Termin'],
//         beginTime: maps[i]['Godzina_od'],
//         endTime: maps[i]['Godzina_do'],
//         cycle: maps[i]['Cykl'],
//         color: maps[i]['Kolor'],
//         description: maps[i]['Opis'],
//       );
//     });
//   }
// }
