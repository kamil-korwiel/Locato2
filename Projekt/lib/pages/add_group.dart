import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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

 // Group newgroup = Group();

  @override
  void initState() {
    super.initState();
  }

  String _value;
  List<Color> _colors = [Colors.grey, Colors.amber[400]];
  List<Group> grouplist = [];
  int currentIndex = 0;
  int length = 0;

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
                grouplist.add(new Group(id: currentIndex, name:_text.text, isSelected: true));
                currentIndex++;
                 length = grouplist.length;
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
                itemCount: length,
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
                                    Text(" " + grouplist[index].name),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    color: grouplist[index].isSelected ? Colors.amber[400] : Colors.grey,
                    onPressed: () => setState(() { 
                      if(grouplist[index].isSelected == false){
                        for(int i = 0; i < grouplist.length; i++) grouplist[i].isSelected = false;
                        grouplist[index].isSelected = true;
                      }
                      else
                      grouplist[index].isSelected = false;
                      })
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

