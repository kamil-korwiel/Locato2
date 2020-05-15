import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pageview/Baza_danych/task_helper.dart';
import 'package:pageview/Classes/Group.dart';
import 'package:pageview/Classes/Task.dart';
import 'package:pageview/pages/GroupPage/GroupCardHeader.dart';
import 'package:pageview/pages/GroupPage/GroupCardTasks.dart';

//_GroupCardState groupCardState;

class GroupCard extends StatefulWidget {
//  _GroupCardState createState() {
//    groupCardState = _GroupCardState();
//    return groupCardState;
//  }
  @override
  _GroupCardState createState() => _GroupCardState();
  Group group;

  GroupCard(this.group);
}

class _GroupCardState extends State<GroupCard> {
  List<Task> _list;
  int doneTasks = 0;

  @override
  void initState() {
    _list = List();
//    _downloadData();

    super.initState();
  }

//  void _downloadData() {
//    TaskHelper.listsID(widget.group.id).then((onList) {
//      if (onList != null) {
//        _list.addAll(onList);
//        setState(() {});
//      }
//    });
//  }

  // Stary build bez FutureBuild ~Filip
  /*@override
  Widget build(BuildContext context) {
    if (_list.isNotEmpty) {
      doneTasks = 0;
      _list.forEach((task) {
        if (task.done) doneTasks++;
      });
    }
    return Container(
      // Odstep miedzy grupami
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      decoration: new BoxDecoration(
        color: new Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Divider(
            color: Colors.black12,
            height: 0.5,
          ),
          _buildContent(),
          Divider(
            color: Colors.black12,
            height: 0.5,
          ),
        ],
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    doneTasks = 0;
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
              doneTasks = 0;
              if (_list.isNotEmpty) {
                _list.forEach((task) {
                  if (task.done) doneTasks++;
                });
              }
              return Container(
                // Odstep miedzy grupami
                margin:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                decoration: new BoxDecoration(
                  color: new Color(0xFF333366),
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.circular(8.0),
                  boxShadow: <BoxShadow>[
                    new BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      offset: new Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Divider(
                      color: Colors.black12,
                      height: 0.5,
                    ),
                    _buildContent(),
                    Divider(
                      color: Colors.black12,
                      height: 0.5,
                    ),
                  ],
                ),
              );
            }
        }
        return Container();
      },
    );
  }

  Widget _buildContent() {
    return Container(
        margin: new EdgeInsets.fromLTRB(20.0, 16.0, 16.0, 16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GroupCardHeader(widget.group, doneTasks, _list.length),
            SizedBox(height: 3.0),
            Container(
              margin: new EdgeInsets.symmetric(vertical: 8.0),
              height: 2.0,
              width: 20.0,
              color: new Color(0xFF00C6FF),
            ),
            if (_list.isNotEmpty) GroupCardTasks(_list),
          ],
        ));
  }
}
