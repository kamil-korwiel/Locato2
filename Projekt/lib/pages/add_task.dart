import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:pageview/Classes/Task.dart';


class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();

  Task task;

  AddTask({this.task});
}

class _AddTaskState extends State<AddTask> {
  String _date = "Nie wybrano daty";
  String _time1 = "Nie wybrano godziny rozpoczęcia";


  Task newtask = Task();
  @override
  void initState() {
    super.initState();
  }

  String _value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dodaj zadanie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: ListView(
//            mainAxisSize: MainAxisSize.max,
//            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: "Nazwa",
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(0.0),
                    borderSide: new BorderSide(
                    ),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 10.0,
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
                        print('confirm $date');
                        _date = '${date.year} - ${date.month} - ${date.day}';
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
                                  " $_date",
                                  style: TextStyle(
                                  ),
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
                height: 10.0,
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
                      showTitleActions: true, onConfirm: (time) {
                        print('confirm $time');
                        _time1 = '${time.hour} : ${time.minute} : ${time.second}';
                        setState(() {});
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
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
                                  style: TextStyle(
                                  ),
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
                height: 10.0,
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: "Opis",
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(0.0),
                    borderSide: new BorderSide(
                    ),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 10.0,
              ),
              new DropdownButton<String>(
                isExpanded: true,
                items: [
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
                  ),
                ],
                onChanged: (String value) {
                  setState(() {
                    _value = value;
                  });
                },
                hint: Text('Powiadomienie'),
                value: _value,
              ),
              SizedBox(
                height: 10.0,
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: "Nazwa grupy",
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(0.0),
                    borderSide: new BorderSide(
                    ),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 10.0,
              ),
              new DropdownButton<String>(
                isExpanded: true,
                items: [
                  DropdownMenuItem<String>(
                    child: Text('Grupa 1'),
                    value: 'one',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Grupa 2'),
                    value: 'two',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Grupa 3'),
                    value: 'three',
                  ),
                ],
                onChanged: (String value) {
                  setState(() {
                    _value = value;
                  });
                },
                hint: Text('Grupa'),
                value: _value,
              ),
              SizedBox(
                height: 10.0,
              ),
              new ButtonBar(children:[
                RaisedButton(
                    child:Text("Anuluj")),
                RaisedButton(
                    child:Text("Dodaj")),
              ],
                  alignment:MainAxisAlignment.center,
                  mainAxisSize:MainAxisSize.max,
                  buttonMinWidth: 150),
            ],
          ),
        ),
      ),
    );
  }
}