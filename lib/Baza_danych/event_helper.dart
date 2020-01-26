//import 'dart:io';
//import 'package:flutter/foundation.dart';
//import 'event.dart';
//import 'database_helper.dart';
//
//class EventHelper {
//  static final dbHelper = DatabaseHelper.instance;
//  static List<Event> _events = [];
//  List<Event> get events {
//    return [..._events];
//  }
//
//  Future<void> addWydarzenia(
//    String pickedName,
//    //DateTime pickedTerm,
//    //DateTime pickedBeginTime,
//    //DateTime pickedEndTime,
//    int pickedCycle,
//    int pickedColor,
//    String pickedDescription,
//    bool pickedNotification,
//  ) async {
//    int pickedIdEvent = await dbHelper.queryRowCount('Wydarzenie');
//    final newEvent = Event(
//      idEvent: pickedIdEvent + 1,
//      name: pickedName,
//      //term: pickedTerm,
//      //beginTime: pickedBeginTime,
//      //endTime: pickedEndTime,
//      cycle: pickedCycle,
//      color: pickedColor,
//      description: pickedDescription,
//      notification: pickedNotification,
//    );
//    _events.add(newEvent);
//    dbHelper.insert('Wydarzenie', {
//      'ID_Wydarzenie': newEvent.idEvent,
//      'Nazwa': newEvent.name,
//      //'Termin': newEvent.term,
//      //'Godzina_od': newEvent.beginTime,
//      //'Godzina_do': newEvent.endTime,
//      'Cykl': newEvent.cycle,
//      'Kolor': newEvent.color,
//      'Opis': newEvent.description,
//      'Powiadomienie': newEvent.notification,
//    });
//  }
//
//  Future<void> updateEvent(
//    int pickedIdEvent,
//    String pickedName,
//    //DateTime pickedTerm,
//    //DateTime pickedBeginTime,
//    //DateTime pickedEndTime,
//    int pickedCycle,
//    int pickedColor,
//    String pickedDescription,
//    bool pickedNotification,
//  ) async {
//    final updatedEvent = Event(
//      idEvent: pickedIdEvent,
//      name: pickedName,
//      //term: pickedTerm,
//      //beginTime: pickedBeginTime,
//      //endTime: pickedEndTime,
//      cycle: pickedCycle,
//      color: pickedColor,
//      description: pickedDescription,
//      notification: pickedNotification,
//    );
//    dbHelper.update('Wydarzenie', 'ID_Wydarzenie', pickedIdEvent, {
//      'Nazwa': updatedEvent.name,
//      //'Termin': updatedEvent.term,
//      //'Godzina_od': updatedEvent.beginTime,
//      //'Godzina_do': updatedEvent.endTime,
//      'Cykl': updatedEvent.cycle,
//      'Kolor': updatedEvent.color,
//      'Opis': updatedEvent.description,
//      'Powiadomienie': updatedEvent.notification,
//    });
//  }
//
//  Future<void> deleteEvent(
//    int pickedIdEvent,
//  ) async {
//    dbHelper.delete('Wydarzenie', 'ID_Wydarzenie', pickedIdEvent);
//  }
//
//  Future<void> fetchAndSetEvent() async {
//    final dataList = await dbHelper.queryAllRows('Wydarzenie');
//    _events = dataList
//        .map(
//          (event) => Event(
//            idEvent: event['ID_Wydarzenie'],
//            name: event['Nazwa'],
//            //term: event['Termin'],
//            //beginTime: event['Godzina_od'],
//            //endTime: event['Godzina_do'],
//            cycle: event['Cykl'],
//            color: event['Kolor'],
//            description: event['Opis'],
//            notification: event['Powiadomienie'],
//          ),
//        )
//        .toList();
//  }
//}
