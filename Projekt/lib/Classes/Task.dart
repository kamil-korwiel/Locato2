import 'package:pageview/Classes/Notification.dart';

import 'Group.dart';
import 'Localization.dart';
import 'Notifi.dart';

class Task {
  int id;
  String name;
  bool done;
  DateTime endTime;
  String description;
  Localization localization;
  Group group;

  List<Notifi> listNotifi;

  Task({
    this.id,
    this.name,
    this.done,
    this.endTime,
    this.description,
    this.localization,
    this.group,
    this.listNotifi,
  }){
    listNotifi = List();
  }
  
}
