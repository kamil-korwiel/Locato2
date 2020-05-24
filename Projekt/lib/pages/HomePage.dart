import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:Locato/Baza_danych/event_helper.dart';

import 'package:Locato/Classes/Event.dart';

import 'HomePage/EventCard.dart';

///Stores state of HomePage class, if changed rebuild widget.
_HomePageEventsState homePageEventsState;

class HomePageEvents extends StatefulWidget {
  @override
  _HomePageEventsState createState() {
    homePageEventsState = _HomePageEventsState();
    return homePageEventsState;
  }
}

class _HomePageEventsState extends State<HomePageEvents> {
  ///Stores the names of weekdays in Polish.
  static final List<String> listOfDays = [
    "Poniedziałek",
    "Wtorek",
    "Środa",
    "Czwartek",
    "Piatek",
    "Sobota",
    "Niedziela"
  ];

  ///Stores a number of week's day, where 0 is current day.
  int day;

  ///Stores a list of objects of Event class.
  List<Event> list;

  ///Stores value of UI layout.
  double heightExtededAppBar = 200.0;
  //ScrollController _scrollController;

  ///Stores value of UI layout.
  double heightImportantEvent = 80.0;

  ///Stores value of UI layout.
  double widthImportantEvent = 100.0;

  ///Stores a DateTime object.
  DateTime _date;

  @override
  void initState() {
    super.initState();
    _date = DateTime.now().add(Duration(days: 3));
    list = List();
    day = DateTime.now().day;
  }

  ///Return a Polish name of given day.
  String getDay(int day) {
    //print(_date.timeZoneOffset);
    int val = (_date.day + day) % 7;
    return listOfDays[val];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: EventHelper.lists(),
      builder: (ctxt, userData) {
        ///Connects to database and download list of events.
        switch (userData.connectionState) {
          case ConnectionState.none:
          // return Container();
          case ConnectionState.waiting:
          // return Container();
          case ConnectionState.active:
          case ConnectionState.done:
            list = userData.data;
            if (list != null) {
              ///Stores the list of lists of events.
              List<List<Event>> listaList = new List.generate(7, (i) => []);

              for (Event item in list) {
                if (item.beginTime.day == day) {
                  listaList[0].add(item);
                }
                if (item.beginTime.day == day + 1) {
                  listaList[1].add(item);
                }
                if (item.beginTime.day == day + 2) {
                  listaList[2].add(item);
                }
                if (item.beginTime.day == day + 3) {
                  listaList[3].add(item);
                }
                if (item.beginTime.day == day + 4) {
                  listaList[4].add(item);
                }
                if (item.beginTime.day == day + 5) {
                  listaList[5].add(item);
                }
                if (item.beginTime.day == day + 6) {
                  listaList[6].add(item);
                }
              }

              return CustomScrollView(
                //controller: _scrollController,
                slivers: <Widget>[
                  SliverList(
                    ///Builds a list of all events divided in days of incoming week, where single day is declared as EventCard class.
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => EventCard(
                              getDay(index),
                              listaList[index],
                            ),
                        childCount: 7),
                  ),
                ],
              );
            } else {
              //return Center(child: Text("zero"));
            }
        }

        return Container();

//
      },
    );
  }

  refresh() => setState(() {});
}
