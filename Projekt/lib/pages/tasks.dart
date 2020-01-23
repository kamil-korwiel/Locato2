import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'add_location.dart';

class Tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Text('taski'),
      ),
      floatingActionButton: SpeedDial(
        elevation: 10.0,
        animatedIcon: AnimatedIcons.add_event,
        animatedIconTheme: IconThemeData(size: 22.0),
        closeManually: false,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('Otwieram Dial na Tasks'),
        onClose: () => print('Zamykam Dial na Tasks'),
        heroTag: 'speed-dial-hero-tag',
        children: [
          SpeedDialChild(
              child: Icon(Icons.event_note),
              label: 'Wydarzenie',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => print('Dodaj Wydarzenie')),
          SpeedDialChild(
              child: Icon(Icons.check_box),
              label: 'Zadanie',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => print('Dodaj Zadanie')),
          SpeedDialChild(
            child: Icon(Icons.add_location),
            label: 'Lokalizacja',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              print('Dodaj Lokalizacje');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddLocation(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
