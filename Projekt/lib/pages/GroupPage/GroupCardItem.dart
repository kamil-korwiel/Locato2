import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pageview/Classes/Task.dart';
import 'package:pageview/Classes/Localization.dart';

class GroupCardItem extends StatelessWidget {
  final Function onPressedDone;
  final Function onPressedEdit;
  final Function onPressedDelete;

  String name;
  bool done;
  Localization localization;
  String date;
  String description;

  GroupCardItem(Task task,
      {this.onPressedDone, this.onPressedEdit, this.onPressedDelete}) {
    this.name = task.name;
    this.done = task.done;
    this.date = DateFormat("yyyy-MM-dd hh:mm").format(task.endTime);
    this.localization = task.localization;
    this.description = task.description;
  }

  @override
  Widget build(BuildContext context) {
    var txt = "";
    if (localization.street != null) {
      txt = localization.street;
      if (localization.city != null) {
        txt += ", " + localization.city;
      }
    } else {
      if (localization.city != null) {
        txt = localization.city;
      } else {
        txt = "Brak";
      }
    }

    return ListTileTheme(
      contentPadding: EdgeInsets.all(0),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Nazwa zadanai
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    decoration: done ? TextDecoration.lineThrough : null,
                  ),
                ),
                // Lokalizacja zadania
                Row(
                  children: <Widget>[
                    Icon(Icons.location_on, size: 12.0),
                    Text(
                      txt,
                      style: TextStyle(
                        color: Color(0xFFB6B2DF),
                        fontFamily: 'Poppins',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                // Data zadania
                Text(
                  date,
                  style: TextStyle(
                    color: Color(0xFFB6B2DF),
                    fontFamily: 'Poppins',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: Icon(Icons.done_outline),
                color: done ? Colors.lightGreen[600] : Colors.grey[400],
                onPressed: onPressedDone,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
