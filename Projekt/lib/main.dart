import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pageview/Baza_danych/task_helper.dart';
import 'package:pageview/Classes/Task.dart';
import 'package:pageview/pages/Add/add_event.dart';
import 'package:pageview/pages/Add/add_task.dart';
import 'package:pageview/pages/HomePage.dart';
import 'package:pageview/pages/GroupPage/GroupPage.dart';

import 'Background/notification_helper_background.dart';
import 'Baza_danych/database_helper.dart';
import 'Baza_danych/localization_helper.dart';
import 'Classes/Localization.dart';
import 'pages/calendar.dart';

void main() async {
  // TestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper();
  Notifications_helper_background.initialize();
  await AndroidAlarmManager.initialize();

  await AndroidAlarmManager.periodic(
      Duration(minutes: 1), 0, checkLocationRadius);

  //AndroidAlarmManager.per
  AndroidAlarmManager.cancel(0);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //final dbHelper = DatabaseHelper.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Locato',
      theme: ThemeData(
          primarySwatch: Colors.grey,
          appBarTheme: AppBarTheme(color: Color(0xFF332F53)),
          accentColor: Colors.amberAccent,
          canvasColor: Color.fromRGBO(51, 47, 83, 1),
          bottomAppBarColor: Color(0xFF333366),
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
  var pageCanChange = true;

  @override
  void initState() {
    // Definicja kontrolera tabbar
    _tabController = new TabController(initialIndex: 1, length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        print("Index Taba " + _tabController.index.toString());
        onPageChange(_tabController.index, p: _pageController);
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

    return Scaffold(
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
            preferredSize: Size(screenWidthTabBar, 5.0),
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
        backgroundColor: Color(0xFF444477),
        overlayOpacity: 0.5,
        onOpen: () => print('Otwieram Dial na Tasks'),
        onClose: () => print('Zamykam Dial na Tasks'),
        heroTag: 'speed-dial-hero-tag',
        children: [
          SpeedDialChild(
              child: Icon(Icons.event_note),
              backgroundColor: Color(0xFF444477),
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
              backgroundColor: Color(0xFF444477),
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
            child: Icon(Icons.data_usage),
            label: 'DB',
            labelStyle: TextStyle(color: Colors.grey[900], fontSize: 18.0),
            onTap: () {
              // Notifications_helper_background.now("NOW", "FUCK");

              DatabaseHelper.instance.showalltables();
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (page) {
          if (pageCanChange) {
            onPageChange(page);
          }
          //_tabController.animateTo(page);
        },
        children: <Widget>[
          Calendar(),
          HomePageEvents(),
          GroupTaskPage(),
        ],
      ),
    );
  }

  onPageChange(int index, {PageController p, TabController t}) async {
    // Obsluga PageControllera
    if (p != null) {
      pageCanChange = false;
      await _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
      pageCanChange = true;
    } else {
      // Obsluga TabControllera
      _tabController.animateTo(index);
    }
  }
}

void checkLocationRadius() async {
  List<Localization> _listloc = List();
  List<Task> _listtask = List();
  double dist;
  Position pos;
  int id = -1;
  int distance = 100;
  DatabaseHelper();
  Notifications_helper_background.initialize();

  pos = await Geolocator().getCurrentPosition();
  //print("Obecna lokalizacja: " + pos.toString());

  // DownloadData
  _listloc.addAll(await LocalizationHelper.lists());
  _listloc.removeWhere((l) => l.id == 0);

  if(_listloc.isNotEmpty){
    print("Length list loc: ${_listloc.length}");

    for(Localization loc in _listloc){
      loc.isNearBy = false;

        dist = await Geolocator().distanceBetween(loc.latitude, loc.longitude, pos.latitude, pos.longitude);
       // print("Dystans pomiedzy punktami " + dist.toString());

        if(dist < distance){
        loc.isNearBy = true;
        _listtask.addAll(await TaskHelper.listsIDLocal(loc.id));

          if(_listtask.isNotEmpty
             // && (loc.wasNotified==false)
          ) {

            String title = "Na :${loc.street}";
            String decription = "Masz do zrobienia: ${_listtask
                .length} zadania.\n" +
                "Odleglosc od miesca: $dist m\n";

            print("LocID ${loc.id}");
            print("List of Task: ${_listtask.length}");



            _listtask.forEach((t) => print("TaskName: ${t.name}"));

            loc.wasNotified = true;
            Notifications_helper_background.now(title, decription);

          }

        }
        LocalizationHelper.updateStatus(loc);
    }
  }

}


updateDataOnThisDay() async{

  TaskHelper.deleteDoneTaskToday();
  LocalizationHelper.resetAllStatus();

}
