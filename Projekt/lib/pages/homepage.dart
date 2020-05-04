import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pageview/Baza_danych/event_helper.dart';
import 'package:pageview/Baza_danych/task_helper.dart';
import 'package:pageview/Classes/Event.dart';
import 'package:pageview/main.dart';
import 'package:pageview/pages/add_event.dart';
import 'add_location.dart';
import 'add_task.dart';
import 'package:pageview/Items/EventCard.dart';

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
  int day;
  List<Event> list;
  double heightExtededAppBar = 200.0;
  //ScrollController _scrollController;

  double heightImportantEvent = 80.0;
  double widthImportantEvent = 100.0;

  DateTime _date;

  @override
  void initState() {
    super.initState();
    _date = DateTime.now().add(Duration(days: 3));
    list = List();
    day = DateTime.now().day;
  }

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
        switch (userData.connectionState) {
          case ConnectionState.none:
          // return Container();
          case ConnectionState.waiting:
          // return Container();
          case ConnectionState.active:
          case ConnectionState.done:
            list = userData.data;
            if (list != null) {
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
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => EventCard(
                              day: getDay(index),
                              events: listaList[index],
                            ),
                        childCount: 7),
                  ),
                ],
              );
            } else {
              return Center(child: Text("zero"));
            }
        }

        return Container();

//
      },
    );
  }
}
