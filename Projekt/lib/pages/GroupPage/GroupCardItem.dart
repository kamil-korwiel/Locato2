import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pageview/Classes/Task.dart';
import 'package:pageview/Classes/Localization.dart';

class GroupCardItem extends StatefulWidget {
  @override
  _GroupCardItemState createState() => _GroupCardItemState();

  GroupCardItem(Task task,
      {this.onPressedDone, this.onPressedEdit, this.onPressedDelete}) {
    this.name = task.name;
    this.done = task.done;
    this.date = DateFormat("yyyy-MM-dd hh:mm").format(task.endTime);
    this.localization = task.localization;
    this.description = task.description;
  }

  final Function onPressedDone;
  final Function onPressedEdit;
  final Function onPressedDelete;

  String name;
  bool done;
  Localization localization;
  String date;
  String description;
}

class _GroupCardItemState extends State<GroupCardItem> {
  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      contentPadding: EdgeInsets.all(0),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                // Nazwa zadanai
                Text(
                  widget.name,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // Lokalizacja zadania
                Row(
                  children: <Widget>[
                    Icon(Icons.location_on, size: 10.0),
                    Text(
                      widget.localization.street +
                          ", " +
                          widget.localization.street,
                      style: TextStyle(
                        color: Color(0xFFB6B2DF),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                // Data zadania
                Text(
                  widget.date,
                  style: TextStyle(
                    color: Color(0xFFB6B2DF),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
