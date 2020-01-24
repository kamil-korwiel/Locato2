import 'dart:io';
import 'package:flutter/foundation.dart';

class Event {
  final int idEvent;
  final String name;
  //final DateTime term;
  //final DateTime beginTime;
  //final DateTime endTime;
  final int cycle;
  final int color;
  final String description;
  final bool notification;

  Event({
    this.idEvent,
    this.name,
    //this.term,
    //this.beginTime,
    //this.endTime,
    this.cycle,
    this.color,
    this.description,
    this.notification,
  });
}
