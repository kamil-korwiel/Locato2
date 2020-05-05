import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import 'package:pageview/pages/Add/add_group.dart';
import 'package:pageview/Classes/Task.dart';
import 'package:pageview/pages/Update/upgrade_notification.dart';

import 'upgrade_localization.dart';





class UpgradeTask extends StatefulWidget {
  @override
  _UpgradeTaskState createState() => _UpgradeTaskState();

  Task task;

  UpgradeTask({this.task});
}

class _UpgradeTaskState extends State<UpgradeTask> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController controllerDesc = TextEditingController();

  int id;
  String _date;
  String _time;
  String _group;
  String _notification;
  String _localization;
  Color dateColor;
  Color timeColor;

  DateTime _end;

  @override
  void initState() {

   _date = DateFormat("yyyy-MM-dd").format(widget.task.endTime);
    _time = DateFormat("HH:mm").format(widget.task.endTime);
    _group =  widget.task.group.name ;
    _notification = "Powiadomienia";
    _localization = widget.task.group.name;
    _end =new DateTime.now();


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
        title: Text('Dodaj zadanie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              buildSpace(),
              buildCustomTextFieldwithValidation( "Nazwa", "Podaj nazwę nowego zadania", _controllerName),
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
              buildCustomTextField("Opis", "Wprowadź opis swojego zadania", "Pole jest opcjonalne", controllerDesc),
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

  Widget buildCustomTextField(String label, String hint, String helper, TextEditingController control) {
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
            builder: (context) => UpgradeNotificationTask(widget.task)));
  }

  void goToLocalizationPickPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UpgradeLocalization()));
  }

  void goToGroupPickPage() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddGroup(widget.task)));
  }
//TODO problem z dodawaniem tasku
  void acceptAndValidate() {
    if (_formKey.currentState.validate()) {
      if (_date != "Nie wybrano daty" && _time != "Nie wybrano godziny rozpoczęcia") {
        dateColor = Colors.white;
        timeColor = Colors.white;
        setState(() {});
//                              widget.update.name = _controllerName.value.text;
//                              widget.update.endTime =
//                                  DateTime.parse("$_date $_time");

//                              TaskHelper.update(widget.update);
//                              Navigator.of(context).pop();

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
