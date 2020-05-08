import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pageview/Baza_danych/notification_helper.dart';
import 'package:pageview/Classes/Event.dart';
import 'package:pageview/Classes/Notifi.dart';
import 'package:pageview/Classes/Task.dart';


class Notifications_helper_background{
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static var initSettingsAndroid;
  static var initSettingsIOS;
  static  var initSettings;

  static  var androidPlatformChannelSpecifics ;
  static var iOSChannelSpecifics ;
  static NotificationDetails platformChannelSpecifics;

  Notifications_helper_background.initialize(){
    if(flutterLocalNotificationsPlugin == null) {
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      initSettingsAndroid = AndroidInitializationSettings('app_icon');
      initSettingsIOS = IOSInitializationSettings();
      initSettings = InitializationSettings(initSettingsAndroid, initSettingsIOS);

      androidPlatformChannelSpecifics = AndroidNotificationDetails('chanel_ID','chanel name','channel description', importance: Importance.Max, priority: Priority.High);
      iOSChannelSpecifics = IOSNotificationDetails();
      platformChannelSpecifics  = NotificationDetails(androidPlatformChannelSpecifics,iOSChannelSpecifics);


      flutterLocalNotificationsPlugin.initialize(initSettings,
          onSelectNotification: onSelectNotification
      );

    }
  }

  Future onSelectNotification(String payload) async {
    if(payload != null){
      print('Notification payload: $payload');
    }
    //await Navigator.push(context, MaterialPageRoute(builder: (context)=> SecondRoute()));
  }



  static Future<void> add(int id_notifi, String title, String description , DateTime when) async {
    await flutterLocalNotificationsPlugin.schedule(id_notifi, title, description, when, platformChannelSpecifics);
  }

  static void addTask(Task task, List<Notifi>  notifi)  {
    notifi.forEach((n) => flutterLocalNotificationsPlugin.schedule(n.id, "Zadanie:", task.name, task.endTime.subtract(n.duration), platformChannelSpecifics));
  }

//  static void updateTask(Notifi n, Task task)  {
//    //flutterLocalNotificationsPlugin.cancel(n.id);
//    flutterLocalNotificationsPlugin.schedule(n.id, "Zadanie:", task.name, task.endTime.subtract(n.duration), platformChannelSpecifics);
//  }

//  static void updateTask(Notifi n, Event event)  {
//    //flutterLocalNotificationsPlugin.cancel(n.id);
//    flutterLocalNotificationsPlugin.schedule(n.id, "Zadanie:", task.name, task.endTime.subtract(n.duration), platformChannelSpecifics);
//  }

  static  void addEvent(Event event,List<Notifi>  notifi)  {
    notifi.forEach((n) => flutterLocalNotificationsPlugin.schedule(n.id, "Wydarzenie:", event.name, event.beginTime.subtract(n.duration), platformChannelSpecifics));
  }

  static Future<void> deleteTask(int id) async {
    List<Notifi> notifi = await NotifiHelper.listsTaskID(id);
//    for(Notifi n in notifi) {
//      await flutterLocalNotificationsPlugin.cancel(n.id);
//    }
    notifi.forEach((n) => flutterLocalNotificationsPlugin.cancel(n.id));
    NotifiHelper.deleteTaskID(id);
  }

  static Future<void> deleteEvent(int id) async {
    List<Notifi> notifi = await NotifiHelper.listsEventID(id);
//    for(Notifi n in notifi) {
//      await flutterLocalNotificationsPlugin.cancel(n.id);
//    }
     notifi.forEach((n) => flutterLocalNotificationsPlugin.cancel(n.id));
     NotifiHelper.deleteEventID(id);
  }

  static  Future<void> deleteNotifi(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static  Future<void> deleteListNotifi(List<Notifi> list) async {
    list.forEach((n) => flutterLocalNotificationsPlugin.cancel(n.id));
  }

  static Future<void> now(String title,String decription) async {
    await flutterLocalNotificationsPlugin.show(0,title, decription, platformChannelSpecifics);
  }




//  void showNotification() async{
//    await _demoNotification();
//  }
//
//  Future<void> _demoNotification() async {
//    var androidPlatformChannelSpecifics = AndroidNotificationDetails('chanel_ID','chanel name','channel description', importance: Importance.Max, priority: Priority.High, ticker: 'test ticker' );
//    var iOSChannelSpecifics = IOSNotificationDetails();
//    var platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics,iOSChannelSpecifics);
//
//    await flutterLocalNotificationsPlugin.show(0,'hello buudy','A message from flutter buddy', platformChannelSpecifics, payload: 'test payload');
//    }

//Przy kliknięcu notyfikacji



//  Future onDidReceiveLocalNotification(int id,String title,String body,String payload) async{
//    print("lol2");
//    await showDialog(
//      context: context,
//      builder: (BuildContext context) => CupertinoAlertDialog(
//        title: Text(title),
//        content: Text(body),
//        actions: <Widget>[
//          CupertinoDialogAction(
//            isDefaultAction: true,
//            child: Text('ok'),
//            onPressed: () async {
//              Navigator.of(context,rootNavigator: true).pop();
//              await Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondRoute()),);
//            },
//          )
//        ],
//
//      ),
//    );
//
//  }



}

