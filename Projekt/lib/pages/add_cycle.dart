import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pageview/pages/add_event.dart';

class AddCycle extends StatefulWidget {
  @override
  _AddCycleState createState() => _AddCycleState();

 // Cycle cycle;
 // AddCycle({this.cycle});
}

class _AddCycleState extends State<AddCycle> {

  List<String> cycles = ["Codziennie", "co tydzień"];
  final TextEditingController _text = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dodaj cykl"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
              child: ListView(
                  children: <Widget>[
                    new TextFormField(
                      controller: _text,
                      decoration: new InputDecoration(
                        labelText: "Nowy Cykl",
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
                    new RaisedButton(
                      onPressed: () {
                        cycles.add(_text.text);
                        _text.clear();
                        setState(() {});
                      },
                      child: Text('Dodaj'),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    new ListView.builder(shrinkWrap: true,
                     itemCount: cycles.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Center(child: Text(cycles[index]))
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
  }}