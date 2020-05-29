import 'dart:math';
import 'package:Locato/DatabaseHelper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../MainClasses.dart';


///Abstract class, helping to schedule Notification on project Loacato
abstract class NotificationHelperBackground{
  static FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  static AndroidInitializationSettings initSettingsAndroid;
  static IOSInitializationSettings initSettingsIOS;
  static  InitializationSettings initSettings;

  static  AndroidNotificationDetails androidPlatformChannelSpecifics ;
  static IOSNotificationDetails iOSChannelSpecifics ;
  static NotificationDetails platformChannelSpecifics;

  FlutterLocalNotificationsPlugin get flutterLocalNotificationsPlugin  {
    return init();
  }

  /// Creating some class needed to start using this class. This must be called before setting any notification.
  static init(){
    if(_flutterLocalNotificationsPlugin == null) {
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      initSettingsAndroid = AndroidInitializationSettings('app_icon_transparent');
      initSettingsIOS = IOSInitializationSettings();
      initSettings =
          InitializationSettings(initSettingsAndroid, initSettingsIOS);

      androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'chanel_ID', 'chanel name', 'channel description',
          importance: Importance.Max, priority: Priority.High);
      iOSChannelSpecifics = IOSNotificationDetails();
      platformChannelSpecifics = NotificationDetails(
          androidPlatformChannelSpecifics, iOSChannelSpecifics);


      _flutterLocalNotificationsPlugin.initialize(initSettings,
          onSelectNotification: _onSelectNotification
      );
    }
    return _flutterLocalNotificationsPlugin;
  }



/// Doing something after clicked notification
  static Future _onSelectNotification(String payload) async {
    if(payload != null){
      print('Notification payload: $payload');
    }
    //await Navigator.push(context, MaterialPageRoute(builder: (context)=> SecondRoute()));
  }
  /// Adding notification
  static Future<void> add(int id_notifi, String title, String description , DateTime when) async {
    await _flutterLocalNotificationsPlugin.schedule(id_notifi, title, description, when, platformChannelSpecifics);
  }

  /// When method is called then showing a notification immediately.
  static Future<void> now(String title,String decription) async {
    int isolateId = Random().nextInt(100000000);
    print("isolateId: $isolateId");
    await _flutterLocalNotificationsPlugin.show(isolateId,title, decription, platformChannelSpecifics);
  }

  /// When give class 'Task' to method then created is scheduled all Nofification
  static void ListOfTaskNotifi(Task task)  {
      for(Notifi n in task.listNotifi) {
        _flutterLocalNotificationsPlugin.schedule(n.id, "Zadanie do zrobienia:", task.name, task.endTime.subtract(n.duration), platformChannelSpecifics);
      }
  }
  /// When give class 'Event' to method then created is scheduled all Nofification
  static void ListOfEventNotifi(Event event) {
    for(Notifi n in event.listNotifi){
      _flutterLocalNotificationsPlugin.schedule(n.id, "Wydarzenie:", event.name, event.beginTime.subtract(n.duration), platformChannelSpecifics);
    }
  }


  /// Deleting all Notification associated with this 'Task' by id from Data Base and canceled from showing on device.
  static Future<void> deleteTask(int id) async {
    List<Notifi> notifi = await NotifiHelper.listsTaskID(id);
    notifi.forEach((n) => _flutterLocalNotificationsPlugin.cancel(n.id));
    NotifiHelper.deleteTaskID(id);
  }

  /// Deleting all Notification associated with this 'Event' by id from Data Base and canceled from showing on device.
  static Future<void> deleteEvent(int id) async {
    List<Notifi> notifi = await NotifiHelper.listsEventID(id);
     notifi.forEach((n) => _flutterLocalNotificationsPlugin.cancel(n.id));
     NotifiHelper.deleteEventID(id);
  }
  /// Canceled notification by "id' notification
  static  Future<void> deleteNotifi(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  /// Canceled list of notification by 'id' using 'Notifi' class notification
  static  Future<void> deleteListNotifi(List<Notifi> list) async {
    list.forEach((n) => _flutterLocalNotificationsPlugin.cancel(n.id));
  }

}

