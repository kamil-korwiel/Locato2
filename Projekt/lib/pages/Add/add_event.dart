import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:Locato/Baza_danych/event_helper.dart';
import 'package:Locato/Classes/Event.dart';
import 'package:Locato/Classes/Notifi.dart';
import 'add_notification.dart';

class AddEvent extends StatefulWidget {
  @override
  AddEventState createState() => AddEventState();
  AddEvent();
}

class AddEventState extends State<AddEvent> {
  ///Stores user's input in a TextFormField.
  TextEditingController _controllerName;

  ///Stores user's input in a TextFormField.
  TextEditingController _controllerDesc;

  ///Individual key for a Form widget, used to validate user's input.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ///Stores current date;
  DateTime _today;

  ///Stores event's date.
  DateTime _date;

  ///Stores event's starting time.
  DateTime _time1;

  ///Stores event's end time.
  DateTime _time2;

  ///Stores color of a button displaying event's date.
  Color _dateColor;

  ///Stores color of a button displaying event's starting time.
  Color _time1Color;

  ///Stores color of a button displaying event's end time.
  Color _time2Color;

  ///Object of an Event class.
  Event _event;

  ///Default value is false, changes after user picks a date.
  bool isDateSelected;

  ///Default value is false, changes after user picks an event's starting time.
  bool isTime1Selected;

  ///Default value is false, changes after user picks an event's end time.
  bool isTime2Selected;

  @override
  void initState() {
    _event = Event();
    _today = DateTime.now();
    _controllerName = TextEditingController();
    _controllerDesc = TextEditingController();
    _dateColor = Colors.white;
    _time1Color = Colors.white;
    _time2Color = Colors.white;

    isDateSelected = false;
    isTime1Selected = false;
    isTime2Selected = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dodaj wydarzenie',
          style: TextStyle(color: Colors.white),
        ),

        ///Builds a go Back button.
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
              buildCustomTextFieldwithValidation("Nazwa",
                  "Wprowadź nazwę swojego wydarzenia", _controllerName),
              buildSpace(),
              buildCustomButtonWithValidation(
                  _dateColor,
                  (isDateSelected)
                      ? DateFormat("dd/MM/yyyy").format(_date)
                      : "Nie wybrano daty",
                  Icons.date_range,
                  datePick,
                  buildClearButton(clearDate)),
              buildSpace(),
              buildCustomButtonWithValidation(
                  _time1Color,
                  (isTime1Selected)
                      ? DateFormat("hh:mm").format(_time1)
                      : "Nie wybrano godziny rozpoczęcia",
                  Icons.access_time,
                  startTimePick,
                  buildClearButton(clearTime1)),
              buildSpace(),
              buildCustomButtonWithValidation(
                  _time2Color,
                  (isTime2Selected)
                      ? DateFormat("hh:mm").format(_time2)
                      : "Nie wybrano godziny zakończenia",
                  Icons.access_time,
                  endTimePick,
                  buildClearButton(clearTime2)),
              buildSpace(),
              buildCustomButton(
                  ((_event.listNotifi).isEmpty)
                      ? "Nie wybrano powiadomień"
                      : ((_event.listNotifi).length == 1)
                          ? "Wybrano ${(_event.listNotifi).length} powiadomienie"
                          : ((_event.listNotifi).length < 5)
                              ? "Wybrano ${(_event.listNotifi).length} powiadomienia"
                              : ((_event.listNotifi).length < 21)
                                  ? "Wybrano ${(_event.listNotifi).length} powiadomień"
                                  : ((_event.listNotifi).length % 10 == 2 ||
                                          (_event.listNotifi).length % 10 ==
                                              3 ||
                                          (_event.listNotifi).length % 10 == 4)
                                      ? "Wybrano ${(_event.listNotifi).length} powiadomienia"
                                      : "Wybrano ${(_event.listNotifi).length} powiadomień",
                  Icons.notifications,
                  goToNotificationPickPage,
                  buildClearButton(clearNotifiList)),
              buildSpace(),
              buildCustomTextField("Opis", "Wpisz opis swojego wydarzenia",
                  "Pole jest opcjonalne", _controllerDesc),
              buildSpace(),
              buildButtonBar(),
            ],
          ),
        ),
      ),
    );
  }

  ///Builds a TextFormField with a validation.
  ///Checks if user did fill the field.
  ///On empty field returns a message.
  Widget buildCustomTextFieldwithValidation(

      ///Stores text shown on the label of a TextFormField.
      String label,

      ///Stores text shown inside the TextFormField as a hint.
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
      color: Color(0xFF333366),
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
      color: Color(0xFF333366),
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
              "Dodaj", Colors.lightGreenAccent, acceptAndValidate),
        ],
        alignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        buttonMinWidth: 150);
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
      color: Color(0xFF333366),
      splashColor: color,
      child: Text("$text"),
      onPressed: onPressed,
    );
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

  ///Erases date of an event which user already picked.
  void clearDate() {
    isDateSelected = false;
    setState(() {});
  }

  ///Clears starting time of an event which user already picked.
  void clearTime1() {
    isTime1Selected = false;
    setState(() {});
  }

  ///Clears end time of an event which user already picked.
  void clearTime2() {
    isTime2Selected = false;
    setState(() {});
  }

  ///Clears list of notifications which user already picked.
  void clearNotifiList() {
    (_event.listNotifi).clear();
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
      _date = date;
      setState(() {});
    }, currentTime: new DateTime.now(), locale: LocaleType.pl);
  }

  ///Builds interface responsible for picking a starting time.
  void startTimePick() {
    DatePicker.showTimePicker(context,
        theme: DatePickerTheme(
          backgroundColor: Colors.black38,
          itemStyle: TextStyle(color: Colors.white),
          cancelStyle: TextStyle(color: Colors.red),
          doneStyle: TextStyle(color: Colors.green),
          containerHeight: 210.0,
        ),
        showSecondsColumn: false,
        showTitleActions: true, onConfirm: (time) {
      isTime1Selected = true;
      _time1 = time;
      setState(() {});
    }, currentTime: new DateTime.now(), locale: LocaleType.pl);
    setState(() {});
  }

  ///Builds interface responsible for picking an end time.
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
        showSecondsColumn: false, onConfirm: (time) {
      print('confirm $time');
      isTime2Selected = true;
      _time2 = time;
      setState(() {});
    },
        currentTime: DateTime.now().add(new Duration(hours: 1)),
        locale: LocaleType.pl);
    setState(() {});
  }

  ///Takes user to previous page.
  void goBack() {
    Navigator.pop(context);
  }

  ///Takes user to notification pick page.
  void goToNotificationPickPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddNotificationEvent(_event)));
  }

  ///Validates user's input.
  ///If accepted adds new Event.
  void acceptAndValidate() {
    if (isTime1Selected && isTime2Selected && _time2.isBefore(_time1)) {
      print("ERROR");
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
        if (isDateSelected && isTime1Selected && isTime2Selected) {
          _dateColor = Colors.white;
          _time1Color = Colors.white;
          _time2Color = Colors.white;

          _event.name = _controllerName.value.text;
          _event.description = _controllerDesc.text;
          _event.beginTime = DateTime(
              _date.year, _date.month, _date.day, _time1.hour, _time1.minute);
          _event.endTime = DateTime(
              _date.year, _date.month, _date.day, _time2.hour, _time2.minute);

          List<Notifi> listN = List();
          listN.addAll(_event.listNotifi);

          for (Notifi element in listN) {
            if (_event.beginTime.subtract(element.duration).isBefore(_today)) {
              print("delete: ${_event.beginTime.subtract(element.duration)}");
              _event.listNotifi.remove(element);
            }
          }

          EventHelper.add(_event);
          Navigator.of(context).pop();
        } else {
          if (isDateSelected == false)
            _dateColor = Colors.red;
          else
            _dateColor = Colors.white;
          if (isTime1Selected == false)
            _time1Color = Colors.red;
          else
            _time1Color = Colors.white;
          if (isTime2Selected == false)
            _time2Color = Colors.red;
          else
            _time2Color = Colors.white;
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
}
