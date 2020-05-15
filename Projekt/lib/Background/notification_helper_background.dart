import 'dart:isolate';
import 'dart:math';

import 'package:duration/duration.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pageview/Baza_danych/notification_helper.dart';
import 'package:pageview/Classes/Event.dart';
import 'package:pageview/Classes/Notifi.dart';
import 'package:pageview/Classes/Task.dart';


abstract class Notifications_helper_background{
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


  static init(){
    if(_flutterLocalNotificationsPlugin == null) {
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      initSettingsAndroid = AndroidInitializationSettings('app_icon');
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




  static Future _onSelectNotification(String payload) async {
    if(payload != null){
      print('Notification payload: $payload');
    }
    //await Navigator.push(context, MaterialPageRoute(builder: (context)=> SecondRoute()));
  }

  static Future<void> add(int id_notifi, String title, String description , DateTime when) async {
    await _flutterLocalNotificationsPlugin.schedule(id_notifi, title, description, when, platformChannelSpecifics);
  }

  static Future<void> now(String title,String decription) async {
    int isolateId = Random().nextInt(100000000);
    print("isolateId: $isolateId");
    await _flutterLocalNotificationsPlugin.show(isolateId,title, decription, platformChannelSpecifics);
  }

  static void ListOfTaskNotifi(Task task)  {
      for(Notifi n in task.listNotifi) {
        _flutterLocalNotificationsPlugin.schedule(n.id, "Zadanie do zrobienia:", task.name, task.endTime.subtract(n.duration), platformChannelSpecifics);
      }
  }

  static void ListOfEventNotifi(Event event) {
    for(Notifi n in event.listNotifi){
      _flutterLocalNotificationsPlugin.schedule(n.id, "Wydarzenie:", event.name, event.beginTime.subtract(n.duration), platformChannelSpecifics);
    }
  }



  static Future<void> deleteTask(int id) async {
    List<Notifi> notifi = await NotifiHelper.listsTaskID(id);
    notifi.forEach((n) => _flutterLocalNotificationsPlugin.cancel(n.id));
    NotifiHelper.deleteTaskID(id);
  }

  static Future<void> deleteEvent(int id) async {
    List<Notifi> notifi = await NotifiHelper.listsEventID(id);
     notifi.forEach((n) => _flutterLocalNotificationsPlugin.cancel(n.id));
     NotifiHelper.deleteEventID(id);
  }

  static  Future<void> deleteNotifi(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  static  Future<void> deleteListNotifi(List<Notifi> list) async {
    list.forEach((n) => _flutterLocalNotificationsPlugin.cancel(n.id));
  }

}

