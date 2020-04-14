import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pageview/Baza_danych/event_helper.dart';
import 'package:pageview/Baza_danych/task_helper.dart';
import 'package:pageview/Classes/Event.dart';
import 'package:pageview/Items/ItemsEvent.dart';
import 'add_location.dart';

class HomePageEvents extends StatefulWidget {
  @override
  _HomePageEventsState createState() => _HomePageEventsState();

}

class _HomePageEventsState extends State<HomePageEvents> {
  static final List<String> listOfDays = [
    "Poniedziałek",
    "Wtorek",
    "Środa",
    "Czwartek",
    "Piatek",
    "Sobota",
    "Niedziela"
  ];
  List<Event> list;
  double heightExtededAppBar = 200.0;
  //ScrollController _scrollController;

  double heightImportantEvent = 80.0;
  double widthImportantEvent = 100.0;

  DateTime _date;


  @override
  void initState() {
    super.initState();
    _date = DateTime.now().add(Duration(days: 1));
    list = List();
  }

  String getDay(int day){
    //print(_date.timeZoneOffset);
    int val = (_date.day + day )%7;
    return listOfDays[val];
  }



  Widget buildAppBarExtended(String day){
    return SliverAppBar(
      //expandedHeight: heightExtededAppBar,
      pinned: true,
      title: Text(day),
//      flexibleSpace: FlexibleSpaceBar (
//        title: Text("Today"),
//        centerTitle: true,
//        background: Column(
//          children: <Widget>[
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                Container(
//                  width: widthImportantEvent,
//                  height: heightImportantEvent,
//                  color: Colors.deepOrangeAccent,
//                ),
//                Container(
//                  width: widthImportantEvent,
//                  height: heightImportantEvent,
//                  color: Colors.deepOrangeAccent,
//                ),
//                Container(
//                  width: widthImportantEvent,
//                  height: heightImportantEvent,
//                  color: Colors.deepOrangeAccent,
//                ),
//              ],
//            ),
//          ],
//        ),
//      ),
    );
  }

  Widget buildAppBar(String day){
    return SliverAppBar(
      //stretchTriggerOffset: 50,
      pinned: false,
      title: Text(day),
    );
  }



  Widget bulidListofEvents(List<Event> eventsList){
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        final Event item = eventsList[index];
        return ItemEvent(item,
          onPressedEdit: null,
          onPressedDelete: null,
        );


      },
        childCount: eventsList.length,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: EventHelper.lists(),
      builder: (ctxt, userData) {


        switch (userData.connectionState) {
          case ConnectionState.none:
            return Container();
          case ConnectionState.waiting:
            return Container();
          case ConnectionState.active:
          case ConnectionState.done:

            list = userData.data;
            if(list != null) {

              return CustomScrollView(
                //controller: _scrollController,
                slivers: <Widget>[
                  buildAppBarExtended(getDay(0)),
                  bulidListofEvents(list),
                  buildAppBar(getDay(1)),
                  bulidListofEvents(List()),
                  buildAppBar(getDay(2)),
                  bulidListofEvents(List()),
                  buildAppBar(getDay(3)),
                  bulidListofEvents(List()),
                  buildAppBar(getDay(4)),
                  bulidListofEvents(List()),
                  buildAppBar(getDay(5)),
                  bulidListofEvents(List()),
                  buildAppBar(getDay(6)),
                  bulidListofEvents(List()),
                ],
              );

            }
            return Center(child: Text("zero"));
        }

        return Container();



//
      },
    );


  }
}

