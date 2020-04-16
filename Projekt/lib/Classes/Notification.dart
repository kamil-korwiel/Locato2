import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';  
    
class MyNotification {
   int id;
   String nazwa;
   DateTime when;

  MyNotification(int _id, DateTime _when) {
    this.id = _id;
    this.when = _when;
    this.nazwa = "Powiadomienie: godz:" + when.hour.toString() + ":" + when.minute.toString() + "  " + when.day.toString() + "/" + when.month.toString() + "/" + when.year.toString() + "r.";
  }

}


NotificationDetails get _ongoing {
  final androidChannelSpecifics = AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    'your channel description',
    importance: Importance.Max,
    priority: Priority.High,
    ongoing: true,
    autoCancel: false,
  );
  final iOSChannelSpecifics = IOSNotificationDetails();
  return NotificationDetails(androidChannelSpecifics, iOSChannelSpecifics);
}
    
    
Future showScheduleNotification(FlutterLocalNotificationsPlugin notifications) async {
  var scheduledNotificationDateTime =
      new DateTime.now().add(new Duration(seconds: 5));
   
  await notifications.schedule(
      50,
      'scheduled title',
      'scheduled body',
      scheduledNotificationDateTime,
      _ongoing);
}