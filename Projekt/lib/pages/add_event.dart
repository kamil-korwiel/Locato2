//import 'dart:html';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:pageview/Baza_danych/database_helper.dart';
import 'package:pageview/Baza_danych/event_helper.dart';
import 'package:pageview/Baza_danych/notification_helper.dart';
import 'package:pageview/Classes/Event.dart';
import 'package:pageview/Classes/Notifi.dart';
import 'package:pageview/pages/add_cycle.dart';
import 'add_notification.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();

  Event update;

  AddEvent({this.update});
}

class _AddEventState extends State<AddEvent> {
  TextEditingController controllerName;
  TextEditingController controllerDec;

  String _name;
  String _decription;
  String _date;
  String _time1;
  String _time2;
  String _notification;
  String _cycle ;
  DateTime _start ;
  DateTime _end ;

  int idNotification = 0;


  Event newevent;

  @override
  void initState() {

    newevent = Event(
      id: 0,
    );

    _name = (widget.update == null)? null : widget.update.name;
    _decription = (widget.update == null)? null : widget.update.description;
    _date = (widget.update == null)? "Nie wybrano daty" : DateFormat("yyyy-MM-dd").format(widget.update.beginTime);
    _time1 = (widget.update == null)?"Nie wybrano godziny rozpoczęcia" : DateFormat("hh:mm").format(widget.update.beginTime);
    _time2 = (widget.update == null)?"Nie wybrano godziny zakończenia" :  DateFormat("hh:mm").format(widget.update.endTime);
    _notification =(widget.update == null)? "Nie wybrano powiadomień" : "ErrorUpdate";
    _cycle = (widget.update == null)?"Wydarzenie nie jest cykliczne" : "ErrorUpdate";
    _start = (widget.update == null)?new DateTime.now() : widget.update.beginTime;
    _end = (widget.update == null)?new DateTime.now().add(new Duration(hours: 1)) : widget.update.endTime;

    controllerName = TextEditingController();
    controllerDec = TextEditingController();

    if(widget.update != null){
      controllerName = TextEditingController(text:_name);
      controllerDec = TextEditingController(text:_decription);
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dodaj wydarzenie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
                new TextFormField(
                controller: controllerName,
                decoration: new InputDecoration(
                  labelText: "Nazwa",
                  hintText: "Wpisz nazwę swojego wydarzenia"  
                ),
                keyboardType: TextInputType.text,
                validator: (val) {
                if (val.isEmpty) {
                  return 'Pole nie może być puste!';
                }
                return null;
              },
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
                        backgroundColor: Colors.black38,
                        itemStyle: TextStyle(color: Colors.white),
                        cancelStyle: TextStyle(color: Colors.amber[400]),
                        doneStyle: TextStyle(color: Colors.green[400]),
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true,
                      minTime: DateTime(2000, 1, 1),
                      maxTime: DateTime(2022, 12, 31),
                      onConfirm: (date) {
                    /// tu jest  save data
                    print('confirm $date');
                    String month = date.month < 10 ? '0${date.month}' : '${date.month}';
                    String day = date.day < 10 ? '0${date.day}' : '${date.day}';
                    _date = '${date.year}-$month-$day';
                    setState(() {});
                  }, currentTime: _start, locale: LocaleType.pl);
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
                        backgroundColor: Colors.black38,
                        itemStyle: TextStyle(color: Colors.white),
                        cancelStyle: TextStyle(color: Colors.amber[400]),
                        doneStyle: TextStyle(color: Colors.green[400]),
                        containerHeight: 210.0,
                      ),
                      showSecondsColumn: false,
                      showTitleActions: true, onConfirm: (time) {
                    print('confirm $time');
                    //_start = time;
                    String hour =
                        time.hour < 10 ? '0${time.hour}' : '${time.hour}';
                    String minute =
                        time.minute < 10 ? '0${time.minute}' : '${time.minute}';
                    _time1 = hour + ':' + minute;
                    setState(() {});
                  }, currentTime: _start, locale: LocaleType.pl);
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
                        backgroundColor: Colors.black38,
                        itemStyle: TextStyle(color: Colors.white),
                        cancelStyle: TextStyle(color: Colors.amber[400]),
                        doneStyle: TextStyle(color: Colors.green[400]),
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true,
                      showSecondsColumn: false, onConfirm: (time) {
                    print('confirm $time');
                   // _end = time;

                    String hour =
                        time.hour < 10 ? '0${time.hour}' : '${time.hour}';
                    String minute =
                        time.minute < 10 ? '0${time.minute}' : '${time.minute}';

                    _time2 = hour + ':' + minute;

                    setState(() {});
                  },
                      currentTime: _end,
                      locale: LocaleType.pl);
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddNotificationEvent(widget.update == null ? newevent : widget.update)));
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
                                  Icons.notifications,
                                  size: 18.0,
                                ),
                                Text(" $_notification"),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddCycle()));
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
                                  Icons.timelapse,
                                  size: 18.0,
                                ),
                                Text(" $_cycle"),
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
              new TextFormField(
                controller: controllerDec,
                decoration: new InputDecoration(
                  labelText: "Opis",
                  hintText: "Wpisz opis swojego wydarzenia"
                ),
                keyboardType: TextInputType.text,
                validator: (val) {
                if (val.isEmpty) {
                  return 'Pole nie może być puste!';
                }
                return null;
              },
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
                        if(_formKey.currentState.validate()){
                        if (_end.isBefore(_start)) {
                          print("ERROR");
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Błędne dane"),
                                  content: Text(
                                      "Godzina zakończenia nie może być przed rozpoczęciem."),
                                );
                              });
                        
                        } /*else {

                          if(widget.update != null){

                            widget.update.name = controllerName.value.text;
                            widget.update.description = controllerDec.value.text;

                            DateTime t1 = DateTime.parse("$_date $_time1");
                            DateTime t2 = DateTime.parse("$_date $_time2");
                            widget.update.beginTime = t1;
                            widget.update.endTime = t2;

                            EventHelper.update(widget.update);
                            Navigator.of(context).pop();

                          }else
                            {
                            newevent.name = controllerName.value.text;
                            newevent.description = controllerDec.value.text; //<- tu jest problem
                            DateTime t1 = DateTime.parse("$_date $_time1");
                            DateTime t2 = DateTime.parse("$_date $_time2");
                            newevent.beginTime = t1;
                            newevent.endTime = t2;


//                            print(newevent.name);
//                            print(newevent.beginTime);
//                            print(newevent.endTime);
//                            print(newevent.cycle);
//                            print(newevent.description)
                            EventHelper.add(newevent);
                            Navigator.of(context).pop();
                         }

                        }*/
                        };
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
