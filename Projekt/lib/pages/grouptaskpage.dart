import 'package:flutter/material.dart';
import 'package:pageview/Baza_danych/group_helper.dart';
import 'package:pageview/Baza_danych/task_helper.dart';
import 'package:pageview/Classes/Group.dart';
import 'package:pageview/Classes/Task.dart';
import 'package:pageview/Items/ItemTask.dart';
import 'dart:async';

import 'add_task.dart';

class GroupTaskPage extends StatefulWidget {

  @override
  _GroupTaskPageState createState() => _GroupTaskPageState();

//  List<Group> listOfGroup;
//
//  GroupTaskPage(){
//    GroupHelper.lists().then((onValue) => this.listOfGroup = onValue);
//  }

}

class _GroupTaskPageState extends State<GroupTaskPage> {

  List<Group> listOfGroup;
  @override
  void initState() {
    listOfGroup = List();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GroupHelper.lists(),
      builder: (context, snapshot) {

          listOfGroup = snapshot.connectionState == ConnectionState.done ? snapshot.data : listOfGroup;


          return CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  _buildWidgetGroup,
                  childCount: listOfGroup.length,
                ),
              ),
            ],

          );
        }


    );
  }






  Widget _buildWidgetGroup(BuildContext context, int index) {
    //int donePercent = listOfGroup[index].
    return FutureBuilder(
      future: TaskHelper.listsID(listOfGroup[index].id),
      builder: (context, snapshot) {

        int donePercent = 100;
        int doneNumbers = 0;

        List<Task> list = List();
        if(snapshot.data != null) {
          list =  snapshot.connectionState == ConnectionState.done ? snapshot.data : list;


        }
        if(list.isNotEmpty){
          list.forEach((t) => doneNumbers = t.done ? doneNumbers+1 : doneNumbers );

          donePercent = (100 * (doneNumbers/list.length)).round();
        }


        return Stack(
          children: <Widget>[
            Container(
              height: 56,
              decoration: BoxDecoration(
                gradient: new LinearGradient(
                  colors: [Colors.green, Colors.blue],
                  begin: Alignment.centerLeft,
                  stops: [donePercent/100 , donePercent <= 0.03 ? 0 : donePercent+0.2],
                  end: Alignment.centerRight,
                ),

//              boxShadow: <BoxShadow>[
//                BoxShadow(
//                  color: Colors.black54,
//                  blurRadius: 3.0,
//                  offset: Offset(0.0, 0.2),
//                ),
//              ]
              ),
            ),
            ExpansionTile(
              initiallyExpanded: true,
              title: Text(listOfGroup[index].name,         //<=
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 20
                ),
              ),
              //backgroundColor: Colors.green,
              trailing: Text(donePercent.round().toString()+"%",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17),
              ),
              children: _buildListofTask(list),  //<=

            ),
          ],
        );

      }
    );
  }

  List<Widget> _buildListofTask (List<Task> listOfTask){

    List<Widget> listOfWidget  = List();

    for (Task task in listOfTask) {
        listOfWidget.add(ItemTask(task,
        onPressedDelete: (){
          TaskHelper.delete(task.id);
          setState(() {});
        },
        onPressedEdit: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTask(update: task)));
        },
        onPressedDone: () {
          setState(() {});
        },
        )

        );
    }

    return listOfWidget;
  }

}