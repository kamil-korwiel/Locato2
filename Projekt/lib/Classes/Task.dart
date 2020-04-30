import 'package:pageview/Classes/Notification.dart';

import 'Notifi.dart';

class Task {
  int id;
  String name;
  bool done;
  DateTime endTime;
  String description;
  int idLocalizaton;
  int idGroup;


  List<Notifi> listNotifi;


  Task({
    this.id,
    this.name,
    this.done,
    this.endTime,
    this.description,
    this.idLocalizaton,
    this.idGroup,
    this.listNotifi,
  }){
    listNotifi = List();
  }


}
