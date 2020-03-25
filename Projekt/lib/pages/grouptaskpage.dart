import 'package:flutter/material.dart';
import 'package:pageview/Baza_danych/group_helper.dart';
import 'package:pageview/Baza_danych/task_helper.dart';
import 'package:pageview/Classes/Group.dart';
import 'package:pageview/Classes/Task.dart';
import 'package:pageview/Items/ItemTask.dart';
import 'dart:async';

class GroupTaskPage extends StatefulWidget {

  @override
  _GroupTaskPageState createState() => _GroupTaskPageState();

  List<Group> listOfGroup;

  GroupTaskPage(){
    GroupHelper.lists().then((onValue) => this.listOfGroup = onValue);
  }

}

class _GroupTaskPageState extends State<GroupTaskPage> {


  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            _buildWidgetGroup,
            childCount: widget.listOfGroup.length,
        ),
        ),
      ],

    );
  }




  Widget _buildWidgetGroup(BuildContext context, int index) {
    int donePercent = GroupHelper.getPercent(widget.listOfGroup[index].id) as int; //<=
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
          title: Text(widget.listOfGroup[index].name,         //<=
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
          children: _buildListofTask(widget.listOfGroup[index].id,index),  //<=
        ),
      ],
    );
  }

  List<Widget> _buildListofTask (int id_group,int index){

    List<Widget> listOfWidget = new List<Widget>();
    List<Task> listOfTask = TaskHelper.listsID(id_group) as List<Task>;

    for (Task task in listOfTask) {
        listOfWidget.add(ItemTask.classtask(task));
    }

    return listOfWidget;
  }

}