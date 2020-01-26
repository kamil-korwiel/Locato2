import 'dart:io';
import 'package:flutter/foundation.dart';

class Task {
  final int idTask;
  final String name;
  //final DateTime endTime;
  final int location;
  final String description;
  final int group;

  Task({
    this.idTask,
    this.name,
    //this.endTime,
    this.location,
    this.description,
    this.group,
  });
}
