import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:Locato/Baza_danych/group_helper.dart';
import 'package:Locato/Baza_danych/localization_helper.dart';
import 'package:Locato/Baza_danych/task_helper.dart';
import 'package:Locato/Classes/Group.dart';
import 'package:Locato/Classes/Localization.dart';
import 'package:Locato/Classes/Notifi.dart';
import 'package:Locato/Classes/Task.dart';

import 'add_group.dart';
import 'add_localization.dart';
import 'add_notification.dart';

_AddTaskState addTaskState;

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();

  AddTask();
}

class _AddTaskState extends State<AddTask> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController controllerDesc = TextEditingController();
  Color dateColor;
  Color timeColor;
  bool isNotificationEnabled;
  bool isTimeSelected;
  bool isDateSelected;
  bool isLocalizationSelected;
  DateTime _terminData;
  DateTime _terminCzas;
  DateTime _today;

  Task _task;
  List<Localization> listOfLocalization;
  List<Group> listOfGroup;

  @override
  void initState() {
    print("start");
    listOfLocalization = List();
    listOfGroup = List();
    _today = DateTime.now();

    isNotificationEnabled = false;
    isDateSelected = false;
    isTimeSelected = false;
    isLocalizationSelected = false;

    _task = Task(
      group: Group(id: 0),
      localization: Localization(id: 0),
      done: false,
    );

//     _terminData = DateTime();
//     _terminCzas = DateTime();

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
        title: Text(
          'Dodaj zadanie',
          style: TextStyle(color: Colors.white),
        ),
        // tu kontrolujesz przycisk wstecz
        leading: new IconButton(
            icon: Icon(Icons.arrow_back), onPressed: goBack),
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
                      ? DateFormat("hh:mm").format(_terminCzas)
                      : "Nie wybrano godziny",
                  Icons.access_time,
                  timePick,
                  buildClearButton(clearTime)),
              buildSpace(),
              //button grupa
              buildCustomButton(
                  (_task.group.id == 0)
                      ? "Nie wybrano grupy"
                      : "${_task.group.name}",
                  Icons.account_circle,
                  goToGroupPickPage,
                  buildClearButton(clearGroup)),
              buildSpace(),
              //button powiadomienia
              buildCustomNotificationButton(
                ((_task.listNotifi).isEmpty)
                    ? "Nie wybrano powiadomień"
                    : ((_task.listNotifi).length == 1)
                        ? "Wybrano ${(_task.listNotifi).length} powiadomienie"
                        : ((_task.listNotifi).length < 5)
                            ? "Wybrano ${(_task.listNotifi).length} powiadomienia"
                            : ((_task.listNotifi).length < 21)
                                ? "Wybrano ${(_task.listNotifi).length} powiadomień"
                                : ((_task.listNotifi).length % 10 == 2 ||
                                        (_task.listNotifi).length % 10 == 3 ||
                                        (_task.listNotifi).length % 10 == 4)
                                    ? "Wybrano ${(_task.listNotifi).length} powiadomienia"
                                    : "Wybrano ${(_task.listNotifi).length} powiadomień",
                Icons.notifications,
                goToNotificationPickPage,
              ),
              buildSpace(),
              buildCustomButton(
                  (_task.localization.id == 0)
                      ? "Nie wybrano lokalizacji"
                      : "${_task.localization.name}",
                  Icons.edit_location,
                  goToLocalizationPickPage,
                  buildClearButton(clearLocalization)),
              buildSpace(),
              buildCustomTextField("Opis", "Wprowadź opis swojego zadania",
                  "Pole jest opcjonalne", controllerDesc),
              buildSpace(),
              buildButtonBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtonBar(){
    return ButtonBar(
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
                  buttonMinWidth: 150);
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
    _task.localization = Localization(id: 0);
    setState(() {});
  }

  void clearGroup() {
    _task.group = Group(id: 0);
    setState(() {});
  }

  void clearNotifiList() {
    (_task.listNotifi).clear();
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
        MaterialPageRoute(builder: (context) => AddNotificationTask(_task)));
  }

  void goToLocalizationPickPage() {
    isLocalizationSelected = true;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddLocalization(_task, listOfLocalization)));
  }

  void goToGroupPickPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddGroup(_task, listOfGroup)));
  }

  void acceptAndValidate() {
    if (_formKey.currentState.validate()) {
        _task.name = _controllerName.text;
        _task.description = controllerDesc.text;
        //TODO zrobic zeby data nie byla obowiazkowa (ogolnie)
      if(isTimeSelected && isDateSelected) {
        print("isTimeSelected: $isTimeSelected");
        print("isDateSelected: $isDateSelected");
        _task.endTime = DateTime(_terminData.year, _terminData.month, _terminData.day, _terminCzas.hour, _terminCzas.minute);
      }else{
        _task.listNotifi.clear();
      }

//        if (isNotificationEnabled)
//          clearNotifiList(); // clear listy powiadomien jesli ktos usunie terminy i bedzie dodawal task

        //print(_task.name + " " + "Opis: " + _task.description+ "Group: "+ _task.idGroup.toString());
         print("");
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
//
       _task.listNotifi.forEach((t) => print(t.duration));

      List<Notifi> listN  = List();
      listN.addAll( _task.listNotifi);

      for(Notifi element in listN){
        if(_task.endTime.subtract(element.duration).isBefore(_today)){
          print("delete: ${_task.endTime.subtract(element.duration)}");
          _task.listNotifi.remove(element);
        }
      }
//
        TaskHelper.add(_task).then((onvalue){
          GroupHelper.addlist(listOfGroup);
          LocalizationHelper.addlist(listOfLocalization);
          Navigator.of(context).pop();
        });

//



    }
  }


}
