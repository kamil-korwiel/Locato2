import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pageview/pages/add_event.dart';
import 'package:pageview/pages/add_task.dart';
import 'package:pageview/pages/calendar.dart';
import 'package:pageview/pages/homepage.dart';
import 'package:pageview/pages/grouptaskpage.dart';
import 'Baza_danych/event_helper.dart';
import 'Classes/Event.dart';
import 'pages/add_location2.dart';

import 'Baza_danych/database_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final DatabaseHelper dbHelper = DatabaseHelper();
  //final dbHelper = DatabaseHelper.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _counter;
  DateTime _date;
  @override
  void initState() {
    _date = DateTime.now();
    _counter = 0;

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: SpeedDial(
          elevation: 10.0,
          animatedIcon: AnimatedIcons.add_event,
          animatedIconTheme: IconThemeData(size: 22.0),
          closeManually: false,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          onOpen: () => print('Otwieram Dial na Tasks'),
          onClose: () => print('Zamykam Dial na Tasks'),
          heroTag: 'speed-dial-hero-tag',
          children: [
            SpeedDialChild(
                child: Icon(Icons.event_note),
                label: 'Wydarzenie',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {
//                  _counter++;
//                  _date = _date.add(Duration(days: 1));
//
//                  Event e = Event(
//                    id:_counter,
//                    name:"Name $_counter",
//                    beginTime: _date,
//                    endTime: _date,
//                    cycle:"D6",
//                    description:"bal bal bal",
//                    idNotification: 1,
//                  );
//                  print(e.toString());
//
//                  EventHelper.add(e);
//                  setState(() {});
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddEvent(),),);
                }),
            SpeedDialChild(
                child: Icon(Icons.check_box),
                label: 'Zadanie',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddTask(),),);
                }),
//            SpeedDialChild(
//              child: Icon(Icons.add_location),
//              label: 'Lokalizacja',
//              labelStyle: TextStyle(fontSize: 18.0),
//              onTap: () {
//                print('Dodaj Lokalizacje');
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                    builder: (context) => AddLocation(),
//                  ),
//                );
//              },
//            ),
          ],
        ),
        body: PageView(
          controller: PageController(
            initialPage: 1,
          ),
          children: <Widget>[
//            Calendar(),
            HomePageEvents(),
//            GroupTaskPage(),
          ],
        ),
      ),
    );
  }
}
