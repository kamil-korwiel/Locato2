import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pageview/pages/add_task.dart';

class AddNotification extends StatefulWidget {
  @override
  _AddNotificationState createState() => _AddNotificationState();

  // Notification notification;
  // AddNotification({this.notification});

}

class _AddNotificationState extends State<AddNotification> {
  List<String> notifications = ["15 minut", "30 minut"];
  List<Color> _colors = [Colors.grey, Colors.amber[400]];
  int _currentIndex = 0;

  final TextEditingController _text = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dodaj powiadomienie"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(children: <Widget>[
            new TextFormField(
              controller: _text,
              decoration: new InputDecoration(
                labelText: "Nowe powiadomienie",
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(0.0),
                  borderSide: new BorderSide(),
                ),
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 10.0,
            ),
            new RaisedButton(
              onPressed: () {
                notifications.add(_text.text);
                _text.clear();
                setState(() {});
              },
              child: Text('Dodaj'),
            ),
            SizedBox(
              height: 10.0,
            ),
            new ListView.builder(
                shrinkWrap: true,
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return RaisedButton(
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.account_circle,
                                      size: 18.0,
                                    ),
                                    Text(notifications[index]),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    onPressed: () => Scaffold
                    .of(context)
                    .showSnackBar(SnackBar(content: Text(notifications[index]))),
              );
                    }),
            SizedBox(
              height: 10.0,
            ),
            new RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Potwierdź'),
            ),
          ])),
    );
  }
}
