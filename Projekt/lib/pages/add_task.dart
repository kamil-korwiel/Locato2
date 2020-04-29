import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:pageview/Baza_danych/group_helper.dart';
import 'package:pageview/Baza_danych/task_helper.dart';
import 'package:pageview/Classes/Group.dart';
import 'package:pageview/Classes/NotificationDescription.dart';
import 'package:pageview/pages/add_group.dart';
import 'package:pageview/Classes/Task.dart';
import 'package:pageview/pages/add_notification.dart';
import 'package:pageview/Classes/NotificationDescription.dart';
import 'package:pageview/pages/add_localization.dart';
import 'add_notification.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();

  Task update;

  AddTask({this.update});
}

class _AddTaskState extends State<AddTask> {
  final controllerName = TextEditingController();
  final controllerDesc = TextEditingController();

  String _name;
  String _decription;
  String _date ;
  String _time1 ;
  String _group ;
  String _notification;
  String _localization;

  int _idNotification = 0;
  int _idLocalizaton = 0;
  int _idGroup = 0;

  Task newtask = Task();

  DateTime _end ;



  @override
  void initState() {
    _name = (widget.update == null)? null : widget.update.name;
    _decription = (widget.update == null)? null : widget.update.description;
    _date = (widget.update == null)? "Nie wybrano daty" : DateFormat("yyyy-MM-dd").format(widget.update.endTime);
    _time1 = (widget.update == null)?"Nie wybrano godziny rozpoczęcia" : DateFormat("hh:mm").format(widget.update.endTime);
    _group = (widget.update == null)? "Nie wybrano grupy": "ErrorUpdate";
    _notification = (widget.update == null)? "Nie wybrano powiadomień": "ErrorUpdate";
    _localization = (widget.update ==null)?"Nie wybrano lokalizacji" : "ErrorUpdate";
    _end = (widget.update == null)?new DateTime.now(): widget.update.endTime;

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dodaj zadanie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
            child: ListView(
            children: <Widget>[
              new TextFormField(
                controller: controllerName,
                decoration: const InputDecoration(
                  labelText: "Nazwa",
                  hintText: "Podaj nazwę nowego zadania",
                ),
                keyboardType: TextInputType.text,
                initialValue: _name,
                validator: (val) {
                if (val.isEmpty) {
                  return 'Pole nie może być puste!';
                }
                return null;
              },
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
                  }, currentTime: _end, locale: LocaleType.pl);
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
                  }, currentTime:_end, locale: LocaleType.pl);
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
                RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddLocalization()));
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
                                  Icons.edit_location,
                                  size: 18.0,
                                ),
                                Text(" $_localization"),
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
                height: 20.0,
              ),
              new TextFormField(
                controller: controllerDesc,
                decoration: new InputDecoration(
                  labelText: "Opis",
                  hintText: "Dodaj opis swojego zadania"
                ),
                keyboardType: TextInputType.text,
                initialValue: _decription,
                validator: (val) {
                if (val.isEmpty) {
                  return 'Pole nie może być puste!';
                }
                return null;
              },
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
                        /*if(widget.update != null){
                          widget.update.name = controllerName.value.text;
                          DateTime t1 = DateTime.parse("$_date $_time1");
                          widget.update.endTime = t1;

//                          widget.update.idNotification = _idNotification;
//                          widget.update.idGroup = _idGroup;
//                          widget.update.idLocalizaton = _idLocalizaton;

                          //TODO: Update grupe
                          TaskHelper.update(widget.update);
                          Navigator.of(context).pop();
                        }else{
                          newtask.name = controllerName.text;
                          newtask.description = controllerDesc.text;
                          newtask.endTime =  DateFormat("yyyy-MM-dd hh:mm").parse(_date + " " + _time1);

                          newtask.idNotification = _idNotification;
                          newtask.idGroup = _idGroup;
                          newtask.idLocalizaton = _idLocalizaton;
                          //TODO: Dodać grupe
//                          print(newtask.name);
//                          print(newtask.endTime);
//                          print(newtask.idGroup);
//                          print(newtask.description);*/
                          _formKey.currentState.validate();
                          //TaskHelper.add(newtask);
                         // Navigator.of(context).pop();
                        //}

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