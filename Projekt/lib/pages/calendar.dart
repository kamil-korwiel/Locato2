import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Text(
          "Kalendarz",
        ),
      ),
      floatingActionButton: SpeedDial(
        elevation: 10.0,
        animatedIcon: AnimatedIcons.add_event,
        animatedIconTheme: IconThemeData(size: 22.0),
        closeManually: false,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('Otwieram Dial na Calendar'),
        onClose: () => print('Zamykam Dial na Calendar'),
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
              onTap: () => print('Dodaj Lokalizacje')),
        ],
      ),
      /*drawer: Drawer(
        elevation: 16.0,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('xyz'),
              accountEmail: Text('xyz@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text('xyz'),
              ),
              otherAccountsPictures: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text('xyz'),
                )
              ],
            ),
            ListTile(
              title: new Text('Cos waznego'),
              leading: new Icon(Icons.refresh),
            ),
            Divider(
              height: 0.1,
            ),
            ListTile(
              title: new Text('Cos mniej waznego'),
              leading: new Icon(Icons.important_devices),
            ),
            ListTile(
              title: new Text('Cos mniej waznego v2'),
              leading: new Icon(Icons.warning),
            ),
            ListTile(
              title: new Text('Ustawienia'),
              leading: new Icon(Icons.settings),
            )
          ],
        ),
      ),*/
    );
  }
}
