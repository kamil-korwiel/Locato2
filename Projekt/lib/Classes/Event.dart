import 'package:flutter/material.dart';

class Event {

  String _name;
  DateTime _start;
  DateTime _end;
  String _description;
  bool _is_cyclic;
  String _cycle;
  String _color;
  Event(this._name, this._start, this._end, this._description,
      this._is_cyclic, this._cycle, this._color);



  String get name => _name;

  String get start {
    return  _start.hour.toString() +":"+ _start.minute.toString() ;
  } // to do

  Color get color {
    return Color(0xFFB74093);
  } // to do

  String get cycle => _cycle;

  bool get is_cyclic => _is_cyclic;

  String get description => _description;

  String get end {
    return  _end.hour.toString() +":"+ _end.minute.toString() ;
  }
}

