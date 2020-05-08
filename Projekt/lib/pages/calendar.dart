import 'package:flutter/material.dart';
import 'package:pageview/Baza_danych/event_helper.dart';
import 'package:pageview/Classes/Event.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pageview/pages/Update/upgrade_event.dart';
class Calendar extends StatefulWidget {
  //Calendar({Key key}) : super(key:key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<dynamic> _selectedEvents;
  Map<DateTime, List<Event>> _events;
  //Map<DateTime, List> _events2;
  List<Event> _downloadEvents;

  CalendarController _calendarController;
  final DateTime _selectedDay = DateFormat("yyyy-MM-dd").parse(DateFormat("yyyy-MM-dd").format(DateTime.now()));

  @override
  void initState() {
    initializeDateFormatting();
    super.initState();

    _events = Map();
//    _downloadData();
//    _downloadEvents = List();
//    _events = {
//      DateTime(2020, 4, 30): ['Wydarzenie 1'],
//      DateTime(2020, 5, 1): ['Wydarzenie 2', 'Wydarzenie 3', 'Wydarzenie 4'],
//      DateTime(2020, 5, 3): ['Wydarzenie 5', 'Wydarzenie 6'],
//      DateTime(2020, 5, 10): ['Wydarzenie 7'],
//    };
//    _selectedEvents = _events[_selectedDay] ?? [];
    _selectedEvents = List();
    _calendarController = CalendarController();
  }

  void _downloadData() {
    EventHelper.lists().then((onList) {
      if (onList != null) {
        _downloadEvents = onList;
        List<Event> tmpList = List();
        Event e;
        while (_downloadEvents.length != 0) {
          e = _downloadEvents[0];
          tmpList.clear();
          tmpList.addAll(_downloadEvents);
          List<Event> newList = List();
          print("TMPLIST: ${tmpList.length}");
          for (int i = 0; i < tmpList.length; i++) {
            if (e.beginTime.day == tmpList[i].beginTime.day &&
                e.beginTime.month == tmpList[i].beginTime.month &&
                e.beginTime.year == tmpList[i].beginTime.year) {
              newList.add(tmpList[i]);
              print("Downloadlist: ${_downloadEvents.length}");
              _downloadEvents.remove(tmpList[i]);
              print(".");
            }
          }
          tmpList.forEach((e) => print("Events: ${e.name}"));
          _events.addAll({
            DateTime(e.beginTime.year, e.beginTime.month, e.beginTime.day):
                newList
          });
        }
        _events.forEach((date, listString) {
          print(date.toString());
          listString.forEach((s) => print(s.name));
          print("");
        });
        setState(() {});
      }
    });
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: EventHelper.lists(),
        builder: (context, snapshot) {
          if (snapshot.data != null && snapshot.connectionState == ConnectionState.done) {
            _events.clear();
            _downloadEvents = snapshot.data;
            List<Event> tmpList = List();
            Event e;
            while (_downloadEvents.length != 0) {
              e = _downloadEvents[0];
              tmpList.clear();
              tmpList.addAll(_downloadEvents);
              List<Event> newList = List();
              print("TMPLIST: ${tmpList.length}");
              for (int i = 0; i < tmpList.length; i++) {
                if (e.beginTime.day == tmpList[i].beginTime.day &&
                    e.beginTime.month == tmpList[i].beginTime.month &&
                    e.beginTime.year == tmpList[i].beginTime.year) {
                  newList.add(tmpList[i]);
                  print("Downloadlist: ${_downloadEvents.length}");
                  _downloadEvents.remove(tmpList[i]);
                  print(".");
                }
              }
              tmpList.forEach((e) => print("Events: ${e.name}"));
              _events.addAll({
                DateTime(e.beginTime.year, e.beginTime.month, e.beginTime.day):
                newList
              });

            }
            _events.forEach((date, listString) {
              print(date.toString());
              listString.forEach((s) => print(s.name));
              print("");
            });
          }

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
    );
    }

  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarStyle: CalendarStyle(),
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
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];
          if (events.isNotEmpty) {
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

  Widget _buildEventsMarker(DateTime date, List<Event> events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
                ? Colors.brown[300]
                : Colors.blue[400],
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
                  //color: Colors.grey[700],
                  color: Color(0xFF534B83),
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                //child: ListTile(
                //title: Text(event.name),
                //onTap: () => print('${event.name}'),
//            trailing: Row(
//              children: <Widget>[
//                IconButton(icon: Icon(Icons.edit),
//                onPressed: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                      builder: (context) => UpgradeEvent(),
//                    ),
//                  );
//                },
//                ),
//                IconButton(icon: Icon(Icons.delete),
//                onPressed: () {
//
//                },
//                ),
//              ],
//            ),
                //),
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
                          Text(
                            event.name,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            DateFormat("hh:mm").format(event.beginTime) +
                                " - " +
                                DateFormat("hh:mm").format(event.endTime),
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.all(16.0)),
                            Icon(
                              Icons.description,
                              size: 18.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text(
                                event.description,
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
                            Padding(padding: EdgeInsets.all(16.0)),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UpgradeEvent(event: event),
                                  ),
                                );
                              },
                            ),
                            SizedBox(width: 4.0),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                EventHelper.delete(event.id);
                                _selectedEvents.remove(event);
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
