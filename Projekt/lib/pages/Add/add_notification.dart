import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:Locato/Classes/Event.dart';
import 'package:Locato/Classes/Notifi.dart';
import 'package:Locato/Classes/Task.dart';
import 'button_notification_list_builder_widget.dart';

class AddNotificationTask extends StatefulWidget {
  @override
  _AddNotificationTaskState createState() => _AddNotificationTaskState();

  ///An object of a Task class.
  Task task;
  AddNotificationTask(this.task);
}

class _AddNotificationTaskState extends State<AddNotificationTask> {
  ///Stores user's input in a TextFormField.
  final TextEditingController _text = new TextEditingController();

  ///Individual key for a Form widget, used to validate user's input.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ///List of notifications created by user.
  List<Notifi> _notifilist = [];

  ///Stores duration.
  var duration;

  ///Stores minutes.
  int minuty;

  ///Stores hours.
  int godziny;

  ///Stores days.
  int dni;

  ///Stores String used to display a notification on a button.
  String name;

  @override
  void initState() {
    _notifilist = widget.task.listNotifi;
    dni = 0;
    godziny = 0;
    minuty = 1;

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Dodaj powiadomienie", style: TextStyle(color: Colors.white)),
        leading:
            new IconButton(icon: Icon(Icons.arrow_back), onPressed: goBack),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                buildPickerNameTile("Dni"),
                SizedBox(width: 10),
                buildPickerNameTile("Godziny"),
                SizedBox(width: 10),
                buildPickerNameTile("Minuty"),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.transparent),
                color: Colors.transparent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(child: buildNumberPicker1(0, 30)),
                  SizedBox(width: 10),
                  Flexible(child: buildNumberPicker2(0, 24)),
                  SizedBox(width: 10),
                  Flexible(child: buildNumberPicker3(1, 60)),
                ],
              ),
            ),
            buildSpace(),
            buildCustomButton("Dodaj", validateAndAdd),
            buildSpace(),
            ListNotifi(_notifilist),
            buildSpace(),
            buildCustomButton("Potwierdź", confirm),
          ])),
    );
  }

  ///Builds names above the pickers to show if user sets a day, hour or minute.
  Widget buildPickerNameTile(

      ///Stores text displayed on a tile above the picker.
      String _value) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Color(0xFF333366)),
          color: Color(0xFF333366),
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("$_value"),
          ],
        ),
      ),
    );
  }

  ///Builds interface responsible for picking amount of days.
  Widget buildNumberPicker1(

      ///Stores minimum value of a picker.
      int _min,

      ///Stores maximum value of a picker.
      int _max) {
    return NumberPicker.integer(
        listViewWidth: double.infinity,
        itemExtent: 40,
        initialValue: dni,
        minValue: _min,
        maxValue: _max,
        zeroPad: true,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.indigo),
        ),
        highlightSelectedValue: true,
        onChanged: (value) => setState(() => dni = value));
  }

  ///Builds interface responsible for picking amount of hours.
  Widget buildNumberPicker2(

      ///Stores minimum value of a picker.
      int _min,

      ///Stores maximum value of a picker.
      int _max) {
    return NumberPicker.integer(
        listViewWidth: double.infinity,
        itemExtent: 40,
        initialValue: godziny,
        minValue: _min,
        maxValue: _max,
        zeroPad: true,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.indigo),
        ),
        highlightSelectedValue: true,
        onChanged: (value) => setState(() => godziny = value));
  }

  ///Builds interface responsible for picking amount of minutes.
  Widget buildNumberPicker3(

      ///Stores minimum value of a picker.
      int _min,

      ///Stores maximum value of a picker.
      int _max) {
    return NumberPicker.integer(
        listViewWidth: double.infinity,
        itemExtent: 40,
        initialValue: minuty,
        minValue: _min,
        maxValue: _max,
        zeroPad: true,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.indigo),
        ),
        highlightSelectedValue: true,
        onChanged: (value) => setState(() => minuty = value));
  }

  ///Builds a button without validation.
  Widget buildCustomButton(

      ///Stores text shown inside the button.
      String text,

      ///Receives void function which is going to get used after button pressed.
      GestureTapCallback onPressed) {
    return RaisedButton(
      color: Color(0xFF333366),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.transparent,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        '$text',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  ///Builds a space between widgets in a column.
  Widget buildSpace() {
    return SizedBox(
      height: 10.0,
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
            fillColor: Color(0xFF333366),
            enabledBorder: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.white),
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
            hintStyle: TextStyle(color: Colors.white),
            suffixIcon: IconButton(
                icon: Icon(Icons.clear, color: Colors.white),
                onPressed: () {
                  control.clear();
                })),
        keyboardType: TextInputType.number,
        validator: (val) {
          if (val.isEmpty) {
            return 'Pole nie może być puste!';
          }
          return null;
        });
  }

  ///Validates user's input.
  ///If accepted adds new notification to a list.
  void validateAndAdd() {
    bool notthesame = true;

    duration = new Duration(days: dni, hours: godziny, minutes: minuty);
    name = "Powiadomienie ";
    if (dni != 0) {
      name += "$dni" + "d,";
    }
    if (godziny != 0) {
      name += "$godziny" + "h ,";
    }
    name += "$minuty" + "m przed";

    _notifilist.forEach((n) {
      if (n.duration.compareTo(duration) == 0) {
        notthesame = false;
      }
    });
    if (notthesame) {
      _notifilist.add(Notifi(duration: duration));
    }
    setState(() {});
  }

  ///Takes user to previous page.
  void goBack() {
    Navigator.pop(context);
  }

  ///Adds created list to a task.
  void confirm() {
    widget.task.listNotifi = _notifilist;
    Navigator.pop(context);
  }
}

class AddNotificationEvent extends StatefulWidget {
  @override
  _AddNotificationEventState createState() => _AddNotificationEventState();

  Event event;
  AddNotificationEvent(this.event);
}

class _AddNotificationEventState extends State<AddNotificationEvent> {
  ///Stores user's input in a TextFormField.
  final TextEditingController _text = new TextEditingController();

  ///Individual key for a Form widget, used to validate user's input.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ///List of notifications created by user.
  List<Notifi> _notifilist = [];

  ///Stores duration.
  var duration;

  ///Stores minutes.
  int minuty;

  ///Stores hours.
  int godziny;

  ///Stores days.
  int dni;

  ///Stores String used to display a notification on a button.
  String name;

  @override
  void initState() {
    _notifilist = widget.event.listNotifi;
    dni = 0;
    godziny = 0;
    minuty = 1;

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Dodaj powiadomienie", style: TextStyle(color: Colors.white)),
        leading:
            new IconButton(icon: Icon(Icons.arrow_back), onPressed: goBack),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                buildPickerNameTile("Dni"),
                SizedBox(width: 10),
                buildPickerNameTile("Godziny"),
                SizedBox(width: 10),
                buildPickerNameTile("Minuty"),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.transparent),
                color: Colors.transparent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(child: buildNumberPicker1(0, 30)),
                  SizedBox(width: 10),
                  Flexible(child: buildNumberPicker2(0, 24)),
                  SizedBox(width: 10),
                  Flexible(child: buildNumberPicker3(1, 60)),
                ],
              ),
            ),
            buildSpace(),
            buildCustomButton("Dodaj", validateAndAdd),
            buildSpace(),
            ListNotifi(_notifilist),
            buildSpace(),
            buildCustomButton("Potwierdź", confirm)
          ])),
    );
  }

  ///Builds names above the pickers to show if user sets a day, hour or minute.
  Widget buildPickerNameTile(

      ///Stores text displayed on a tile above the picker.
      String _value) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Color(0xFF333366)),
          color: Color(0xFF333366),
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("$_value"),
          ],
        ),
      ),
    );
  }

  ///Builds interface responsible for picking amount of days.
  Widget buildNumberPicker1(

      ///Stores minimum value of a picker.
      int _min,

      ///Stores maximum value of a picker.
      int _max) {
    return NumberPicker.integer(
        listViewWidth: double.infinity,
        itemExtent: 40,
        initialValue: dni,
        minValue: _min,
        maxValue: _max,
        zeroPad: true,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.indigo),
        ),
        highlightSelectedValue: true,
        onChanged: (value) => setState(() => dni = value));
  }

  ///Builds interface responsible for picking amount of days.
  Widget buildNumberPicker2(

      ///Stores minimum value of a picker.
      int _min,

      ///Stores maximum value of a picker.
      int _max) {
    return NumberPicker.integer(
        listViewWidth: double.infinity,
        itemExtent: 40,
        initialValue: godziny,
        minValue: _min,
        maxValue: _max,
        zeroPad: true,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.indigo),
        ),
        highlightSelectedValue: true,
        onChanged: (value) => setState(() => godziny = value));
  }

  ///Builds interface responsible for picking amount of days.
  Widget buildNumberPicker3(

      ///Stores minimum value of a picker.
      int _min,

      ///Stores maximum value of a picker.
      int _max) {
    return NumberPicker.integer(
        listViewWidth: double.infinity,
        itemExtent: 40,
        initialValue: minuty,
        minValue: _min,
        maxValue: _max,
        zeroPad: true,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.indigo),
        ),
        highlightSelectedValue: true,
        onChanged: (value) => setState(() => minuty = value));
  }

  ///Builds a button without validation.
  Widget buildCustomButton(

      ///Stores text shown inside the button.
      String text,

      ///Receives void function which is going to get used after button pressed.
      GestureTapCallback onPressed) {
    return RaisedButton(
      color: Color(0xFF333366),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.transparent,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        '$text',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  ///Builds a space between widgets in a column.
  Widget buildSpace() {
    return SizedBox(
      height: 10.0,
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
            fillColor: Color(0xFF333366),
            enabledBorder: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.white),
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
            hintStyle: TextStyle(color: Colors.white),
            suffixIcon: IconButton(
                icon: Icon(Icons.clear, color: Colors.white),
                onPressed: () {
                  control.clear();
                })),
        keyboardType: TextInputType.number,
        validator: (val) {
          if (val.isEmpty) {
            return 'Pole nie może być puste!';
          }
          return null;
        });
  }

  ///Validates user's input.
  ///If accepted adds new notification to a list.
  void validateAndAdd() {
    bool notthesame = true;

    duration = new Duration(days: dni, hours: godziny, minutes: minuty);
    name = "Powiadomienie ";
    if (dni != 0) {
      name += "$dni" + "d,";
    }
    if (godziny != 0) {
      name += "$godziny" + "h ,";
    }
    name += "$minuty" + "m przed";

    _notifilist.forEach((n) {
      if (n.duration.compareTo(duration) == 0) {
        notthesame = false;
      }
    });
    if (notthesame) {
      _notifilist.add(Notifi(duration: duration));
    }
    setState(() {});
  }

  ///Takes user to previous page.
  void goBack() {
    Navigator.pop(context);
  }

  ///Adds created list to an event.
  void confirm() {
    widget.event.listNotifi = _notifilist;
    Navigator.pop(context);
  }
}
