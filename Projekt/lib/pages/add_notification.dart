import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pageview/Baza_danych/notification_helper.dart';
import 'package:pageview/Classes/Event.dart';
import 'package:pageview/Classes/Notifi.dart';
import 'package:pageview/Classes/Task.dart';
import 'package:pageview/List/button_notification_list_builder_widget.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pageview/Classes/Notification.dart';

class AddNotificationTask extends StatefulWidget {
  @override
  _AddNotificationTaskState createState() => _AddNotificationTaskState();

  Task task;
  AddNotificationTask(this.task);
}

class _AddNotificationTaskState extends State<AddNotificationTask> {
  final TextEditingController _text = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.task.id != null) {
      NotifiHelper.listsTaskID(widget.task.id).then((onList) {
        if (onList != null) {
          _notifilist = onList;
          print(_notifilist);
          print(onList);
          if (widget.task.listNotifi.isNotEmpty) {
            _notifilist.addAll(widget.task.listNotifi);
          }
          setState(() {});
        }
      });
    } else {
      if (widget.task.listNotifi.isNotEmpty) {
        _notifilist = widget.task.listNotifi;
      }
    }

    super.initState();
  }

  List<Notifi> _notifilist = [];
  List<String> unitlist = ["Minuty", "Godziny", "Dni"];
  String holder = "Minuty";
  String _value = "Minuty";
  var duration;
  int czas;
  String name;

  void getDropDownItem() {
    setState(() {
      holder = _value;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dodaj powiadomienie",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(children: <Widget>[
            new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                buildCustomDropdownButton(),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: Form(
                    key: _formKey,
                    child: buildCustomTextFieldwithValidation(
                        holder, "Podaj wartość", _text),
                  ),
                ),
              ],
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

  Widget buildcustomButton(String text, void action()) {
    return RaisedButton(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.white,
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

  Widget buildCustomDropdownButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.white),
      ),
      child: DropdownButton<String>(
        value: _value,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        onChanged: (String data) {
          setState(() {
            _value = data;
            getDropDownItem();
          });
        },
        items: unitlist.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget buildCustomTextFieldwithValidation(
      String label, String hint, TextEditingController control) {
    return TextFormField(
        controller: control,
        decoration: new InputDecoration(
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
        keyboardType: TextInputType.text,
        validator: (val) {
          if (val.isEmpty) {
            return 'Pole nie może być puste!';
          }
          return null;
        });
  }

  void validateAndAdd() {
    if (_formKey.currentState.validate()) {
      if (holder == "Minuty") {
        czas = int.parse(_text.text);
        duration = new Duration(minutes: czas);
        name = "$czas minut przed";
      }
      if (holder == "Godziny") {
        czas = int.parse(_text.text);
        duration = new Duration(hours: czas);
        name = "$czas godzin przed";
      }
      if (holder == "Dni") {
        czas = int.parse(_text.text);
        duration = new Duration(days: czas);
        name = "$czas dni przed";
      }
      _notifilist.add(Notifi(duration: duration));
      setState(() {});
    }
  }

  void confirm() {
    List<Notifi> noti = List();

    for (Notifi n in _notifilist) {
      if (n.id == null) {
        noti.add(n);
      }
    }
    widget.task.listNotifi = noti;
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
    if (widget.event.id != null) {
      NotifiHelper.listsEventID(widget.event.id).then((onList) {
        if (onList != null) {
          _notifilist = onList;
          print(_notifilist);
          print(onList);
          if (widget.event.listNotifi.isNotEmpty) {
            _notifilist.addAll(widget.event.listNotifi);
          }
          setState(() {});
        }
      });
    } else {
      if (widget.event.listNotifi.isNotEmpty) {
        _notifilist = widget.event.listNotifi;
      }
    }

    super.initState();
  }

  List<Notifi> _notifilist = [];
  List<String> unitlist = ["Minuty", "Godziny", "Dni"];
  String holder = "Minuty";
  String _value = "Minuty";
  var duration;
  int czas;
  String name;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dodaj powiadomienie", style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  buildCustomDropdownButton(),
                  buildSpaceBetween(),
                  Flexible(
                    child: Form(
                      key: _formKey,
                      child: buildCustomTextFieldwithValidation(
                          holder, "Wprowadź wartość"),
                    ),
                  ),
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

  Widget buildcustomButton(String text, void action()) {
    return RaisedButton(
      color: Colors.transparent,
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

  Widget buildSpaceBetween() {
    return SizedBox(
      width: 10.0,
    );
  }

  Widget buildCustomDropdownButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.white),
      ),
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: DropdownButton<String>(
        value: _value,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        onChanged: (String data) {
          setState(() {
            _value = data;
            getDropDownItem();
          });
        },
        items: unitlist.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget buildCustomTextFieldwithValidation(String label, String hint) {
    return TextFormField(
        controller: _text,
        decoration: new InputDecoration(
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
                  _text.clear();
                })),
        keyboardType: TextInputType.number,
        validator: (val) {
          if (val.isEmpty) {
            return 'Pole nie może być puste!';
          }
          return null;
        });
  }

  void getDropDownItem() {
    setState(() {
      holder = _value;
    });
  }

  void validateAndAdd() {
    if (_formKey.currentState.validate()) {
      if (holder == "Minuty") {
        czas = int.parse(_text.text);
        duration = new Duration(minutes: czas);
        name = "$czas minut przed";
      }
      if (holder == "Godziny") {
        czas = int.parse(_text.text);
        duration = new Duration(hours: czas);
        name = "$czas godzin przed";
      }
      if (holder == "Dni") {
        czas = int.parse(_text.text);
        duration = new Duration(days: czas);
        name = "$czas dni przed";
      }

      _notifilist.add(Notifi(duration: duration));

      print(
          "id:${_notifilist.last.id} idEvent:${_notifilist.last.idEvent} idTask:${_notifilist.last.idTask} time: ${_notifilist.last.duration.toString()}");

      setState(() {});
    }
  }

  void confirm() {
    _text.clear();
    List<Notifi> noti = List();
//                widget.event.listNotifi.clear();
    for (Notifi n in _notifilist) {
      if (n.id == null) {
        noti.add(n);
      }
    }

    widget.event.listNotifi = noti;

    Navigator.pop(context);
  }
}
