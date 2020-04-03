import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pageview/Classes/Group.dart';
import 'package:pageview/pages/add_task.dart';

class AddGroup extends StatefulWidget {
  @override
  _AddGroupState createState() => _AddGroupState();

  Group group;
  AddGroup({this.group});
}

class _AddGroupState extends State<AddGroup> {
  final _text = TextEditingController();

  Group newgroup = Group();

  @override
  void initState() {
    super.initState();
  }

  String _value;
  String _group;
  List<String> groups = ["Grupa A", "Grupa B"];
  List<Color> _colors = [Colors.grey, Colors.amber[400]];
  int _currentIndex = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dodaj cykl"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(children: <Widget>[
            new TextFormField(
              controller: _text,
              decoration: new InputDecoration(
                labelText: "Nowy Cykl",
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
                groups.add(_text.text);
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
                itemCount: groups.length,
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
                                    Text(groups[index]),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    onPressed: () => setState(() {
                      if (_currentIndex == 0) {
                        _currentIndex = 1;
                      } else {
                        _currentIndex = 0;
                      }
                    }),
                    color: _colors[_currentIndex],
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
