import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Locato/Classes/Event.dart';

import 'package:Locato/Baza_danych/event_helper.dart';

import 'package:Locato/pages/Update/update_event.dart';

import '../HomePage.dart';
import 'EventCardItem.dart';

class EventCardEvents extends StatefulWidget {
  EventCardEvents(this.events);

  ///Stores the list of the events for given day.
  List<Event> events;

  @override
  _EventCardEventsState createState() => _EventCardEventsState();
}

class _EventCardEventsState extends State<EventCardEvents> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
//        SizedBox(height: 8.0),
//        Text(
//          "Wydarzenia",
//          style: TextStyle(
//              color: Color(0xffb6b2df),
//              fontFamily: 'Poppins',
//              fontSize: 9.0,
//              fontWeight: FontWeight.w400),
//        ),
        SizedBox(height: 8.0),
        Divider(color: Colors.black54, height: 0.5),

        ///Builds a list of day's events, where single event is defined in EventCardItem class.
        for (var event in widget.events)
          EventCardItem(
            event,

            ///Takes user to page to edit selected event.
            onPressedEdit: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateEvent(event: event),
                ),
              );
            },

            ///Deletes selected event from list and database as well.
            onPressedDelete: () {
              //TODO: DELETE FROM LIST OR DB
              EventHelper.delete(event.id);
              widget.events.remove(event);
              //setState(() {});
              homePageEventsState.refresh();
            },
          ),
      ],
    );
  }
}
