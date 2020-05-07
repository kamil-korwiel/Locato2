import 'package:flutter/material.dart';
import 'package:pageview/Baza_danych/group_helper.dart';
import 'package:pageview/Classes/Group.dart';

import 'ItemGroup.dart';


class GroupTaskPage extends StatefulWidget {

  @override
  _GroupTaskPageState createState() => _GroupTaskPageState();

}

class _GroupTaskPageState extends State<GroupTaskPage> {

  List<Group> listOfGroup;
  @override
  void initState() {
    listOfGroup = List();
    //_downloadData();

    super.initState();
  }

  void _downloadData(){
    GroupHelper.lists().then((onList) {
      if(onList != null) {
        listOfGroup = onList;
        setState(() {});
      }
    });
  }

//  @override
//  Widget build(BuildContext context) {
//
//    return CustomScrollView(
//      slivers: <Widget>[
//        SliverList(
//          delegate: SliverChildBuilderDelegate(
//                (context , index){
//              return ItemGroup(listOfGroup[index]);
//            },
//            childCount: listOfGroup.length,
//          ),
//        ),
//      ],
//
//    );
//  }



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
                      (context , index){
                    return ItemGroup(listOfGroup[index]);
                  },
                  childCount: listOfGroup.length,
                ),
              ),
            ],

          );
        }
    );
  }

}