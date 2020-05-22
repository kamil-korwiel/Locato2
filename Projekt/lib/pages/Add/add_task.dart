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
  ///Individual key for a Form widget, used to validate user's input.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ///Stores user's input in a TextFormField.
  TextEditingController _controllerName = TextEditingController();

  ///Stores user's input in a TextFormField.
  TextEditingController controllerDesc = TextEditingController();

  ///Stores color of a button displaying task's date.
  Color dateColor;

  ///Stores color of a button displaying task's time.
  Color timeColor;

  ///Default value is false, changes after user picks time and date.
  bool isNotificationEnabled;

  ///Default value is false, changes after user picks time.
  bool isTimeSelected;

  ///Default value is false, changes after user picks a date.
  bool isDateSelected;

  ///Default value is false, changes after  sets a localization.
  bool isLocalizationSelected;

  ///Stores task's date.
  DateTime _terminData;

  ///Stores task's time.
  DateTime _terminCzas;

  ///Stores current date;
  DateTime _today;

  ///An object of a class Task.
  Task _task;

  ///List of localizations created by user.
  List<Localization> listOfLocalization;

  ///List of groups created by user.
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

    dateColor = Colors.white;
    timeColor = Colors.white;

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
        leading:
            new IconButton(icon: Icon(Icons.arrow_back), onPressed: goBack),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              buildSpace(),
              buildCustomTextFieldwithValidation(
                  "Nazwa", "Podaj nazwę nowego zadania", _controllerName),
              buildSpace(),
              buildCustomButtonWithValidation(
                  dateColor,
                  (isDateSelected)
                      ? DateFormat("dd/MM/yyyy").format(_terminData)
                      : "Nie wybrano daty",
                  Icons.date_range,
                  datePick,
                  buildClearButton(clearDate)),
              buildSpace(),
              buildCustomButtonWithValidation(
                  timeColor,
                  (isTimeSelected)
                      ? DateFormat("hh:mm").format(_terminCzas)
                      : "Nie wybrano godziny",
                  Icons.access_time,
                  timePick,
                  buildClearButton(clearTime)),
              buildSpace(),
              buildCustomButton(
                  (_task.group.id == 0)
                      ? "Nie wybrano grupy"
                      : "${_task.group.name}",
                  Icons.account_circle,
                  goToGroupPickPage,
                  buildClearButton(clearGroup)),
              buildSpace(),
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

  ///Builds a row with two buttons inside of it.
  Widget buildButtonBar() {
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

  ///Builds a TextFormField with validation.
  Widget buildCustomTextFieldwithValidation(

      ///Stores text shown on the label of a TextFormField.
      String label,

      ///Stores text shown inside TextFormField as a hint.
      String hint,

      ///Used to control user's input.
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

  ///Builds a button responsible for clearing data.
  Widget buildClearButton(

      ///Receives a void function which is getting used after button pressed.
      GestureTapCallback onPressed) {
    return SizedBox(
      width: 30,
      child: IconButton(
        color: Colors.white,
        icon: Icon(Icons.clear),
        onPressed: onPressed,
      ),
    );
  }

  ///Builds a button responsible for clearing notification list created by user.
  Widget buildNotifiListClearButton(

      ///Receives a void function which is getting used after button pressed.
      GestureTapCallback onPressed) {
    return SizedBox(
      width: 30,
      child: IconButton(
        color: Colors.white,
        icon: Icon(Icons.clear),
        onPressed: (isNotificationEnabled) ? onPressed : null,
      ),
    );
  }

  ///Builds a TextFormField without validation.
  Widget buildCustomTextField(

      ///Stores text shown on the label of a TextFormField.
      String label,

      ///Stores text shown inside TextFormField as a hint.
      String hint,

      ///Stores text shown under TextFormField as an extra information.
      String helper,

      ///Used to control user's input.
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
              })),
      keyboardType: TextInputType.text,
    );
  }

  ///Builds a space between widgets in a column.
  Widget buildSpace() {
    return SizedBox(
      height: 10.0,
    );
  }

  ///Builds a button with validation.
  Widget buildCustomButtonWithValidation(

      ///Stores a color of text inside the button.
      ///Depends on validation result.
      Color textcolor,

      ///Stores text shown inside the button.
      String text,

      ///Stores icon shown before text inside the button.
      IconData icon,

      ///Accpets void function which is going to get used after button pressed.
      GestureTapCallback onPressed,

      ///Widget of a button responsible for clearing user's input.
      Widget clearButton) {
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

  ///Builds a button without validation.
  Widget buildCustomButton(

      ///Stores text shown inside the button.
      String text,

      ///Stores icon shown before text inside the button.
      IconData icon,

      ///Receives void function which is going to get used after button pressed.
      GestureTapCallback onPressed,

      ///Widget of a button responsible for clearing user's input.
      Widget clearButton) {
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

  ///Builds a button responsible for pick and clear notifications.
  Widget buildCustomNotificationButton(

      ///Stores text shown inside the button.
      String text,

      ///Receives void function which is going to get used after button pressed.
      IconData icon,

      ///Widget of a button responsible for clearing user's input.
      GestureTapCallback onPressed) {
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

  ///Builds a button for a button bar.
  Widget buildButtonBarTile(

      ///Stores text shown inside a button.
      String text,

      ///Stores color of a button.
      ///Changing on button press.
      Color color,

      ///Receives a void function which is getting used after button pressed.
      GestureTapCallback onPressed) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 5.0,
      color: new Color(0xFF333366),
      splashColor: color,
      child: Text("$text"),
      onPressed: onPressed,
    );
  }

  ///Erases date of a task which user already picked.
  void clearDate() {
    isDateSelected = false;
    isNotificationEnabled = false;
    setState(() {});
  }

  ///Erases time of a task which user already picked.
  void clearTime() {
    isTimeSelected = false;
    isNotificationEnabled = false;
    setState(() {});
  }

  ///Erases localization of a task which user already picked.
  void clearLocalization() {
    _task.localization = Localization(id: 0);
    setState(() {});
  }

  ///Erases group of a task which user already picked.
  void clearGroup() {
    _task.group = Group(id: 0);
    setState(() {});
  }

  ///Clears notification list of a task which user already picked.
  void clearNotifiList() {
    (_task.listNotifi).clear();
    setState(() {});
  }

  ///Builds interface responsible for picking a date.
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

  ///Builds interface responsible for picking a time.
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

  ///Takes user to previous page.
  void goBack() {
    Navigator.pop(context);
  }

  ///Takes user to notification pick page.
  void goToNotificationPickPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddNotificationTask(_task)));
  }

  ///Takes user to localization pick page.
  void goToLocalizationPickPage() {
    isLocalizationSelected = true;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddLocalization(_task, listOfLocalization)));
  }

  ///Takes user to group pick page.
  void goToGroupPickPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddGroup(_task, listOfGroup)));
  }

  ///Validates user's input.
  ///If accepted adds new Task.
  void acceptAndValidate() {
    if (_formKey.currentState.validate()) {
      _task.name = _controllerName.text;
      _task.description = controllerDesc.text;
      if (isTimeSelected && isDateSelected) {
        print("isTimeSelected: $isTimeSelected");
        print("isDateSelected: $isDateSelected");
        _task.endTime = DateTime(_terminData.year, _terminData.month,
            _terminData.day, _terminCzas.hour, _terminCzas.minute);
      } else {
        _task.listNotifi.clear();
      }

      List<Notifi> listN = List();
      listN.addAll(_task.listNotifi);

      for (Notifi element in listN) {
        if (_task.endTime.subtract(element.duration).isBefore(_today)) {
          print("delete: ${_task.endTime.subtract(element.duration)}");
          _task.listNotifi.remove(element);
        }
      }

      TaskHelper.add(_task).then((onvalue) {
        GroupHelper.addlist(listOfGroup);
        LocalizationHelper.addlist(listOfLocalization);
        Navigator.of(context).pop();
      });
    }
  }
}
