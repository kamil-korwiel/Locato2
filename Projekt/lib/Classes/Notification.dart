import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';  
    
class MyNotification {
   int id;
   String nazwa;
   DateTime when;
   int idOwner;
   bool isSelected;

  MyNotification({
    this.id,
    this.when,
    this.nazwa = "",
    this.idOwner,
    this.isSelected  = false,
  });

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
      _ongoing)
      ;
}