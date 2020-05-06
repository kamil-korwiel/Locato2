import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pageview/Classes/Task.dart';
import 'GroupCardItem.dart';

class GroupCardTasks extends StatelessWidget {
  const GroupCardTasks(this.tasks);
  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: 8.0),
        Text(
          "Zadania",
          style: TextStyle(
              color: Color(0xFFB6B2DF),
              fontFamily: 'Poppins',
              fontSize: 9.0,
              fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 8.0),
        Divider(color: Colors.black12, height: 0.5),
        for (var task in tasks)
          GroupCardItem(task,
              onPressedDone: () {},
              onPressedEdit: () {},
              onPressedDelete: () {}),
      ],
    );
  }
}
