import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:pageview/Baza_danych/notification_helper.dart';
import 'package:pageview/Classes/Event.dart';
import 'package:pageview/Classes/Notifi.dart';
import 'package:pageview/Classes/Task.dart';
import 'package:pageview/List/button_notification_list_builder_widget.dart';

class UpgradeNotificationTask extends StatefulWidget {
  @override
  _UpgradeNotificationTaskState createState() =>
      _UpgradeNotificationTaskState();

  Task task;
  UpgradeNotificationTask(this.task);
}

class _UpgradeNotificationTaskState extends State<UpgradeNotificationTask> {
  final TextEditingController _text = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Notifi> _notifilist;
  List<Notifi> downloadlist;
  var duration;
  int minuty;
  int godziny;
  int dni;
  String name;

  @override
  void initState() {
    _notifilist = List();
    downloadlist = List();
    dni = 0;
    godziny = 0;
    minuty = 1;
    //_notifilist = widget.task.listNotifi;
    _downloadData();
    super.initState();
  }

  void _downloadData() {
    NotifiHelper.listsTaskID(widget.task.id).then((onList) {
      if (onList != null) {
        downloadlist = onList;

        _notifilist.addAll(downloadlist);

        if (widget.task.listNotifi.isNotEmpty) {
          _notifilist.addAll(widget.task.listNotifi);
        }
        setState(() {});
      }
    });
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
    widget.task.listNotifi.clear();
    _notifilist.forEach((t) {
      if (t.id == null) {
        widget.task.listNotifi.add(t);
      }
    });

    Navigator.pop(context);
  }
}

class UpgradeNotificationEvent extends StatefulWidget {
  @override
  _UpgradeNotificationEventState createState() =>
      _UpgradeNotificationEventState();

  Event event;

  UpgradeNotificationEvent(this.event);

// Notification notification;
// AddNotification({this.notification});

}

class _UpgradeNotificationEventState extends State<UpgradeNotificationEvent> {
  final TextEditingController _text = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Notifi> _notifilist;
  List<Notifi> downloadlist;
  var duration;
  int minuty;
  int godziny;
  int dni;
  String name;

  @override
  void initState() {
    _notifilist = List();
    downloadlist = List();
    dni = 0;
    godziny = 0;
    minuty = 1;
    _downloadData();

    super.initState();
  }

  void _downloadData() {
    NotifiHelper.listsEventID(widget.event.id).then((onList) {
      if (onList != null) {
        downloadlist = onList;

        _notifilist.addAll(downloadlist);

        if (widget.event.listNotifi.isNotEmpty) {
          _notifilist.addAll(widget.event.listNotifi);
        }
        setState(() {});
      }
    });
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
    widget.event.listNotifi.clear();
    _notifilist.forEach((t) {
      if (t.id == null) {
        widget.event.listNotifi.add(t);
      }
    });

    Navigator.pop(context);
  }
}
