import 'package:flutter/material.dart';

class Calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Text(
          "Kalendarz",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
        child: Icon(Icons.add),
        onPressed: () {
          print('Wcisnieto + na Calendar');
        },
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
