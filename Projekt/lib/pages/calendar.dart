import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

class Calendar extends StatefulWidget {

  //Calendar({Key key}) : super(key:key);

  @override
  _CalendarState createState() => _CalendarState();

}

class _CalendarState extends State<Calendar> {
  List _selectedEvents;
  Map<DateTime, List> _events;

  CalendarController _calendarController;

  @override
  void initState() {
    initializeDateFormatting();
    super.initState();
    final _selectedDay = DateTime.now();

    _events = {
      DateTime(2020, 4, 30): ['Wydarzenie 1'],
      DateTime(2020, 5, 1): ['Wydarzenie 2', 'Wydarzenie 3', 'Wydarzenie 4'],
      DateTime(2020, 5, 3): ['Wydarzenie 5', 'Wydarzenie 6'],
      DateTime(2020, 5, 10): ['Wydarzenie 7'],
    };
    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();

    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedEvents = events;
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return TableCalendar(
  //     calendarStyle: CalendarStyle(

  //     ),
  //     headerStyle: HeaderStyle(
  //       centerHeaderTitle: true,
  //       formatButtonVisible: false,
  //     ),
  //     locale: ('pl' 'PL'),
  //     startingDayOfWeek: StartingDayOfWeek.monday,
  //     calendarController: _calendarController,
  //     onDaySelected: (date, events){
  //       print(date.toIso8601String());
  //     },
  //     builders: CalendarBuilders(
  //       selectedDayBuilder: (context, date, events) =>
  //           Container(
  //             margin: const EdgeInsets.all(5.0),
  //             alignment: Alignment.center,
  //             decoration: BoxDecoration(
  //               color: Colors.orange,
  //               shape: BoxShape.circle,
  //             ),
  //            child: Text(date.day.toString(), style: TextStyle(
  //                color:Colors.white)
  //            )
  //         ),
  //         todayDayBuilder: (context, date, events) =>
  //           Container(
  //             margin: const EdgeInsets.all(5.0),
  //             alignment: Alignment.center,
  //             decoration: BoxDecoration(
  //             color: Colors.red,
  //             shape: BoxShape.circle,
  //             ),
  //             child: Text(date.day.toString(), style: TextStyle(
  //             color:Colors.white)
  //           )
  //         ),
  //         /*dayBuilder: (context, date, events) =>
  //            Text(date.day.toString(), style: TextStyle(
  //              color: Colors.white)
  //            ),
  //            weekendDayBuilder: (context, date, events) =>
  //              Text(date.day.toString(), style: TextStyle(
  //           color: Colors.red)*/
  //         )
  //       //)
  //     );
  // }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTableCalendar(),
          const SizedBox(
            height: 8.0,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarStyle: CalendarStyle(
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      events: _events,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      availableGestures: AvailableGestures.all,
      locale: ('pl' 'PL'),
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarController: _calendarController,
      onDaySelected: (date, events) {
        _onDaySelected(date, events);
        print(date.toIso8601String());
      },
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, events) => Container(
          margin: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red[400],
            shape: BoxShape.circle,
          ),
          child: Text(
            date.day.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
        todayDayBuilder: (context, date, events) => Container(
          margin: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.orange[700],
            shape: BoxShape.circle,
          ),
          child: Text(
            date.day.toString(),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        // dayBuilder: (context, date, events) => Container(
        //   margin: const EdgeInsets.all(5.0),
        //   alignment: Alignment.center,
        //   decoration: BoxDecoration(
        //     color: Colors.amber,
        //     shape: BoxShape.circle,
        //   ),
        //   child: Text(
        //     date.day.toString(),
        //     style: TextStyle(
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        // weekendDayBuilder: (context, date, events) => Container(
        //   margin: const EdgeInsets.all(5.0),
        //   alignment: Alignment.center,
        //   decoration: BoxDecoration(
        //     color: Colors.amber,
        //     shape: BoxShape.circle,
        //   ),
        //   child: Text(
        //     date.day.toString(),
        //     style: TextStyle(
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        markersBuilder: (context, date, events, holidays){
          final children = <Widget>[];
          if(events.isNotEmpty){
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }
          return children;
        },
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events){
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _calendarController.isSelected(date)
          ? Colors.brown[500]
          : _calendarController.isToday(date) ? Colors.brown[300] : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
        .map((event) => Container(
          decoration: BoxDecoration(
            color: Colors.grey[700],
            border: Border.all(width: 0.8),
            borderRadius: BorderRadius.circular(12.0),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: ListTile(
            title: Text(event.toString()),
            onTap: () => print('$event'),
          ),
        ))
        .toList(),
    );
  }
}
