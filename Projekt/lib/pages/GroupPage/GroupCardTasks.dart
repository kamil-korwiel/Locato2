import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pageview/Baza_danych/task_helper.dart';
import 'package:pageview/Classes/Task.dart';
import 'package:pageview/pages/GroupPage/GroupCard.dart';
import 'GroupCardItem.dart';

class GroupCardTasks extends StatefulWidget {
  @override
  _GroupCardTasksState createState() => _GroupCardTasksState();

  List<Task> tasks;

  GroupCardTasks(this.tasks);
}

class _GroupCardTasksState extends State<GroupCardTasks> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: 2.0),
        Text(
          "Zadania",
          style: TextStyle(
              color: Color(0xFFB6B2DF),
              fontFamily: 'Poppins',
              fontSize: 9.0,
              fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 8.0),
        Divider(color: Colors.black54, height: 0.5),
        for (var task in widget.tasks)
          GroupCardItem(
            task,
            onPressedDone: () {
              task.done = !task.done;
              TaskHelper.update(task);
              groupCardState.setState(() {});
            },
            onPressedEdit: () {},
            onPressedDelete: () {
              setState(() {});
            },
          ),
      ],
    );
  }
}
