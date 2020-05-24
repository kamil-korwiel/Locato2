import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Locato/Classes/Event.dart';

import 'EventCardEvents.dart';
import 'EventCardHeader.dart';

class EventCard extends StatelessWidget {
  ///Stores a Polish name of day.
  String day;

  ///Stores a list of events for given day.
  List<Event> events;

  EventCard(this.day, this.events);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Odstep miedzy dniami
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      decoration: new BoxDecoration(
        color: new Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Divider(
            color: Colors.black12,
            height: 0.5,
          ),
          _buildContent(),
          Divider(
            color: Colors.black12,
            height: 0.5,
          ),
        ],
      ),
    );
  }

  ///Builds a content of the day's event card.
  ///Starting with the header and then if not empty - list of the events for given day.
  Widget _buildContent() {
    return Container(
      margin: new EdgeInsets.fromLTRB(20.0, 16.0, 16.0, 16.0),
      //constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          EventCardHeader(day: day),
          SizedBox(height: 10.0),
          Container(
            margin: new EdgeInsets.symmetric(vertical: 8.0),
            height: 2.0,
            width: 20.0,
            color: new Color(0xff00c6ff),
          ),
          if (events.isNotEmpty) EventCardEvents(events),
        ],
      ),
    );
  }
}
