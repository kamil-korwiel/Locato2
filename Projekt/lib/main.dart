import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pageview/pages/Add/add_event.dart';
import 'package:pageview/pages/Add/add_task.dart';
import 'package:pageview/pages/GroupPage/GroupPage.dart';
import 'package:pageview/pages/homepage.dart';
import 'package:pageview/pages/grouptaskpage.dart';

import 'Baza_danych/database_helper.dart';
import 'pages/calendar.dart';

void main() async {
  // TestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  runApp(MyApp());
}

MaterialColor myGrey = const MaterialColor(0xFF333333, const {
  50: const Color(0xFF333333),
  100: const Color(0xFF333333),
  200: const Color(0xFF333333),
  300: const Color(0xFF333333),
  400: const Color(0xFF333333),
  500: const Color(0xFF333333),
  600: const Color(0xFF333333),
  700: const Color(0xFF333333),
  800: const Color(0xFF333333),
  900: const Color(0xFF333333),
});

class MyApp extends StatelessWidget {
  final DatabaseHelper dbHelper = DatabaseHelper();
  //final dbHelper = DatabaseHelper.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Locato',
      theme: ThemeData(
          primarySwatch: Colors.grey,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(51, 47, 83, 1),
          brightness: Brightness.dark,
          primaryTextTheme:
              TextTheme(title: TextStyle(color: Colors.amberAccent))),
      /* theme: ThemeData(
        primaryColor: Color(0xFF333366),
        canvasColor: Colors.white,
        accentColor: Color(0xffBB86FC),
        backgroundColor: Colors.white,
      ),*/
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  PageController _pageController;

  @override
  void initState() {
    // Definicja kontrolera tabbar
    _tabController = new TabController(initialIndex: 1, length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        print("Index Taba " + _tabController.index.toString());
        //onPageC
      }
    });
    _pageController = PageController(
      initialPage: 1,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Zmienna szerokosci ekranu dla TabBaru
    var screenWidthTabBar = MediaQuery.of(context).size.width * 0.8;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            //title: Text("Locato"),
            leading: GestureDetector(
              onTap: () {},
              //child: Icon(Icons.menu),
            ),
            elevation: 0.0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFF534B83), const Color(0xFF332F53)],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.0, 1.0),
                  stops: [0.0, 0.7],
                  tileMode: TileMode.clamp,
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size(screenWidthTabBar, 40.0),
              child: new Container(
                width: screenWidthTabBar,
                child: new TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Color(0xff00c6ff),
                  controller: _tabController,
                  tabs: <Widget>[
                    new Container(
                      height: 40.0,
                      child: new Tab(
                        text: "Kalendarz".toUpperCase(),
                      ),
                    ),
                    new Container(
                      height: 40.0,
                      child: new Tab(text: "Tydzień".toUpperCase()),
                    ),
                    new Container(
                      height: 40.0,
                      child: new Tab(text: "Grupy".toUpperCase()),
                    ),
                  ],
                ),
              ),
            )),
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
                labelStyle: TextStyle(color: Colors.grey[900], fontSize: 18.0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEvent(),
                    ),
                  );
                }),
            SpeedDialChild(
                child: Icon(Icons.check_box),
                label: 'Zadanie',
                labelStyle: TextStyle(color: Colors.grey[900], fontSize: 18.0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddTask(),
                    ),
                  );
                  setState(() {});
                }),
            SpeedDialChild(
              child: Icon(Icons.add_location),
              label: 'Lokalizacja',
              labelStyle: TextStyle(color: Colors.grey[900], fontSize: 18.0),
              onTap: () {
                DatabaseHelper.instance.showalltables();
              },
            ),
          ],
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (page) {
            _tabController.animateTo(page);
          },
          children: <Widget>[
            Calendar(),
            HomePageEvents(),
            GroupTaskPage(),
          ],
        ),
      ),
    );
  }
}
