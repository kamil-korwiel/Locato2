import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:pageview/Baza_danych/group_helper.dart';
import 'package:pageview/Classes/Group.dart';
import 'package:pageview/Classes/Task.dart';
import 'package:pageview/pages/add_task.dart';

class AddGroup extends StatefulWidget {
  @override
  _AddGroupState createState() => _AddGroupState();

  Task task;

  AddGroup({@required this.task});
}


class _AddGroupState extends State<AddGroup> {
  final _text = TextEditingController();



  @override
  void initState() {
    super.initState();
    print(widget.task.idGroup);
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dodaj grupę"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(children: <Widget>[
            new TextFormField(
              controller: _text,
              decoration: new InputDecoration(
                labelText: "Nowa Grupa",
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
                GroupHelper.add(new Group(name: _text.text));
                _text.clear();
                setState(() {});
              },
              child: Text('Dodaj'),
            ),
            SizedBox(
              height: 10.0,
            ),
            FutureBuilder(
                future: GroupHelper.lists(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    List<Group> list = List();

                    if (snapshot.data != null) {
                      list = snapshot.data;
                    }
                    return new ListView.builder(
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return RaisedButton(
                              child: Container(
                                alignment: Alignment.center,
                                height: 50.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
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
                                              Text(" " + list[index].name),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              color: list[index].id == widget.task.idGroup ? Colors
                                  .amber[400] : Colors.grey,

                              onPressed: () =>
                                  setState(() {
                                    widget.task.idGroup = list[index].id;
                                  })
                          );
                        });
                  }
                  else {
                    return Container();
                  }
                }
            ),

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

