import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:intl/intl.dart';
import 'package:pageview/Baza_danych/group_helper.dart';
import 'package:pageview/Baza_danych/localization_helper.dart';
import 'package:pageview/Baza_danych/notification_helper.dart';
import 'package:pageview/Baza_danych/task_helper.dart';
import 'package:pageview/Classes/Group.dart';
import 'package:pageview/Classes/Localization.dart';
import 'package:pageview/Classes/Task.dart';
import 'package:pageview/pages/Add/add_group.dart';
import 'package:pageview/pages/Add/add_localization.dart';
import 'package:pageview/pages/Add/add_notification.dart';



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
  Color dateColor;
  Color timeColor;
  bool isNotificationEnabled;
  bool isTimeSelected;
  bool isDateSelected;
  bool isLocalizationSelected;
  DateTime _terminData;
  DateTime _terminCzas;

  List<Localization> listOfLocalization;
  List<Group> listOfGroup;

  @override
  void initState() {
    print("start");
    listOfLocalization = List();
    listOfGroup = List();

    _controllerName = TextEditingController(text: widget.task.name);
     controllerDesc = TextEditingController(text: widget.task.description);

    if(widget.task.endTime == null ) {
      isNotificationEnabled = false ;
      isDateSelected = false ;
      isTimeSelected = false ;

    }else{
      isNotificationEnabled = true ;
      isDateSelected = true ;
      isTimeSelected = true ;
      _terminData = DateTime(widget.task.endTime.year,widget.task.endTime.month,widget.task.endTime.day);
      _terminCzas =  DateTime(0,0,0,widget.task.endTime.hour,widget.task.endTime.minute);
      _downloadData();
    }

    isLocalizationSelected = widget.task.localization.id == 0 ? false : true;

//     _terminData = DateTime();
//     _terminCzas = DateTime();

    dateColor = Colors.white;
    timeColor = Colors.white;

    super.initState();
  }

  void _downloadData() {
    NotifiHelper.listsTaskID(widget.task.id).then((onList) {
      if (onList != null) {
        widget.task.listNotifi.addAll(onList);
        setState(() {});
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dodaj zadanie',
          style: TextStyle(color: Colors.white),
        ),
        // tu kontrolujesz przycisk wstecz
        leading: new IconButton(
            icon: Icon(Icons.arrow_back), onPressed: onBackPressed),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              buildSpace(),
              //textfield z nazwa
              buildCustomTextFieldwithValidation(
                  "Nazwa", "Podaj nazwę nowego zadania", _controllerName),
              buildSpace(),
              //button z data
              buildCustomButtonWithValidation(
                  dateColor,
                  (isDateSelected)
                      ? DateFormat("dd/MM/yyyy").format(_terminData)
                      : "Nie wybrano daty",
                  Icons.date_range,
                  datePick,
                  buildClearButton(clearDate)),
              buildSpace(),
              //button z godzina
              buildCustomButtonWithValidation(
                  timeColor,
                  (isTimeSelected)
                      ? DateFormat("HH:mm").format(_terminCzas)
                      : "Nie wybrano godziny",
                  Icons.access_time,
                  timePick,
                  buildClearButton(clearTime)),
              buildSpace(),
              //button grupa
              buildCustomButton(
                  (widget.task.group.id == 0)
                      ? "Nie wybrano grupy"
                      : "${widget.task.group.name}",
                  Icons.account_circle,
                  goToGroupPickPage,
                  buildClearButton(clearGroup)),
              buildSpace(),
              //button powiadomienia
              buildCustomNotificationButton(
                ((widget.task.listNotifi).isEmpty)
                    ? "Nie wybrano powiadomień"
                    : ((widget.task.listNotifi).length == 1)
                    ? "Wybrano ${(widget.task.listNotifi).length} powiadomienie"
                    : ((widget.task.listNotifi).length < 5)
                    ? "Wybrano ${(widget.task.listNotifi).length} powiadomienia"
                    : ((widget.task.listNotifi).length < 21)
                    ? "Wybrano ${(widget.task.listNotifi).length} powiadomień"
                    : ((widget.task.listNotifi).length % 10 == 2 ||
                    (widget.task.listNotifi).length % 10 == 3 ||
                    (widget.task.listNotifi).length % 10 == 4)
                    ? "Wybrano ${(widget.task.listNotifi).length} powiadomienia"
                    : "Wybrano ${(widget.task.listNotifi).length} powiadomień",
                Icons.notifications,
                goToNotificationPickPage,
              ),
              buildSpace(),
              buildCustomButton(
                  (widget.task.localization.id == 0)
                      ? "Nie wybrano lokalizacji"
                      : "${widget.task.localization.name}",
                  Icons.edit_location,
                  goToLocalizationPickPage,
                  buildClearButton(clearLocalization)),
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

  Widget buildClearButton(GestureTapCallback onPressed) {
    return SizedBox(
      width: 30,
      child: IconButton(
        color: Colors.white,
        icon: Icon(Icons.clear),
        onPressed: onPressed,
      ),
    );
  }

  Widget buildNotifiListClearButton(GestureTapCallback onPressed) {
    return SizedBox(
      width: 30,
      child: IconButton(
        color: Colors.white,
        icon: Icon(Icons.clear),
        onPressed: (isNotificationEnabled)? onPressed : null,
      ),
    );
  }

  Widget buildCustomTextField(
      String label, String hint, String helper, TextEditingController control) {
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

  Widget buildCustomButtonWithValidation(Color textcolor, String text,
      IconData icon, GestureTapCallback onPressed, Widget clearButton) {
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
            clearButton,
          ],
        ),
      ),
      color: new Color(0xFF333366),
    );
  }

  Widget buildCustomButton(String text, IconData icon,
      GestureTapCallback onPressed, Widget clearButton) {
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
                ),
                Text(
                  " $text",
                  style: TextStyle(),
                ),
              ],
            ),
            clearButton,
          ],
        ),
      ),
      color: new Color(0xFF333366),
    );
  }

  Widget buildCustomNotificationButton(
      String text, IconData icon, GestureTapCallback onPressed) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 5.0,
      onPressed: (isNotificationEnabled) ? onPressed : null,
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
                  isNotificationEnabled
                      ? " $text"
                      : "Ustal temin by wybrać powiadomienia",
                  style: TextStyle(),
                ),
              ],
            ),
            buildNotifiListClearButton(clearNotifiList),
          ],
        ),
      ),
      color: new Color(0xFF333366),
    );
  }

  Widget buildButtonBarTile(
      String text, Color color, GestureTapCallback onPressed) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 5.0,
      color: new Color(0xFF333366),
      splashColor: color,
      child: Text("$text"),
      onPressed: onPressed,
    );
  }

  void clearDate() {
    isDateSelected = false;
    isNotificationEnabled = false;
    setState(() {});
  }

  void clearTime() {
    isTimeSelected = false;
    isNotificationEnabled = false;
    setState(() {});
  }

  void clearLocalization() {
    widget.task.localization = Localization(id: 0);
    setState(() {});
  }

  void clearGroup() {
    widget.task.group = Group(id: 0);
    setState(() {});
  }

  void clearNotifiList() {
    (widget.task.listNotifi).clear();
    setState(() {});
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
          isDateSelected = true;
          if (isDateSelected && isTimeSelected) isNotificationEnabled = true;
          _terminData = date;
          setState(() {});
        }, currentTime: DateTime.now(), locale: LocaleType.pl);
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
          isTimeSelected = true;
          if (isDateSelected && isTimeSelected) isNotificationEnabled = true;
          _terminCzas = time;
          setState(() {});
        }, currentTime: DateTime.now(), locale: LocaleType.pl);
  }

  void goBack() {
    Navigator.pop(context);
  }

  void goToNotificationPickPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddNotificationTask(widget.task)));
  }

  void goToLocalizationPickPage() {
    isLocalizationSelected = true;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddLocalization(widget.task, listOfLocalization)));
  }

  void goToGroupPickPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddGroup(widget.task, listOfGroup)));
  }

  void acceptAndValidate() {
    if (_formKey.currentState.validate()) {
      widget.task.name = _controllerName.text;
      widget.task.description = controllerDesc.text;
      if(isTimeSelected && isDateSelected) {
        print("isTimeSelected: $isTimeSelected");
        print("isDateSelected: $isDateSelected");
       // widget.task.endTime = DateTime(_terminData.year, _terminData.month, _terminData.day, _terminCzas.hour, _terminCzas.minute);
      }

//        if (isNotificationEnabled)
//          clearNotifiList(); // clear listy powiadomien jesli ktos usunie terminy i bedzie dodawal task

      //print(widget.task.name + " " + "Opis: " + widget.task.description+ "Group: "+ widget.task.idGroup.toString());
      print("");
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
//
//        widget.task.listNotifi.forEach((t) => print(t.duration));
//
      TaskHelper.update(widget.task);
      GroupHelper.addlist(listOfGroup);
      LocalizationHelper.addlist(listOfLocalization);
//
      Navigator.of(context).pop();


    }
  }

  void onBackPressed() {
    goBack();
  }

  void selectedGroup(String selectedGroup) {
    setState(() {});
  }

}
