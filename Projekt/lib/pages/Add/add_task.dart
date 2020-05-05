import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:pageview/Baza_danych/task_helper.dart';
import 'package:pageview/Classes/Group.dart';
import 'package:pageview/Classes/Localization.dart';
import 'package:pageview/Classes/Task.dart';


import 'add_group.dart';
import 'add_localization.dart';
import 'add_notification.dart';


class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();

  AddTask();
}

class _AddTaskState extends State<AddTask> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController controllerDesc = TextEditingController();

  int id;
  String _time;
  String _group;
  String _notification;
  String _localization;
  Color dateColor;
  Color timeColor;
  String _date;

  Task _task;
  List<Localization> listOfLocalization;
  List<Group> listOfGroup;

  DateTime _end;

  @override
  void initState() {
    print("start");
    listOfLocalization = List();
    listOfGroup = List();

    _date = "Nie wybrano daty";
    _time = "Nie wybrano godziny rozpoczęcia";
    _group = "Grupa" ;
    _notification = "Powiadomienia" ;
    _localization =  "Lokalizacja" ;

    _end =  new DateTime.now() ;

    _task = Task(
      group: Group(id: 0),
      localization: Localization(id: 0),
      done: false,
    );

    dateColor = Colors.white;
    timeColor = Colors.white;

//    if (widget.update != null) {
//      _controllerName = TextEditingController(text: _name);
//      controllerDesc = TextEditingController(text: _description);
//    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dodaj zadanie', style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              buildSpace(),
              buildCustomTextFieldwithValidation("Nazwa", "Podaj nazwę nowego zadania", _controllerName),
              buildSpace(),
              buildCustomButtonWithValidation(dateColor, _date, Icons.date_range, datePick),
              buildSpace(),
              buildCustomButtonWithValidation(timeColor, _time, Icons.access_time, timePick),
              buildSpace(),
              buildCustomButton(_group, Icons.account_circle, goToGroupPickPage),
              buildSpace(),
              buildCustomButton(_notification, Icons.notifications, goToNotificationPickPage),
              buildSpace(),
              buildCustomButton(_localization, Icons.edit_location, goToLocalizationPickPage),
              buildSpace(),
              buildCustomTextField("Opis", "Wprowadź opis swojego zadania","Pole jest opcjonalne", controllerDesc),
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

  Widget buildCustomTextFieldwithValidation(String label, String hint, TextEditingController control) {
    return TextFormField(
        controller: control,
        decoration: new InputDecoration(
          filled: true,
          fillColor: new Color(0xFF333366),
            enabledBorder: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.white)),
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.red),
            ),
            labelText: label,
            labelStyle: TextStyle(color: Colors.white),
            hintText: hint,
            suffixIcon: IconButton(
                icon: Icon(Icons.clear, color: Colors.white),
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

  Widget buildCustomTextField(String label, String hint, String helper, TextEditingController control) {
    return TextFormField(
      controller: control,
      decoration: new InputDecoration(
        filled: true,
        fillColor: new Color(0xFF333366),
          enabledBorder: new OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.white)),
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          hintText: hint,
          helperText: helper,
          helperStyle: TextStyle(color: Colors.white),
          suffixIcon: IconButton(
              icon: Icon(Icons.clear, color: Colors.white),
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

  Widget buildCustomButtonWithValidation(Color textcolor, String text,IconData icon, GestureTapCallback onPressed) {
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
      color: new Color(0xFF333366),
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
      color: new Color(0xFF333366),
    );
  }

  Widget buildButtonBarTile(String text, Color color, void action()) {
    return RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 5.0,
        color: new Color(0xFF333366),
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
          cancelStyle: TextStyle(color: Colors.red),
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
          cancelStyle: TextStyle(color: Colors.red),
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
            builder: (context) => AddNotificationTask(_task)));
  }

  void goToLocalizationPickPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddLocalization(_task,listOfLocalization)));
  }

  void goToGroupPickPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddGroup(_task,listOfGroup)));
  }

  void acceptAndValidate() {
    if (_formKey.currentState.validate()) {
      if (_date != "Nie wybrano daty" && _time != "Nie wybrano godziny rozpoczęcia") {
        dateColor = Colors.white;
        timeColor = Colors.white;
        setState(() {});

        _task.name = _controllerName.text;
        _task.description = controllerDesc.text;
        _task.endTime = DateFormat("yyyy-MM-dd hh:mm").parse(_date + " " + _time);
        //print(_task.name + " " + "Opis: " + _task.description+ "Group: "+ _task.idGroup.toString());
         print("Name: "+_task.name);
         print("EndTask: "+_task.endTime.toString());
         print("Desc: ${_task.description}");
         print("idGroup: ${_task.group.id}");
         print("Grupa: ${_task.group.name}");
         print("idLokalizacja: ${_task.localization.id}");
         print("Localization: ${_task.localization.name}");
         print("City: ${_task.localization.city}");
         print("Latitude: ${_task.localization.latitude}");
         print("Longitude: ${_task.localization.longitude}");

        _task.listNotifi.forEach((t) => print(t.duration));

        TaskHelper.add(_task);
        //TaskHelper.add(task);
        Navigator.of(context).pop();

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
