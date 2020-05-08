import 'package:flutter/material.dart';
import 'package:pageview/Baza_danych/group_helper.dart';
import 'package:pageview/Classes/Group.dart';
import 'GroupCard.dart';
import 'ItemGroup.dart';

_GroupTaskPageState groupCardState;

class GroupTaskPage extends StatefulWidget {
  @override
  _GroupTaskPageState createState() {
    groupCardState = _GroupTaskPageState();
    return groupCardState;
  }
}

class _GroupTaskPageState extends State<GroupTaskPage> {
  List<Group> listOfGroup;
  @override
  void initState() {
    listOfGroup = List();
    //_downloadData();

    super.initState();
  }

  void _downloadData() {
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@GroupPage downloadData");
    GroupHelper.lists().then((onList) {
      if (onList != null) {
        listOfGroup = onList;
        setState(() {});
      }
    });
  }

  // Kamil build + Filip zmiany
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: GroupHelper.lists(),
        builder: (context, snapshot) {
          listOfGroup = snapshot.connectionState == ConnectionState.done
              ? snapshot.data
              : listOfGroup;

          return CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => GroupCard(
                    listOfGroup[index],
                  ),
                  childCount: listOfGroup.length,
                ),
              ),
            ],
          );
        });
  }

  // Filip build - dzialajacy
  /*@override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => GroupCard(
              listOfGroup[index],
            ),
            childCount: listOfGroup.length,
          ),
        ),
      ],
    );
  }*/

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

}
