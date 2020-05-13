import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:pageview/Classes/Event.dart';
import 'package:pageview/Classes/Notifi.dart';
import 'package:pageview/Classes/Task.dart';
import 'button_notification_list_builder_widget.dart';

class AddNotificationTask extends StatefulWidget {
  @override
  _AddNotificationTaskState createState() => _AddNotificationTaskState();

  Task task;
  AddNotificationTask(this.task);
}

class _AddNotificationTaskState extends State<AddNotificationTask> {
  final TextEditingController _text = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Notifi> _notifilist = [];
  var duration;
  int minuty;
  int godziny;
  int dni;
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
        // tu kontrolujesz przycisk wstecz
        leading: new IconButton(
            icon: Icon(Icons.arrow_back), onPressed: onBackPressed),
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
            buildcustomButton("Dodaj", validateAndAdd),
            buildSpace(),
            ListNotifi(_notifilist),
            buildSpace(),
            buildcustomButton("Potwierdź", confirm)
          ])),
    );
  }

  Widget buildPickerNameTile(String _value) {
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

  Widget buildNumberPicker1(int _min, int _max) {
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

  Widget buildNumberPicker2(int _min, int _max) {
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

  Widget buildNumberPicker3(int _min, int _max) {
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

  Widget buildcustomButton(String text, void action()) {
    return RaisedButton(
      color: Color(0xFF333366),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.transparent,
        ),
      ),
      onPressed: () {
        action();
      },
      child: Text(
        '$text',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildSpace() {
    return SizedBox(
      height: 10.0,
    );
  }

  Widget buildCustomTextFieldwithValidation(
      String label, String hint, TextEditingController control) {
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
//    }
//      print(
//          "id:${_notifilist.last.id} idEvent:${_notifilist.last.idEvent} idTask:${_notifilist.last.idTask} time: ${_notifilist.last.duration.toString()}");

    setState(() {});
  }

  void goBack() {
    Navigator.pop(context);
  }

  void onBackPressed() {
    goBack();
  }

  void confirm() {
//    List<Notifi> noti = List();
//    for (Notifi n in _notifilist) {
//      if (n.id == null) {
//        noti.add(n);
//      }
//    }

    widget.task.listNotifi = _notifilist;
    Navigator.pop(context);
  }
}

class AddNotificationEvent extends StatefulWidget {
  @override
  _AddNotificationEventState createState() => _AddNotificationEventState();

  Event event;

  AddNotificationEvent(this.event);

// Notification notification;
// AddNotification({this.notification});

}

class _AddNotificationEventState extends State<AddNotificationEvent> {
  final TextEditingController _text = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _notifilist = widget.event.listNotifi;
    dni = 0;
    godziny = 0;
    minuty = 1;
    super.initState();
  }

  List<Notifi> _notifilist = [];
  var duration;
  int minuty;
  int godziny;
  int dni;
  String name;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Dodaj powiadomienie", style: TextStyle(color: Colors.white)),
        // tu kontrolujesz przycisk wstecz
        leading: new IconButton(
            icon: Icon(Icons.arrow_back), onPressed: onBackPressed),
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
            buildcustomButton("Dodaj", validateAndAdd),
            buildSpace(),
            ListNotifi(_notifilist),
            buildSpace(),
            buildcustomButton("Potwierdź", confirm)
          ])),
    );
  }

  Widget buildPickerNameTile(String _value) {
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

  Widget buildNumberPicker1(int _min, int _max) {
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

  Widget buildNumberPicker2(int _min, int _max) {
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

  Widget buildNumberPicker3(int _min, int _max) {
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

  Widget buildcustomButton(String text, void action()) {
    return RaisedButton(
      color: Color(0xFF333366),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.white,
        ),
      ),
      elevation: 5.0,
      onPressed: () {
        action();
      },
      child: Text(
        '$text',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildSpace() {
    return SizedBox(
      height: 10.0,
    );
  }

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
//    }
//      print(
//          "id:${_notifilist.last.id} idEvent:${_notifilist.last.idEvent} idTask:${_notifilist.last.idTask} time: ${_notifilist.last.duration.toString()}");

    setState(() {});
  }

  void goBack() {
    Navigator.pop(context);
  }

  void onBackPressed() {
    goBack();
  }

  void confirm() {
    widget.event.listNotifi = _notifilist;

    Navigator.pop(context);
  }
}
