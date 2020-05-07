import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pageview/Classes/Event.dart';
import 'package:pageview/Items/EventCardItem.dart';
import 'package:pageview/Baza_danych/event_helper.dart';
import 'package:pageview/pages/Add/add_event.dart';
import 'package:pageview/pages/Update/upgrade_event.dart';

class EventCardEvents extends StatefulWidget {
  EventCardEvents(this.events);

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
        for (var event in widget.events)
          EventCardItem(
            event,
            onPressedEdit: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpgradeEvent(event: event),
                ),
              );
            },
            onPressedDelete: () {
              //TODO: DELETE FROM LIST OR DB
              EventHelper.delete(event.id);
              widget.events.remove(event);
              setState(() {});
            },
          ),
      ],
    );
  }
}
