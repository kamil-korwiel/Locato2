import 'package:flutter/material.dart';
import 'package:Locato/Baza_danych/group_helper.dart';
import 'package:Locato/Classes/Group.dart';
import 'GroupCard.dart';

///Stores state of GroupPage class, if changed rebuild widget.
_GroupTaskPageState groupCardState;

class GroupTaskPage extends StatefulWidget {
  @override
  _GroupTaskPageState createState() {
    groupCardState = _GroupTaskPageState();
    return groupCardState;
  }
}

class _GroupTaskPageState extends State<GroupTaskPage> {
  ///Stores a list of all groups.
  List<Group> listOfGroup;
  @override
  void initState() {
    listOfGroup = List();
    //_downloadData();

    super.initState();
  }

  void _downloadData() {
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
          ///Download data from database.
          listOfGroup = snapshot.connectionState == ConnectionState.done
              ? snapshot.data
              : listOfGroup;

          return CustomScrollView(
            slivers: <Widget>[
              SliverList(
                ///Builds a list of all groups, where single group is declared as GroupCard class.
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
