import 'package:flutter/material.dart';

class HomePageTest extends StatelessWidget {

  static final List<String> listOfDays = [
    "Poniedziałek",
    "Wtorek",
    "Środa",
    "Czwartek",
    "Piatek",
    "Sobota",
    "Niedziela"
  ];

  DateTime date;
//  List<Task> listofFirstDayTask;
//  List<Task> listofSecondDayTask;
//  List<Task> listofThirdDayTask;
//  List<Task> listofFourthDayTask;
//  List<Task> listofFifthDayTask;
//  List<Task> listofSixthDayTask;
//  List<Task> listofSeventhDayTask;



  HomePageTest() {
    date = DateTime.now();
    /////////////////do skasowanie (do lepszej podmian na SQL-a)////////////////////
//    listofFirstDayTask = [];

  }


  Widget makeAppBar(String header){
    return SliverAppBar(
      pinned: true,
      title: Text(header),
    );
  }

  String getDay(int day){
    int val = (day -1)%7;
    return listOfDays[val];
  }


  Widget dummList(){
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(color: Colors.green, height: 150.0),
          Container(color: Colors.yellowAccent, height: 150.0),
          Container(color: Colors.orange, height: 150.0),
          Container(color: Colors.red, height: 150.0),
        ],
      ),
    );
  }

  List<String> dummlist = [
    "task1",
    "task2",
    "task3",
    "task4",
  ];

  Widget buildList(List<String> taskList){
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          final item = taskList[index];

          return Dismissible(
            key: Key(item),
            child: Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.check_box),
                    title: Text(item),
                  ),
                  //////////////////////////////////
                  Container(
                    // color: Colors.blueGrey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Icon(Icons.pin_drop,size: 20,),
                        Icon(Icons.alarm_on,size: 20),
                        Icon(Icons.inbox,size: 20),
                      ],
                    ),
                  )

                ],
              ),
            ),
          );
        },
        childCount: taskList.length,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        makeAppBar(getDay(date.weekday)),
        buildList(dummlist),
        makeAppBar(getDay(date.weekday + 1)),
        buildList(dummlist),
        makeAppBar(getDay(date.weekday + 2)),
        buildList(dummlist),
        makeAppBar(getDay(date.weekday + 3)),
        buildList(dummlist),
        makeAppBar(getDay(date.weekday + 4)),
        buildList(dummlist),
        makeAppBar(getDay(date.weekday + 5)),
        buildList(dummlist),
        makeAppBar(getDay(date.weekday + 6)),
        buildList(dummlist),
      ],
    );
  }
}
