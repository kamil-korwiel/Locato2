import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventCardHeader extends StatelessWidget {
  const EventCardHeader({Key key, this.day}) : super(key: key);
  final String day;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
