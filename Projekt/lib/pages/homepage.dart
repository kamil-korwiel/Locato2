import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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

  List<Event> l = [
    Event("Event 1",DateTime.now(),DateTime.now(),"a",false,"D7","0x"),
    Event("Event 2",DateTime.now(),DateTime.now(),'b',true,"D7","0x"),
    Event("Event 3",DateTime.now(),DateTime.now(),"c",true,"D7","0x")
  ];

  double heightExtededAppBar = 200.0;
  //ScrollController _scrollController;

  double heightImportantEvent = 80.0;
  double widthImportantEvent = 100.0;

  DateTime _date;

  @override
  void initState() {
    super.initState();
    _date = DateTime.now();
   // _scrollController = ScrollController(initialScrollOffset: heightExtededAppBar - 50);
  }

  String getDay(int day){
    //print(_date.timeZoneOffset);
    int val = (_date.day - 1 + day -_date.timeZoneOffset.inHours )%7;
    return listOfDays[val];
  }

  List<Event> getEventsList(){
    List<Event> list = new List();

    final String opis = "asdghkjashjkghaskjd asudhg kjahsd jkg ajkshdgk kjahg kjhakj akjsdhg kjah skjgfhalsfdg akjsdfg halkjsdhg kaksdjfg hkla" ;
    for (int i=0; i<10; i++){
      list.add(Event("Event $i",_date,_date,opis,true,"D7","0x"));
    }
    return list;

  }

  List<Event> getEventsListDay(int day){
    List<Event> list = new List();



    return list;
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
        return ItemEvent.classevent(item, function: (){
          setState(() {
            l.removeAt(index);
          });
        },);
      },
        childCount: eventsList.length,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
          //controller: _scrollController,
          slivers: <Widget>[
            buildAppBarExtended(getDay(0)),
            bulidListofEvents(l),
            buildAppBar(getDay(1)),
            bulidListofEvents(getEventsListDay(1)),
            buildAppBar(getDay(2)),
            bulidListofEvents(getEventsListDay(2)),
            buildAppBar(getDay(3)),
            bulidListofEvents(getEventsListDay(3)),
            buildAppBar(getDay(4)),
            bulidListofEvents(getEventsListDay(4)),
            buildAppBar(getDay(5)),
            bulidListofEvents(getEventsListDay(5)),
            buildAppBar(getDay(6)),
            bulidListofEvents(getEventsListDay(6)),
          ],
        );


  }
}

