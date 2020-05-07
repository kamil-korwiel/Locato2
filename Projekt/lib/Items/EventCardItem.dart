import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pageview/Classes/Event.dart';

class EventCardItem extends StatefulWidget {
  @override
  _EventCardItemState createState() => _EventCardItemState();

  EventCardItem(Event event, {this.onPressedEdit, this.onPressedDelete}) {
    this.name = event.name;
    this.eventStart = DateFormat("hh:mm").format(event.beginTime);
    this.eventEnd = DateFormat("hh:mm").format(event.endTime);
    this.description = event.description;
    //this.is_cyclic
    //this.cycle
    //this.color
  }

  //final Event event;
  String name;
  String eventStart;
  String eventEnd;
  String cycle;
  bool is_cyclic;
  String description;
  Color color;
  final Function onPressedEdit;
  final Function onPressedDelete;
}

class _EventCardItemState extends State<EventCardItem> {
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
                Icon(Icons.event),
              ],
            ),
            SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Nazwa wydarzenia
                Text(
                  widget.name,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // Czas wydarzenia
                Text(
                  widget.eventStart + " - " + widget.eventEnd,
                  style: TextStyle(
                    color: Color(0xffb6b2df),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
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
                  Text(
                    widget.description,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: widget.onPressedEdit,
                  ),
                  SizedBox(width: 4.0),
                  IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: widget.onPressedDelete),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
