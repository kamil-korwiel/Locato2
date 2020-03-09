import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pageview/Classes/Group.dart';
import 'package:pageview/Classes/Task.dart';
import 'package:pageview/Items/ItemTask.dart';

class GroupTaskPage extends StatefulWidget {


  @override
  _GroupTaskPageState createState() => _GroupTaskPageState();
}

class _GroupTaskPageState extends State<GroupTaskPage> {

  List<Task> l = [
      Task("Task_1", true, "Torun, ul.Dan", DateTime.now(), 1),
      Task("Task_2", false, "Torun, ul.Dan", DateTime.now(), 1),
      Task("Task_1", true, "Torun, ul.Dan", DateTime.now(), 2),
  ];
  List<Group> lg = [
      Group(1,"Group_1",1),
      Group(2,"Group_2",1),
  ];



  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(delegate: SliverChildBuilderDelegate(
          _buildWidgetGroup,
          childCount:lg.length,
        ),
        ),
      ],

    );
  }

  double getPercent(int id_group){

    int countTask = 0;
    int countTrue = 0;
    for (Task task in l) {
      if(task.group_id == id_group){
        countTask++;
        if(task.done == true)
          countTrue++;
      }
    }

    return (countTrue/countTask)*100;
  }


  Widget _buildWidgetGroup(BuildContext context, int index) {
    double donePercent = getPercent(lg[index].id); //<=
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
          title: Text(lg[index].name,         //<=
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
          children: _buildListofTask(lg[index].id,index),  //<=
        ),
      ],
    );
  }

  List<Widget> _buildListofTask (int id_group,int index){
    List<Widget> listOfWidget = new List<Widget>();

    for (Task task in l) {
      if(task.group_id == id_group)
        listOfWidget.add(ItemTask.classtask(task,function: () {
          setState(() {
            //print(index);
            l.removeAt(index);
          });
        },));
    }

    return listOfWidget;
  }

}