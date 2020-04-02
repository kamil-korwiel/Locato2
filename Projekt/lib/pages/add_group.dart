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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dodaj grupę"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
              child: ListView(
//            mainAxisSize: MainAxisSize.max,
//            mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new TextFormField(
                      controller: _text,
                      decoration: new InputDecoration(
                        labelText: "Nazwa nowej grupy",
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(0.0),
                          borderSide: new BorderSide(
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    new DropdownButton<String>(
                      isExpanded: true,
                      items: [
                        DropdownMenuItem<String>(
                          child: Text('Grupa 1'),
                          value: 'one',
                        ),
                        DropdownMenuItem<String>(
                          child: Text('Grupa 2'),
                          value: 'two',
                        ),
                        DropdownMenuItem<String>(
                          child: Text('Grupa 3'),
                          value: 'three',
                        ),
                      ],
                      onChanged: (String value) {
                        setState(() {
                          _value = value;
                        });
                      },
                      hint: Text('Wybierz istniejącą grupę'),
                      value: _value,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    new RaisedButton(
                      onPressed: () {

                        Navigator.pop(context);
                      },
                      child: Text('Dodaj'),
                    ),
                  ]))),
    );
  }}