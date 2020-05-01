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
String _date;

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();

  Task update;

  AddTask({this.update});
}

class _AddTaskState extends State<AddTask> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerDesc = TextEditingController();

  int id;
  String _name;
  String _decription;
  String _time;
  String _group;
  String _notification;
  String _localization;
  Color dateColor;
  Color timeColor;

  Task newtask;

  DateTime _end;

  @override
  void initState() {
    _name = (widget.update == null) ? null : widget.update.name;
    _decription = (widget.update == null) ? null : widget.update.description;
    _date = (widget.update == null)
        ? "Nie wybrano daty"
        : DateFormat("yyyy-MM-dd").format(widget.update.endTime);
    _time = (widget.update == null)
        ? "Nie wybrano godziny rozpoczęcia"
        : DateFormat("HH:mm").format(widget.update.endTime);
    _group = (widget.update == null) ? "Grupa" : "ErrorUpdate";
    _notification = (widget.update == null) ? "Powiadomienia" : "ErrorUpdate";
    _localization = (widget.update == null) ? "Lokalizacja" : "ErrorUpdate";
    _end = (widget.update == null) ? new DateTime.now() : widget.update.endTime;

    newtask = Task(
      idLocalizaton: 0,
      idGroup: 0,
      done: false,
    );

    dateColor = Colors.white;
    timeColor = Colors.white;

    if (widget.update != null) {
      controllerName = TextEditingController(text: _name);
      controllerDesc = TextEditingController(text: _decription);
    }
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              buildSpace(),
              buildCustomTextFieldwithValidation(
                  "Nazwa", "Podaj nazwę nowego zadania", controllerName),
              buildSpace(),
              buildCustomButtonWithValidation(
                  dateColor, _date, Icons.date_range, datePick),
              buildSpace(),
              buildCustomButtonWithValidation(
                  timeColor, _time, Icons.access_time, timePick),
              buildSpace(),
              buildCustomButton(
                  _group, Icons.account_circle, goToGroupPickPage),
              buildSpace(),
              buildCustomButton(
                  _notification, Icons.notifications, goToNotificationPickPage),
              buildSpace(),
              buildCustomButton(
                  _localization, Icons.edit_location, goToLocalizationPickPage),
              buildSpace(),
              buildCustomTextField("Opis", "Wprowadź opis swojego zadania",
                  "Pole jest opcjonalne", controllerDesc),
              buildSpace(),
              ButtonBar(
                  children: [
                    buildButtonBarTile("Anuluj", Colors.red, goBack),
                    SizedBox(
                      width: 30,
                    ),
                    buildButtonBarTile(
                        "Dodaj", Colors.lightGreenAccent, acceptAndValidate)
                  ],
                  alignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  buttonMinWidth: 150),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCustomTextFieldwithValidation(
      String label, String hint, TextEditingController control) {
    return TextFormField(
        controller: control,
        decoration: new InputDecoration(
            enabledBorder: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.amberAccent),
            ),
            focusedBorder: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.amber[400])),
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.red),
            ),
            labelText: label,
            labelStyle: TextStyle(color: Colors.amber[400]),
            hintText: hint,
            suffixIcon: IconButton(
                icon: Icon(Icons.clear, color: Colors.amber[400]),
                onPressed: () {
                  control.clear();
                })),
        keyboardType: TextInputType.text,
        validator: (val) {
          if (val.isEmpty) {
            return 'Pole nie może być puste!';
          }
          return null;
        });
  }

  Widget buildCustomTextField(
      String label, String hint, String helper, TextEditingController control) {
    return TextFormField(
      controller: control,
      decoration: new InputDecoration(
          enabledBorder: new OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.amberAccent),
          ),
          focusedBorder: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.amber[400])),
          labelText: label,
          labelStyle: TextStyle(color: Colors.amber[400]),
          hintText: hint,
          helperText: helper,
          helperStyle: TextStyle(color: Colors.amber[400]),
          suffixIcon: IconButton(
              icon: Icon(Icons.clear, color: Colors.amber[400]),
              onPressed: () {
                control.clear();
              })),
      keyboardType: TextInputType.text,
    );
  }

  Widget buildSpace() {
    return SizedBox(
      height: 10.0,
    );
  }

  Widget buildCustomButtonWithValidation(Color textcolor, String text,
      IconData icon, GestureTapCallback onPressed) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 5.0,
      onPressed: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 50.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  icon,
                  size: 20.0,
                  color: textcolor,
                ),
                Text(
                  " $text",
                  style: TextStyle(
                    color: textcolor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      color: Colors.amber[400],
    );
  }

  Widget buildCustomButton(String text, IconData icon, void action()) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 5.0,
      onPressed: () {
        action();
      },
      child: Container(
        alignment: Alignment.center,
        height: 50.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  icon,
                  size: 20.0,
                ),
                Text(
                  " $text",
                  style: TextStyle(),
                ),
              ],
            ),
          ],
        ),
      ),
      color: Colors.amber[400],
    );
  }

  Widget buildButtonBarTile(String text, Color color, void action()) {
    return RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 5.0,
        highlightColor: color,
        splashColor: color,
        child: Text("$text"),
        onPressed: () {
          action();
        });
  }

  void datePick() {
    DatePicker.showDatePicker(context,
        theme: DatePickerTheme(
          backgroundColor: Colors.black38,
          itemStyle: TextStyle(color: Colors.white),
          cancelStyle: TextStyle(color: Colors.amber[400]),
          doneStyle: TextStyle(color: Colors.green[400]),
          containerHeight: 210.0,
        ),
        showTitleActions: true,
        minTime: DateTime(2020, 1, 1),
        maxTime: DateTime(2025, 12, 31), onConfirm: (date) {
      _date = new DateFormat("yyyy-MM-dd").format(date);
      setState(() {});
    }, currentTime: _end, locale: LocaleType.pl);
  }

  void timePick() {
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
      _time = new DateFormat("HH:mm").format(time);
      setState(() {});
    }, currentTime: _end, locale: LocaleType.pl);
    setState(() {});
  }

  void goBack() {
    Navigator.pop(context);
  }

  void goToNotificationPickPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddNotificationTask(
                  widget.update == null ? newtask : widget.update,
                )));
  }

  void goToLocalizationPickPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddLocalization()));
  }

  void goToGroupPickPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddGroup(
                  task: widget.update == null ? newtask : widget.update,
                )));
  }

  void acceptAndValidate() {
    if (_formKey.currentState.validate()) {
      if (_date != "Nie wybrano daty" &&
          _time != "Nie wybrano godziny rozpoczęcia") {
        dateColor = Colors.white;
        timeColor = Colors.white;
        setState(() {});
        if (widget.update != null) {
//                              widget.update.name = controllerName.value.text;
//                              widget.update.endTime =
//                                  DateTime.parse("$_date $_time");

//                              TaskHelper.update(widget.update);
//                              Navigator.of(context).pop();
        } else {
//                              newtask.name = controllerName.text;
//                              newtask.description = controllerDesc.text;
//                              newtask.endTime = DateFormat("yyyy-MM-dd hh:mm")
//                                  .parse(_date + " " + _);
//                          print(newtask.name + " " + "Opis: " + newtask.description+ "Group: "+ newtask.idGroup.toString());
//                          print(newtask.name);
//                          print(newtask.endTime);
//                          print(newtask.idGroup);
//                          print(newtask.description);
//                              TaskHelper.add(newtask);
//                              Navigator.of(context).pop();
        }
      } else {
        if (_date == "Nie wybrano daty")
          dateColor = Colors.red;
        else
          dateColor = Colors.white;
        if (_time == "Nie wybrano godziny rozpoczęcia")
          timeColor = Colors.red;
        else
          timeColor = Colors.white;
        setState(() {});
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Brak danych"),
                content: Text("Wprowadź niezbędne dane"),
              );
            });
      }
    }
  }
}
