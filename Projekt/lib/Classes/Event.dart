import 'package:pageview/Classes/Notifi.dart';

import 'Notification.dart';

class Event {
   int id;
   String name;
   DateTime beginTime;
   DateTime endTime;
   String cycle;
   String color;
   String description;


   List<Notifi> listNotifi;

  Event({
    this.id,
    this.name,
    this.beginTime,
    this.endTime,
    this.cycle,
    this.color,
    this.description,
    this.listNotifi,
  }){
    listNotifi = List();
  }


}


