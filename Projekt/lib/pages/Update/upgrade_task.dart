import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:pageview/Baza_danych/group_helper.dart';
import 'package:pageview/Baza_danych/localization_helper.dart';
import 'package:pageview/Baza_danych/task_helper.dart';
import 'package:pageview/Classes/Group.dart';
import 'package:pageview/Classes/Localization.dart';
import 'package:pageview/Classes/Task.dart';
import 'package:pageview/pages/Add/add_group.dart';
import 'package:pageview/pages/Add/add_localization.dart';
import 'package:pageview/pages/Update/upgrade_group.dart';
import 'package:pageview/pages/Update/upgrade_localization.dart';
import 'package:pageview/pages/Update/upgrade_notification.dart';



class UpgradeTask extends StatefulWidget {
  @override
  _UpgradeTaskState createState() => _UpgradeTaskState();


  Task task;
  UpgradeTask(this.task);
}

class _UpgradeTaskState extends State<UpgradeTask> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controllerName ;
  TextEditingController controllerDesc ;

  int id;
  String _time;
  String _group;
  String _notification;
  String _localization;
  Color dateColor;
  Color timeColor;
  String _date;


  List<Localization> listOfLocalization;
  List<Group> listOfGroup;

  DateTime _end;

  @override
  void initState() {
    print("start");
    listOfLocalization = List();
    listOfGroup = List();

    _date = DateFormat("yyyy-MM-dd").format(widget.task.endTime);
    _time = DateFormat("hh:mm").format(widget.task.endTime);
    _group = "Grupa" ;
    _notification = "Powiadomienia" ;
    _localization =  "Lokalizacja" ;

    _end =  widget.task.endTime;

    dateColor = Colors.white;
    timeColor = Colors.white;


     _controllerName = TextEditingController(text: widget.task.name);
      controllerDesc = TextEditingController(text: widget.task.description);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uaktualnij zadanie', style: TextStyle(color: Colors.white),),
        // tu kontrolujesz przycisk wstecz
        leading: new IconButton(icon: Icon(Icons.arrow_back), onPressed: onBackPressed),
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
            builder: (context) => UpgradeNotificationTask(widget.task)));
  }

  void goToLocalizationPickPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) =>  AddLocalization(widget.task,listOfLocalization)));
  }

  void goToGroupPickPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>  AddGroup(widget.task,listOfGroup)));
  }

  void acceptAndValidate() {
    if (_formKey.currentState.validate()) {


        widget.task.name = _controllerName.text;
        widget.task.description = controllerDesc.text;
        widget.task.endTime = DateFormat("yyyy-MM-dd hh:mm").parse(_date + " " + _time);
        //print(widget.task.name + " " + "Opis: " + widget.task.description+ "Group: "+ widget.task.idGroup.toString());
        print("Name: "+widget.task.name);
        print("EndTask: "+widget.task.endTime.toString());
        print("Desc: ${widget.task.description}");
        print("idGroup: ${widget.task.group.id}");
        print("Grupa: ${widget.task.group.name}");
        print("idLokalizacja: ${widget.task.localization.id}");
        print("Localization: ${widget.task.localization.name}");
        print("City: ${widget.task.localization.city}");
        print("Latitude: ${widget.task.localization.latitude}");
        print("Longitude: ${widget.task.localization.longitude}");

        widget.task.listNotifi.forEach((t) => print(t.duration));

        TaskHelper.update(widget.task);
        GroupHelper.addlist(listOfGroup);
        LocalizationHelper.addlist(listOfLocalization);
        Navigator.of(context).pop();

    }
  }

  void onBackPressed() {
    goBack();
  }

}
