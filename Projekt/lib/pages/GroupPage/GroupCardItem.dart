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
    if (task.endTime != null) {
      this.date = DateFormat("yyyy-MM-dd hh:mm").format(task.endTime);
    } else {
      this.date = "";
    }
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
                localization.city != null
                    ? Row(
                        children: <Widget>[
                          Icon(Icons.location_on, size: 12.0),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              txt,
                              style: TextStyle(
                                color: Color(0xFFB6B2DF),
                                fontFamily: 'Poppins',
                                fontSize: 12.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),
                // Data zadania
                date.isNotEmpty
                    ? Text(
                        date,
                        style: TextStyle(
                          color: Color(0xFFB6B2DF),
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    : Container(),
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
        children: <Widget>[
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Szczegóły:",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "Opcje:",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.description,
                    size: 18.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      description,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: onPressedEdit,
                  ),
                  SizedBox(width: 4.0),
                  IconButton(
                      icon: Icon(Icons.delete), onPressed: onPressedDelete),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
