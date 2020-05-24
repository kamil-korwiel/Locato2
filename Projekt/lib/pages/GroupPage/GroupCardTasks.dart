import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Locato/Baza_danych/task_helper.dart';
import 'package:Locato/Classes/Task.dart';
import 'package:Locato/pages/Update/update_task.dart';
import 'GroupCardItem.dart';
import 'GroupPage.dart';

class GroupCardTasks extends StatefulWidget {
  @override
  _GroupCardTasksState createState() => _GroupCardTasksState();

  ///Stores a list of the group's tasks.
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

        ///Builds a list of group's tasks, where single task is defined as GroupCardItem class.
        for (var task in widget.tasks)
          GroupCardItem(
            task,

            ///Mark the task as completed.
            onPressedDone: () {
              if (task.localization.id != 0) {
                if (task.localization.isNearBy == true) {
                  task.done = !task.done;
                  TaskHelper.updateDone(task);
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Nie jesteś bisko miejsca"),
                          content: Text(
                              "Jeśli nie jsteś bisko miejsca zadania nie możesz go zakonczyć"),
                        );
                      });
                }
              } else {
                task.done = !task.done;
                TaskHelper.updateDone(task);
              }
              setState(() {});
              groupCardState.setState(() {});
            },

            ///Takes user to page to edit selected task.
            onPressedEdit: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => UpdateTask(task)));
            },

            ///Deletes selected task from list and database as well.
            onPressedDelete: () {
              TaskHelper.delete(task.id);
              groupCardState.setState(() {});
            },
          ),
      ],
    );
  }
}
