import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:pageview/Classes/Group.dart';
import 'package:pageview/pages/add_group.dart';
import 'package:pageview/Classes/Task.dart';

import 'add_notification.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();

  Task task;

  AddTask({this.task});
}

class _AddTaskState extends State<AddTask> {
  final controllerName = TextEditingController();
  final controllerDesc = TextEditingController();

  String _date = "Nie wybrano daty";
  String _time1 = "Nie wybrano godziny zakończenia";
  String _group = "Nie wybrano grupy";
  String _notification = "Nie wybrano powiadomień";

  Task newtask = Task();

  @override
  void initState() {
    super.initState();
  }

  String _value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dodaj zadanie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: ListView(
//            mainAxisSize: MainAxisSize.max,
//            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new TextFormField(
                controller: controllerName,
                decoration: new InputDecoration(
                  labelText: "Nazwa",
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(0.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      theme: DatePickerTheme(
                        backgroundColor: Colors.black38,
                        itemStyle: TextStyle(color: Colors.white),
                        cancelStyle: TextStyle(color: Colors.amber[400]),
                        doneStyle: TextStyle(color: Colors.green[400]),
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true,
                      minTime: DateTime(2000, 1, 1),
                      maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                    print('confirm $date');
                    String month = date.month < 10 ? '0${date.month}' : '${date.month}';
                    String day = date.day < 10 ? '0${date.day}' : '${date.day}';
                    _date = '${date.year}-$month-$day';
                    setState(() {});
                  }, currentTime: DateTime.now(), locale: LocaleType.pl);
                },
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
                                  Icons.date_range,
                                  size: 18.0,
                                ),
                                Text(
                                  " $_date",
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                color: Colors.amber[400],
              ),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showTimePicker(context,
                      theme: DatePickerTheme(
                        backgroundColor: Colors.black38,
                        itemStyle: TextStyle(color: Colors.white),
                        cancelStyle: TextStyle(color: Colors.amber[400]),
                        doneStyle: TextStyle(color: Colors.green[400]),
                        containerHeight: 210.0,
                      ),
                      showSecondsColumn: false,
                      showTitleActions: true, onConfirm: (time) {
                    print('confirm $time');
                    String hour =
                    time.hour < 10 ? '0${time.hour}' : '${time.hour}';
                    String minute =
                    time.minute < 10 ? '0${time.minute}' : '${time.minute}';
                    _time1 = hour + ':' + minute;
                    setState(() {});
                  }, currentTime: DateTime.now(), locale: LocaleType.pl);
                  setState(() {});
                },
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
                                  Icons.access_time,
                                  size: 18.0,
                                ),
                                Text(
                                  " $_time1",
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                color: Colors.amber[400],
              ),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddGroup()));
                },
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
                                Text(" $_group"),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                color: Colors.amber[400],
              ),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddNotification()));
                },
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
                                  Icons.notifications,
                                  size: 18.0,
                                ),
                                Text(" $_notification"),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                color: Colors.amber[400],
              ),
              SizedBox(
                height: 10.0,
              ),
              new TextFormField(
                controller: controllerDesc,
                decoration: new InputDecoration(
                  labelText: "Opis",
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(0.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 10.0,
              ),
              new ButtonBar(
                  children: [
                    RaisedButton(
                      child: Text("Anuluj"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    RaisedButton(
                      child: Text("Dodaj"),
                      onPressed: () {
                        newtask.name = controllerName.text;
                        newtask.description = controllerDesc.text;
                        newtask.endTime = _date + " " + _time1;
                        print(newtask.name);
                        print(newtask.endTime);
                        print(newtask.idGroup);
                        print(newtask.description);
                      },
                    ),
                  ],
                  alignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  buttonMinWidth: 150
              ),
            ],
          ),
        ),
      ),
    );
  }
}


