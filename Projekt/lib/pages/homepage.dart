import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pageview/Baza_danych/event_helper.dart';
import 'package:pageview/Baza_danych/task_helper.dart';
import 'package:pageview/Classes/Event.dart';
import 'package:pageview/Items/ItemsEvent.dart';
import 'package:pageview/pages/add_event.dart';
import 'add_location.dart';
import 'add_task.dart';

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
    _date = DateTime.now().add(Duration(days: 1));
    list = List();
    day = DateTime.now().day;
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
          onPressedEdit: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddEvent(update: item,),),);
          },
          onPressedDelete: (){
            EventHelper.delete(item.id);
            setState(() {});
          },
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
           // return Container();
          case ConnectionState.waiting:
           // return Container();
          case ConnectionState.active:
          case ConnectionState.done:

            list = userData.data;
            if(list != null) {

              List<Event> list1 = List();
              List<Event> list2 = List();
              List<Event> list3 = List();
              List<Event> list4 = List();
              List<Event> list5 = List();
              List<Event> list6 = List();
              List<Event> list7 = List();


              for(Event item in list){
                if(item.beginTime.day == day){
                  list1.add(item);
                }
                if(item.beginTime.day == day+1){
                  list2.add(item);
                }
                if(item.beginTime.day == day+2){
                  list3.add(item);
                }
                if(item.beginTime.day == day+3){
                  list4.add(item);
                }
                if(item.beginTime.day == day+4){
                  list5.add(item);
                }
                if(item.beginTime.day == day+5){
                  list6.add(item);
                }
                if(item.beginTime.day == day+6){
                  list7.add(item);
                }

              }

              return CustomScrollView(
                //controller: _scrollController,
                slivers: <Widget>[
                  buildAppBarExtended(getDay(0)),
                  bulidListofEvents(list1),
                  buildAppBar(getDay(1)),
                  bulidListofEvents(list2),
                  buildAppBar(getDay(2)),
                  bulidListofEvents(list3),
                  buildAppBar(getDay(3)),
                  bulidListofEvents(list4),
                  buildAppBar(getDay(4)),
                  bulidListofEvents(list5),
                  buildAppBar(getDay(5)),
                  bulidListofEvents(list6),
                  buildAppBar(getDay(6)),
                  bulidListofEvents(list7),
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

