//import 'dart:html';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:pageview/Baza_danych/database_helper.dart';
import 'package:pageview/Baza_danych/event_helper.dart';
import 'package:pageview/Baza_danych/notification_helper.dart';
import 'package:pageview/Classes/Event.dart';
import 'package:pageview/Classes/Notifi.dart';
import 'package:pageview/pages/Add/add_group.dart';
import 'package:pageview/pages/Add/add_localization.dart';
import 'package:pageview/pages/Add/add_notification.dart';
import 'package:pageview/pages/Update/upgrade_notification.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class UpgradeEvent extends StatefulWidget {
  @override
  _UpgradeEventState createState() => _UpgradeEventState();

  Event event;

  UpgradeEvent({this.event});
}

class _UpgradeEventState extends State<UpgradeEvent> {
  TextEditingController _controllerName;
  TextEditingController _controllerDesc;

  String _name;
  String _description;
  String _date;
  String _time1;
  String _time2;
  String _notification;
  DateTime _start;
  DateTime _end;
  Color _dateColor;
  Color _time1Color;
  Color _time2Color;


  @override
  void initState() {
    _name = widget.event.name;
    _description = widget.event.description;
    _date = DateFormat("yyyy-MM-dd").format(widget.event.beginTime);
    _time1 = DateFormat("HH:mm").format(widget.event.beginTime);
    _time2 = DateFormat("HH:mm").format(widget.event.endTime);
    _notification = "Powiadomienia";
    _start = widget.event.beginTime;
    _end = widget.event.endTime;

    _dateColor = Colors.white;
    _time1Color = Colors.white;
    _time2Color = Colors.white;

    _controllerName = TextEditingController(text: _name);
    _controllerDesc = TextEditingController(text: _description);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Uaktualnij wydarzenie', style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              buildCustomTextFieldwithValidation("Nazwa",
                  "Wprowadź nazwę swojego wydarzenia", _controllerName),
              buildSpace(),
              buildCustomButtonWithValidation(
                  _dateColor, _date, Icons.date_range, datePick),
              buildSpace(),
              buildCustomButtonWithValidation(
                  _time1Color, _time1, Icons.access_time, startTimePick),
              buildSpace(),
              buildCustomButtonWithValidation(
                  _time2Color, _time2, Icons.access_time, endTimePick),
              buildSpace(),
              buildCustomButton(
                  _notification, Icons.notifications, goToNotificationPickPage),
              buildSpace(),
              buildCustomTextField("Opis", "Wpisz opis swojego wydarzenia",
                  "Pole jest opcjonalne", _controllerDesc),
              buildSpace(),
              new ButtonBar(
                  children: [
                    buildButtonBarTile("Anuluj", Colors.red, goBack),
                    SizedBox(
                      width: 30,
                    ),
                    buildButtonBarTile(
                        "Dodaj", Colors.lightGreenAccent, acceptAndValidate),
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

  Widget buildCustomTextField(String label, String hint, String helper,
      TextEditingController control) {
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
              })
      ),
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
        color: Color(0xFF333366),
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
        color: Color(0xFF333366),
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
        maxTime: DateTime(2025, 12, 31),
        onConfirm: (date) {
          /// tu jest  save data
          _date = new DateFormat("yyyy-MM-dd").format(date);
          setState(() {});
        },
        currentTime: _start,
        locale: LocaleType.pl);
  }

  void startTimePick() {
    DatePicker.showTimePicker(context,
        theme: DatePickerTheme(
          backgroundColor: Colors.black38,
          itemStyle: TextStyle(color: Colors.white),
          cancelStyle: TextStyle(color: Colors.amber[400]),
          doneStyle: TextStyle(color: Colors.green[400]),
          containerHeight: 210.0,
        ),
        showSecondsColumn: false,
        showTitleActions: true,
        onConfirm: (time) {
         // print('confirm $time');
          _start = time;
          _time1 = new DateFormat("HH:mm").format(time);
          setState(() {});
        },
        currentTime: _start,
        locale: LocaleType.pl);
    setState(() {});
  }

  void endTimePick() {
    DatePicker.showTimePicker(context,
        theme: DatePickerTheme(
          backgroundColor: Colors.black38,
          itemStyle: TextStyle(color: Colors.white),
          cancelStyle: TextStyle(color: Colors.amber[400]),
          doneStyle: TextStyle(color: Colors.green[400]),
          containerHeight: 210.0,
        ),
        showTitleActions: true,
        showSecondsColumn: false,
        onConfirm: (time) {
         // print('confirm $time');
          _end = time;
          _time2 = new DateFormat("HH:mm").format(time);
          setState(() {});
        },
        currentTime: _end,
        locale: LocaleType.pl);
    setState(() {});
  }

  void goBack() {
    Navigator.pop(context);
  }

  void goToNotificationPickPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UpgradeNotificationEvent(widget.event)));
  }

  void acceptAndValidate() {
    if (_end.isBefore(_start)) {
    //  print("ERROR");
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Błąd danych"),
              content:
              Text("Godzina zakończenia nie może być przed rozpoczęciem."),
            );
          });
    } else {
      if (_formKey.currentState.validate()) {
        widget.event.name = _controllerName.value.text;
        widget.event.description = _controllerDesc.value.text;

        DateTime t1 = DateTime.parse("$_date $_time1");
        DateTime t2 = DateTime.parse("$_date $_time2");
        widget.event.beginTime = t1;
        widget.event.endTime = t2;

        EventHelper.update(widget.event);
        Navigator.of(context).pop();
      }
    }
  }
}