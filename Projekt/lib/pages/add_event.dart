//import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:pageview/Classes/Event.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();

  Event event;

  AddEvent({this.event});
}

class _AddEventState extends State<AddEvent> {
  final controllerName = TextEditingController();
  final controllerDec = TextEditingController();

  String _date = "Nie wybrano daty";
  String _time1 = "Nie wybrano godziny rozpoczęcia";
  String _time2 = "Nie wybrano godziny zakończenia";
  String _notification = "Ustaw powiadomienie";
  DateTime _start = new DateTime.now();
  DateTime _end = new DateTime.now().add(new Duration(hours: 1));

  Event newevent = new Event();

  @override
  void initState() {
    super.initState();
  }

  String _value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dodaj wydarzenie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: ListView(
            //mainAxisSize: MainAxisSize.max,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new TextFormField(
                controller: controllerName,
                decoration: new InputDecoration(
                  labelText: "Nazwa",
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(0.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      theme: DatePickerTheme(
                        backgroundColor: Colors.amber[400],
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true,
                      minTime: DateTime(2000, 1, 1),
                      maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                    /// tu jest  save data
                    print('confirm $date');
                    _date = '${date.year}-${date.month}-${date.day}';
                    setState(() {});
                  }, currentTime: DateTime.now(), locale: LocaleType.pl);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.date_range,
                                  size: 18.0,
                                ),
                                Text(
                                  "$_date",
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                color: Colors.amber[400],
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showTimePicker(context,
                      theme: DatePickerTheme(
                        backgroundColor: Colors.amber[400],
                        containerHeight: 210.0,
                      ),
                      showSecondsColumn: false,
                      showTitleActions: true, onConfirm: (time) {
                    print('confirm $time');
                    _start = time;
                    String hour =
                        time.hour < 10 ? '0${time.hour}' : '${time.hour}';
                    String minute =
                        time.minute < 10 ? '0${time.minute}' : '${time.minute}';
                    _time1 = hour + ':' + minute;
                    setState(() {});
                  }, currentTime: DateTime.now(), locale: LocaleType.pl);
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  size: 18.0,
                                ),
                                Text(
                                  " $_time1",
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                color: Colors.amber[400],
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showTimePicker(context,
                      theme: DatePickerTheme(
                        backgroundColor: Colors.amber[400],
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true,
                      showSecondsColumn: false, onConfirm: (time) {
                    print('confirm $time');
                    _end = time;
                    String hour =
                        time.hour < 10 ? '0${time.hour}' : '${time.hour}';
                    String minute =
                        time.minute < 10 ? '0${time.minute}' : '${time.minute}';
                    _time2 = hour + ':' + minute;
                    setState(() {});
                  }, currentTime: _start.add(Duration(minutes: 1)), locale: LocaleType.pl);
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  size: 18.0,
                                ),
                                Text(
                                  " $_time2",
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                color: Colors.amber[400],
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_alarms,
                                  size: 18.0,
                                ),
                                Text(
                                  "$_notification",
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              SizedBox(
                height: 20.0,
              ),
              new DropdownButton<String>(
                isExpanded: true,
                items: [
                  DropdownMenuItem<String>(
                    child: Text('Powiadomienie'), //TODO:
                    value: null,
                  ),
                  DropdownMenuItem<String>(
                    child: Text('15min przed'),
                    value: 'one',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('30min przed'),
                    value: 'two',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('60min przed'),
                    value: 'three',
                  )
                  //TODO: Tu dodac custom
                ],
                onChanged: (String value) {
                  setState(() {
                    _value = value;
                    //newevent.idNotification = ;
                  });
                },
                value: _value,
              ),
              SizedBox(
                height: 20.0,
              ),
              new DropdownButton<String>(
                isExpanded: true,
                items: [
                  DropdownMenuItem<String>(
                    child: Text('Cykl'), //TODO:
                    value: null,
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Codziennie'),
                    value: 'one',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Co tydzień'),
                    value: 'two',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Co dwa tygodnie'),
                    value: 'three',
                  ),
                  //TODO: Tu dodać custom
                ],
                onChanged: (String value) {
                  setState(() {
                    _value = value;
                    newevent.cycle = value;
                  });
                },
                value: _value,
              ),
              SizedBox(
                height: 20.0,
              ),
              new TextFormField(
                controller: controllerDec,
                decoration: new InputDecoration(
                  labelText: "Opis",
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(0.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 20.0,
              ),
              new ButtonBar(
                  children: [
                    RaisedButton(
                      child: Text("Anuluj"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    RaisedButton(
                      child: Text("Dodaj"),
                      onPressed: () {
                        if (_end.isBefore(_start)) {
                          print("ERROR");
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Błędne dane"),
                                  content: Text("Godzina zakończenia nie może być przed rozpoczęciem."),
                                );
                              });
                        } else {
                          newevent.name = controllerName.value.toString();
                          newevent.description = controllerDec.value
                              .toString(); //<- tu jest problem
                          newevent.beginTime = _date + " " + _time1;
                          newevent.endTime = _date + " " + _time2;
                          print(newevent.name);
                          print(newevent.beginTime);
                          print(newevent.endTime);
                          print(newevent.cycle);
                          print(newevent.description);
                        }
                      },
                    ),
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
}
