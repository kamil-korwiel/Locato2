import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pageview/Classes/Group.dart';

class GroupCardHeader extends StatelessWidget {
  var procent = 0.1;
  Group group;
  int length;
  int howMuchDone;

  GroupCardHeader(this.group, this.howMuchDone, this.length);

  @override
  Widget build(BuildContext context) {
    if (howMuchDone == 0) {
      procent = 0;
    } else {
      procent = howMuchDone / length;
    }

    print("Percent " + procent.toString());
    print("howmuchdone" + howMuchDone.toString() + "/" + length.toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              group.name,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              howMuchDone.toString() + " / " + length.toString(),
              style: TextStyle(
                  color: Colors.white70,
                  fontFamily: 'Poppins',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
        SizedBox(height: 2.0),
        Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 20.0,
              decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10.0)),
            ),
            Material(
              borderRadius: BorderRadius.circular(10.0),
              child: AnimatedContainer(
                constraints: BoxConstraints(
                  minWidth: 0.0,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                height: 20.0,
                width: MediaQuery.of(context).size.width * procent,
                //width: 10,
                duration: Duration(milliseconds: 1250),
                decoration: BoxDecoration(
                  color: Color(0xFF00C6FF),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            Center(
              child: Text(
                (procent * 100).toStringAsFixed(1) + "%",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
