import 'package:flutter/material.dart';
import 'package:pageview/Baza_danych/group_helper.dart';
import 'package:pageview/Baza_danych/task_helper.dart';
import 'package:pageview/Classes/Group.dart';
import 'package:pageview/Classes/Task.dart';
import 'package:pageview/pages/Update/upgrade_task.dart';

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
   // _downloadData();

    super.initState();
  }

  void _downloadData(){

      TaskHelper.listsID(widget.group.id).then((onList){
      if(onList != null) {
        _list.addAll(onList);
        setState(() {});
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: TaskHelper.listsID(widget.group.id),
      builder: (context, snapshot) {


        switch (snapshot.connectionState) {
          case ConnectionState.none:
          // return Container();
          case ConnectionState.waiting:
          // return Container();
          case ConnectionState.active:
          case ConnectionState.done:
            _list = snapshot.data;
            if (_list != null) {

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
                        gradient: _buildGradient(
                            Colors.orange, Colors.black38, donePercent)
                    ),
                  ),

                  GestureDetector(
                    onLongPress: () {
//                      // TODO: DAREK TUTAJ Pownno wyświetlić czy chcesz usunąć Grupę
//
//                      if(widget.group.id != 0) {
//                        GroupHelper.deleteAndChangeIdInTask(
//                            widget.group.id, _list);
//
//                        print("onLongPress");
//                        Scaffold.of(context).setState((){});
//                      }
                    },
                    child: ExpansionTile(
                        initiallyExpanded: true,
                        title: Text(widget.group.name, //<=
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 20
                          ),
                        ),
                        trailing: Text(donePercent.toString() + "%",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17
                          ),
                        ),
                        children: _buildListofTask() //<=
                    ),
                  ),
                ],
              );
            }
        }
        return Container();
      }
    );

  }



//  @override
//  Widget build(BuildContext context) {
//    int donePercent = 100;
//
//    if(_list.isNotEmpty){
//      int doneTask = 0;
//      _list.forEach((task) {if(task.done){doneTask++;}});
//
//      donePercent = (100 * doneTask/_list.length).round();
//    }
//
//    return Stack(
//      children: <Widget>[
//        Container(
//          height: 56,
//          decoration: BoxDecoration(
//              gradient:  _buildGradient(Colors.orange, Colors.black38, donePercent)
//          ),
//        ),
//
//        GestureDetector(
//          onLongPress: () {
//              // TODO: DAREK TUTAJ Pownno wyświetlić czy chcesz usunąć Grupę
//              print("onLongPress");
//
//            },
//          child: ExpansionTile(
//              initiallyExpanded: true,
//              title: Text(widget.group.name,         //<=
//                style: TextStyle(
//                    fontWeight: FontWeight.w600,
//                    color: Colors.white,
//                    fontSize: 20
//                ),
//              ),
//              trailing: Text(donePercent.toString()+"%",
//                style: TextStyle(
//                    color: Colors.white,
//                    fontSize: 17
//                ),
//              ),
//              children:  _buildListofTask()//<=
//          ),
//        ),
//      ],
//    );
//
//  }
//

  List<Widget> _buildListofTask (){

    List<ItemTask> listOfWidget  = List();

   // print("List of task ${_list.length}");

    for (int i=0; i< _list.length; i++) {

      listOfWidget.add(ItemTask(_list[i],
        onPressedDelete: (){
          //TODO: DELETE FROM LIST OR DB
          TaskHelper.delete(_list[i].id);
          setState(() {});
        },
        onPressedEdit: (){
           Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpgradeTask(_list[i])));
        },
        onPressedDone: () {
          _list[i].done = !_list[i].done;
          TaskHelper.updateDone(_list[i]);
          setState(() {});
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





























