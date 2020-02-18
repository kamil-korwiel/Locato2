import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pageview/pages/calendar.dart';
import 'package:pageview/pages/homepage.dart';
import 'package:pageview/pages/tasks.dart';
import 'package:pageview/testsliver/homepagesilver.dart';
import 'package:pageview/testsliver/grouptask.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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
  List<Widget> pages = [Calendar(), HomePageE(), Tasks()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: PageController(
            initialPage: 1,
          ),
          children: <Widget>[
            Calendar(),
            HomePageTest(),
            GroupTask(),
          ],
        ),
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
                onTap: () => print('Dodaj Wydarzenie')),
            SpeedDialChild(
                child: Icon(Icons.check_box),
                label: 'Zadanie',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () => print('Dodaj Zadanie')),
            SpeedDialChild(
              child: Icon(Icons.add_location),
              label: 'Lokalizacja',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
                print('Dodaj Lokalizacje');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                   // builder: (context) => AddLocation(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}