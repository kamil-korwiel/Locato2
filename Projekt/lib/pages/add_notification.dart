import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pageview/pages/add_task.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pageview/Classes/Notification.dart';

class AddNotification extends StatefulWidget {
  @override
  _AddNotificationState createState() => _AddNotificationState();

  // Notification notification;
  // AddNotification({this.notification});

}

class _AddNotificationState extends State<AddNotification> {

  final TextEditingController _text = new TextEditingController();
  final notifications = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    /*final settingsAndroid = AndroidInitializationSettings('app_icon');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);*/
  }

  Future onSelectNotification(String payload) async => await Navigator.pop(context);//Navigator.push(
       // context,
        //co ma sie dziac po wcisnieciu powiadomienia
       // MaterialPageRoute(builder: (context) => SecondPage(payload: payload)),
    //  );


  List<MyNotification> notificationlist = [];
  int _currentIndex = 0;
  List<String> unitlist = ["Minuty", "Godziny", "Dni"];
  String holder = "Minuty";
  String _value = "Minuty";
  DateTime teraz = DateTime.now();
  DateTime pom = DateTime.now();
  var duration;
  int czas;
  int length = 0;
<<<<<<< HEAD
  String name;
  
=======

>>>>>>> 498806557332295ca464ef54222151c37c886b79

  void getDropDownItem(){
    setState(() {
      holder = _value ;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dodaj powiadomienie"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(children: <Widget>[
            new Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
DropdownButton<String>(
	value: _value,
	icon: Icon(Icons.arrow_drop_down),
	iconSize: 24,
	elevation: 16,
	onChanged: (String data) {
	  setState(() {
		_value = data;
    getDropDownItem();
	  });
	},
	items: unitlist.map<DropdownMenuItem<String>>((String value) {
	  return DropdownMenuItem<String>(
		value: value,
		child: Text(value),
	  );
	}).toList(),
  ),
      Flexible(
        child: TextFormField(
              controller: _text,
              decoration: new InputDecoration(
                labelText: "Nowe powiadomienie",
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(0.0),
                  borderSide: new BorderSide(),
                ),
              ),
              keyboardType: TextInputType.text,
            ),
      ),
    ],
           ),
            SizedBox(
              height: 10.0,
            ),
            new RaisedButton(
              onPressed: () {
                if(holder == "Minuty"){
                czas = int.parse(_text.text);
                duration = new Duration(minutes: czas);
                name = "$czas minut przed";
                }
                if(holder == "Godziny"){
                czas = int.parse(_text.text);
                duration = new Duration(minutes: czas);
                name = "$czas godzin przed";
                }
                if(holder == "Dni"){
                czas = int.parse(_text.text);
                duration = new Duration(minutes: czas);
                name = "$czas dni przed";
                }
                pom = teraz.add(duration);
                notificationlist.add(new MyNotification(id: _currentIndex,when: pom, nazwa: name));
                _text.clear();
                _currentIndex++;
                length = notificationlist.length;
                setState(() {});
              },
              child: Text('Dodaj'),
            ),
            SizedBox(
              height: 10.0,
            ),
            new ListView.builder(
                shrinkWrap: true,
                itemCount: notificationlist.length,
                itemBuilder: (context, index) {
                  return RaisedButton(
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.account_circle,
                                      size: 18.0,
                                    ),
                                    Text(notificationlist[index].nazwa),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    onPressed: () => Scaffold
                    .of(context)
                   .showSnackBar(SnackBar(content: Text(notificationlist[index].nazwa))),
              );
                    }),
            SizedBox(
              height: 10.0,
            ),
            new RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Potwierdź'),
            ),
          ])),
    );
  }
}
