import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'add_location.dart';

class HomePageE extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BodyLayout();
  }
}

class BodyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myListView(context);
  }
}

Widget _myListView(BuildContext context) {
  final days = [
    'Poniedzialek',
    'Wtorek',
    'Sroda',
    'Czwartek',
    'Piatek',
    'Sobota',
    'Niedziela'
  ];

  return ListView.builder(
    itemCount: days.length,
    itemBuilder: (context, index) {
      return Card(
        child: ListTile(
          title: Text(days[index]),
          trailing: Icon(Icons.menu),
        ),
      );
    },
  );
}
