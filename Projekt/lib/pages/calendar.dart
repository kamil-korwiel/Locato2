import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();

}

class _CalendarState extends State<Calendar> {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();

    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarStyle: CalendarStyle(

      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      locale: ('pl' 'PL'),
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarController: _calendarController,
      onDaySelected: (date, events){
        print(date.toIso8601String());
      },
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, events) =>
            Container(
              margin: const EdgeInsets.all(5.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
             child: Text(date.day.toString(), style: TextStyle(
                 color:Colors.white)
             )
          ),
          todayDayBuilder: (context, date, events) =>
            Container(
              margin: const EdgeInsets.all(5.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              ),
              child: Text(date.day.toString(), style: TextStyle(
              color:Colors.white)
            )
          ),
          /*dayBuilder: (context, date, events) =>
             Text(date.day.toString(), style: TextStyle(
               color: Colors.white)
             ),
             weekendDayBuilder: (context, date, events) =>
               Text(date.day.toString(), style: TextStyle(
            color: Colors.red)*/
          )
        //)
      );
  }
}
