import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pageview/Baza_danych/notification_helper.dart';
import 'package:pageview/Classes/Event.dart';
import 'package:pageview/Classes/Notifi.dart';
import 'package:pageview/Classes/Task.dart';
import 'package:pageview/List/button_notification_list_builder_widget.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pageview/Classes/Notification.dart';

//TODO: Problem z dodawanie do listy raz pobraś z future i nigdy już nie przebudowywać.

class AddNotificationTask extends StatefulWidget {
  @override
  _AddNotificationTaskState createState() => _AddNotificationTaskState();

  Task task;

  AddNotificationTask(this.task);
}

class _AddNotificationTaskState extends State<AddNotificationTask> {
  final TextEditingController _text = new TextEditingController();
  final notifications = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    NotifiHelper.getMaxID().then((onValue) {
      _id = onValue;
    }).catchError(() {
      _id = 0;
    });

    super.initState();
  }

  int _id;
  List<String> unitlist = ["Minuty", "Godziny", "Dni"];
  String holder = "Minuty";
  String _value = "Minuty";
  DateTime teraz = DateTime.now();
  DateTime pom = DateTime.now();
  var duration;
  int czas;
  int length = 0;
  String name;

  void getDropDownItem() {
    setState(() {
      holder = _value;
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
                if (holder == "Minuty") {
                  czas = int.parse(_text.text);
                  duration = new Duration(minutes: czas);
                  name = "$czas minut przed";
                }
                if (holder == "Godziny") {
                  czas = int.parse(_text.text);
                  duration = new Duration(minutes: czas);
                  name = "$czas godzin przed";
                }
                if (holder == "Dni") {
                  czas = int.parse(_text.text);
                  duration = new Duration(minutes: czas);
                  name = "$czas dni przed";
                }
                pom = teraz.add(duration);
                NotifiHelper.add(
                    Notifi(id: _id, idTask: widget.task.id, duration: Duration()));
                _id++;
                setState(() {});
              },
              child: Text('Dodaj'),
            ),
            SizedBox(
              height: 10.0,
            ),
            FutureBuilder(
              future: NotifiHelper.listsTaskID(widget.task.id),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  // return Container();
                  case ConnectionState.waiting:
                  // return Container();
                  case ConnectionState.active:
                  case ConnectionState.done:
                    {
                      if (snapshot.hasData) {
                        return ListNotifi(snapshot.data);
                      }
                    }
                }
                return Container();
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            new RaisedButton(
              onPressed: () {
                if (widget.task.id == null) {
                } else {}

                Navigator.pop(context);
              },
              child: Text('Potwierdź'),
            ),
          ])),
    );
  }
}

class AddNotificationEvent extends StatefulWidget {
  @override
  _AddNotificationEventState createState() => _AddNotificationEventState();

  Event event;

  AddNotificationEvent(this.event);

// Notification notification;
// AddNotification({this.notification});

}

class _AddNotificationEventState extends State<AddNotificationEvent> {
  final TextEditingController _text = new TextEditingController();

  @override
  void initState() {
    NotifiHelper.listsEventID(widget.event.id)
        .then((onList) {
          if(onList == null) {
            _notifilist = onList;
            setState(() {});
          }
        });
    super.initState();
  }

  List<Notifi> _notifilist = [];
  List<Notifi> _notifilistnew = [];
  List<String> unitlist = ["Minuty", "Godziny", "Dni"];
  String holder = "Minuty";
  String _value = "Minuty";
  var duration;
  int czas;
  String name;

  DateTime _time = DateFormat("yyyy-MM-dd hh:mm").parse("0000-00-00 00:00");

  void getDropDownItem() {
    setState(() {
      holder = _value;
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
                if (holder == "Minuty") {
                  czas = int.parse(_text.text);
                  duration = new Duration(minutes: czas);
                  name = "$czas minut przed";
                }
                if (holder == "Godziny") {
                  czas = int.parse(_text.text);
                  duration = new Duration(hours: czas);
                  name = "$czas godzin przed";
                }
                if (holder == "Dni") {
                  czas = int.parse(_text.text);
                  duration = new Duration(days: czas);
                  name = "$czas dni przed";
                }

                _notifilist.add(Notifi(duration: duration));
                _notifilistnew.add(Notifi(duration: duration));

                print(
                    "id:${_notifilist.last.id} idEvent:${_notifilist.last.idEvent} idTask:${_notifilist.last.idTask} time: ${_notifilist.last.duration.toString()}");

                setState(() {});
              },
              child: Text('Dodaj'),
            ),
            SizedBox(
              height: 10.0,
            ),
            ListNotifi(_notifilist),
            SizedBox(
              height: 10.0,
            ),
            new RaisedButton(
              onPressed: () {
                widget.event.listNotifi = _notifilistnew;
                Navigator.pop(context);
              },
              child: Text('Potwierdź'),
            ),
          ])),
    );
  }
}
