import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:pageview/Baza_danych/group_helper.dart';
import 'package:pageview/Classes/Group.dart';
import 'package:pageview/Classes/Task.dart';
import 'package:pageview/pages/add_task.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class AddGroup extends StatefulWidget {
  @override
  _AddGroupState createState() => _AddGroupState();

  Task task;

  AddGroup({@required this.task});
}

class _AddGroupState extends State<AddGroup> {
  final _text = TextEditingController();

  List<Group> list;

  @override
  void initState() {
    GroupHelper.lists().then((onList) {
      if(onList == null) {
        list = onList;
        setState(() {});
      }
    });

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
            Form(
              key: _formKey,
              child: new TextFormField(
                controller: _text,
                decoration: new InputDecoration(
                  labelText: "Nowa Grupa",
                ),
                keyboardType: TextInputType.text,
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Pole nie może być puste!';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            new RaisedButton(
              onPressed: () {
                if(_formKey.currentState.validate()) {
                  GroupHelper.add(new Group(name: _text.text));
                  _text.clear();
                  setState(() {});
                }
              },
              child: Text('Dodaj'),
            ),
            SizedBox(
              height: 10.0,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
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
                                      Text(" " + list[index].name),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      color: list[index].id == widget.task.idGroup
                          ? Colors.amber[400]
                          : Colors.grey,
                      onPressed: () => setState(() {
                            widget.task.idGroup = list[index].id;
                          }));
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
