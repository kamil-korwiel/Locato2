import 'package:flutter/material.dart';
import 'package:pageview/Baza_danych/task_helper.dart';
import 'package:pageview/Classes/Group.dart';
import 'package:pageview/Classes/Task.dart';

import 'ItemTask.dart';


class ItemGroup extends StatefulWidget {
  @override
  _ItemGroupState createState() => _ItemGroupState();

  Group group;

  ItemGroup(this.group);

}

class _ItemGroupState extends State<ItemGroup> {

  List<Task> _list;
  @override
  void initState() {
    _list = List();
    _downloadData();

    super.initState();
  }

  void _downloadData(){
 //   print("GroupID ${widget.group.id}");
//    TaskHelper.listsID(widget.group.id).then((onList){
      TaskHelper.listsID(widget.group.id).then((onList){
      if(onList != null) {
 //       print("TaskID NotNUll ${onList.length}");
        _list.addAll(onList);
        setState(() {});
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    int donePercent = 100;

    if(_list.isNotEmpty){
      int doneTask = 0;
      _list.forEach((task) {if(task.done){doneTask++;}});

      donePercent = (100 * doneTask/_list.length).round();
    }

    return Stack(
      children: <Widget>[
        Container(
          height: 56,
          decoration: BoxDecoration(
              gradient:  _buildGradient(Colors.orange, Colors.black38, donePercent)
          ),
        ),

        GestureDetector(
          onLongPress: () => print("onLongPress"),
          child: ExpansionTile(
              initiallyExpanded: true,
              title: Text(widget.group.name,         //<=
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 20
                ),
              ),
              trailing: Text(donePercent.toString()+"%",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17
                ),
              ),
              children:  _buildListofTask()//<=
          ),
        ),
      ],
    );

  }




//  List<Widget> _buildListofTask (List<Task> listOfTask){
//
//    List<Widget> listOfWidget  = List();
//
//    for (Task task in listOfTask) {
//
//      listOfWidget.add(ItemTask(task,
//        onPressedDelete: (){
//          //TaskHelper.delete(task.id);
//          setState(() {});
//        },
//        onPressedEdit: (){
//         // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTask(update: task)));
//        },
//        onPressedDone: () {
//          setState(() {
//
//          });
//        },
//      )
//
//      );
//    }
//    return listOfWidget;
//  }

  List<Widget> _buildListofTask (){

    List<ItemTask> listOfWidget  = List();

   // print("List of task ${_list.length}");

    for (int i=0; i< _list.length; i++) {

      listOfWidget.add(ItemTask(_list[i],
        onPressedDelete: (){
          //TaskHelper.delete(task.id);
          setState(() {});
        },
        onPressedEdit: (){
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTask(update: task)));
        },
        onPressedDone: () {

          _list[i].done = !_list[i].done;
//           if(_list[i].done) {
//             _list.insert(_list.length, _list[i]);
//             _list.removeAt(i);
//           }
          setState(() {});
          //_list.forEach((t) => print(t.done));
        },
      )

      );
    }
    return listOfWidget;
  }

  LinearGradient _buildGradient(Color first,Color second,int donePercent){

    return LinearGradient(
      colors: [first, second],
      begin: Alignment.centerLeft,
      stops: [donePercent/100 ,donePercent/100],
      end: Alignment.centerRight,
    );
  }

}





























