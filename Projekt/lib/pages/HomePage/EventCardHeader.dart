import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventCardHeader extends StatelessWidget {
  const EventCardHeader({Key key, this.day}) : super(key: key);

  ///Store a Polish name of the day.
  final String day;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ///Builds a name of the day sectore, where list of events will be stored.
        Text(
          day,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 18.0,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
