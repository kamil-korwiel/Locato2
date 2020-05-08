import 'package:flutter/material.dart';
import 'package:pageview/Baza_danych/notification_helper.dart';
import 'package:pageview/Classes/Event.dart';
import 'package:pageview/Classes/Notifi.dart';
import 'package:pageview/Classes/Task.dart';
import 'package:pageview/List/button_notification_list_builder_widget.dart';

class UpgradeNotificationTask extends StatefulWidget {
  @override
  _UpgradeNotificationTaskState createState() => _UpgradeNotificationTaskState();

  Task task;
  UpgradeNotificationTask(this.task);
}

class _UpgradeNotificationTaskState extends State<UpgradeNotificationTask> {
  final TextEditingController _text = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Notifi> _notifilist;
  List<Notifi> downloadlist;
  List<String> unitlist = ["Minuty", "Godziny", "Dni"];
  String holder = "Minuty";
  String _value = "Minuty";
  var duration;
  int czas;
  String name;



  @override
  void initState() {
    _notifilist = List();
    downloadlist = List();
    //_notifilist = widget.task.listNotifi;
    _downloadData();
    super.initState();
  }


  void _downloadData(){

    NotifiHelper.listsTaskID(widget.task.id).then((onList) {
      if(onList != null) {
        downloadlist = onList;

        _notifilist.addAll(downloadlist);

        if(widget.task.listNotifi.isNotEmpty){
          _notifilist.addAll(widget.task.listNotifi);
        }
        setState(() {});

      }
    });
  }



  void getDropDownItem() {
    setState(() {
      holder = _value;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dodaj powiadomienie", style: TextStyle(color: Colors.white)),
        // tu kontrolujesz przycisk wstecz
        leading: new IconButton(icon: Icon(Icons.arrow_back), onPressed: onBackPressed),
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

  Widget buildCustomDropdownButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: Color(0xFF333366),
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
  _UpgradeNotificationEventState createState() => _UpgradeNotificationEventState();

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
  List<String> unitlist = ["Minuty", "Godziny", "Dni"];
  String holder = "Minuty";
  String _value = "Minuty";
  var duration;
  int czas;
  String name;


  @override
  void initState() {
    _notifilist = List();
    downloadlist = List();
    _downloadData();

    super.initState();
  }

  void _downloadData(){

    NotifiHelper.listsEventID(widget.event.id).then((onList) {
      if(onList != null) {
        downloadlist = onList;

        _notifilist.addAll(downloadlist);

        if(widget.event.listNotifi.isNotEmpty){
          _notifilist.addAll(widget.event.listNotifi);
        }
        setState(() {});

      }
    });
  }




  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dodaj powiadomienie", style: TextStyle(color: Colors.white),),
        // tu kontrolujesz przycisk wstecz
        leading: new IconButton(icon: Icon(Icons.arrow_back), onPressed: onBackPressed),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(children: <Widget>[
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  buildCustomDropdownButton(),
                  SizedBox(width: 30),
                  Flexible(
                    child: Form(
                      key: _formKey,
                      child: buildCustomTextFieldwithValidation(
                          holder, "Wprowadź wartość", _text),
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

  Widget buildCustomDropdownButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: Color(0xFF333366),
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

//      print(
//          "id:${_notifilist.last.id} idEvent:${_notifilist.last.idEvent} idTask:${_notifilist.last.idTask} time: ${_notifilist.last.duration.toString()}");

      setState(() {});
    }
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
