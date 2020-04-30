import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pageview/Baza_danych/notification_helper.dart';
import 'package:pageview/Classes/Event.dart';
import 'package:pageview/Classes/Notifi.dart';
import 'package:pageview/Classes/Task.dart';
import 'package:pageview/List/button_notification_list_builder_widget.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pageview/Classes/Notification.dart';

class AddNotificationTask extends StatefulWidget {
  @override
  _AddNotificationTaskState createState() => _AddNotificationTaskState();

  Task task;

  AddNotificationTask(this.task);
}

class _AddNotificationTaskState extends State<AddNotificationTask> {
  final TextEditingController _text = new TextEditingController();
  final notifications = FlutterLocalNotificationsPlugin();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.task.id != null) {
      NotifiHelper.listsTaskID(widget.task.id).then((onList) {
        if (onList == null) {
          _notifilist = onList;
          if (widget.task.listNotifi != null) {
            _notifilist.addAll(widget.task.listNotifi);
          }
          setState(() {});
        }
      });
    } else {

      if (widget.task.listNotifi != null) {

        _notifilist = widget.task.listNotifi;
      }
    }

    super.initState();
  }

  List<Notifi> _notifilist = [];
  List<String> unitlist = ["Minuty", "Godziny", "Dni"];
  String holder = "Minuty";
  String _value = "Minuty";
  var duration;
  int czas;
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
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _text,
                      decoration: new InputDecoration(
                        labelText: "Nowe powiadomienie",
                      ),
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Pole nie może być puste!';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            new RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
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
                  setState(() {});
                }
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
                widget.task.listNotifi.clear();
                for (Notifi n in _notifilist) {
                  if (n.id == null) {
                    widget.task.listNotifi.add(n);
                  }
                }
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.event.id != null) {
      print ("jestm");
      NotifiHelper.listsEventID(widget.event.id).then((onList) {
        if (onList != null) {
          print ("jestm2");
          _notifilist = onList;
          print(_notifilist);
          print(onList);
         if (widget.event.listNotifi.isNotEmpty) {
           _notifilist.addAll(widget.event.listNotifi);
         }
         setState(() {});
        }
      });

      //NotifiHelper.lists().then((onList) { print("to$onList");});


    } else {
      if (widget.event.listNotifi.isNotEmpty) {
        _notifilist = widget.event.listNotifi;
      }
    }

    super.initState();
  }

  List<Notifi> _notifilist = [];
  List<String> unitlist = ["Minuty", "Godziny", "Dni"];
  String holder = "Minuty";
  String _value = "Minuty";
  var duration;
  int czas;
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
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _text,
                      decoration: new InputDecoration(
                        labelText: "Nowe powiadomienie",
                      ),
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Pole nie może być puste!';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            new RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
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

                  print(
                      "id:${_notifilist.last.id} idEvent:${_notifilist.last.idEvent} idTask:${_notifilist.last.idTask} time: ${_notifilist.last.duration.toString()}");

                  setState(() {});
                }
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
                List<Notifi> noti = List();
//                widget.event.listNotifi.clear();
//
                for (Notifi n in _notifilist) {
                  if (n.id == null) {
                    noti.add(n);
                  }
                }

                widget.event.listNotifi = noti;

                Navigator.pop(context);
              },
              child: Text('Potwierdź'),
            ),
          ])),
    );
  }
}
