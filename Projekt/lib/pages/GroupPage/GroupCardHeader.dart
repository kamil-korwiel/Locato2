import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pageview/Classes/Group.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class GroupCardHeader extends StatelessWidget {
  const GroupCardHeader({Key key, this.group, this.length}) : super(key: key);
  final Group group;
  final int length;

  @override
  Widget build(BuildContext context) {
    //var procent = group.howMuchDone.toDouble() / length.toDouble();
    var procent = 0.7;
    print("Percent " + procent.toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          group.name,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 16.0,
              fontWeight: FontWeight.w600),
        ),
        LinearPercentIndicator(
          width: MediaQuery.of(context).size.width - 75,
          animation: true,
          lineHeight: 20.0,
          animationDuration: 1250,
          percent: procent,
          center: Text((procent * 100.0).toString() + "%"),
          linearStrokeCap: LinearStrokeCap.roundAll,
          progressColor: Color(0xFF00C6FF),
        ),
      ],
    );
  }
}
