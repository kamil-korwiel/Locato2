import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Locato/Classes/Event.dart';

class EventCardItem extends StatefulWidget {
  @override
  _EventCardItemState createState() => _EventCardItemState();

  EventCardItem(Event event, {this.onPressedEdit, this.onPressedDelete}) {
    this.name = event.name;
    this.eventStart = DateFormat("HH:mm").format(event.beginTime);
    this.eventEnd = DateFormat("HH:mm").format(event.endTime);
    this.description = event.description;
    //this.is_cyclic
    //this.cycle
    //this.color
  }
  //final Event event;

  ///Stores name of a event.
  String name;

  ///Stores a date when the events starts.
  String eventStart;

  ///Stores a date when the event ends.
  String eventEnd;

  ///Stores a cycle of the event.
  String cycle;

  ///Stores a true value if event is cyclic, false if otherwise.
  bool is_cyclic;

  ///Stores a description of the event.
  String description;

  ///Stores colour of a event.
  Color color;

  ///Stores declaration of function, responsible to take user to edit page.
  final Function onPressedEdit;

  ///Stores declaration of function responsible for deletion of event.
  final Function onPressedDelete;
}

class _EventCardItemState extends State<EventCardItem> {
  @override
  Widget build(BuildContext context) {
    ///Builds a ExpansionTile.
    ///Initially it shows only name and date of event.
    ///On expanded shows event description and buttons to edit or delete event.
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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      widget.description,
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
                  ///Builds a edit button.
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: widget.onPressedEdit,
                  ),
                  SizedBox(width: 4.0),

                  ///Builds a delete button.
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
