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
    list = List();
//    GroupHelper.lists().then((onList) {
//      if(onList != null) {
//        list = onList;
//        setState(() {});
//      }
//    });

    super.initState();
    print(widget.task.idGroup);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dodaj grupę",style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(children: <Widget>[
            Form(
                key: _formKey,
                child: buildCustomTextFieldwithValidation(
                    "Nowa Grupa", "Wprowadź nazwę nowej grupy", _text)),
            buildSpace(),
            buildCustomButton("Dodaj", add),
            buildSpace(),
            FutureBuilder(
                future: GroupHelper.lists(),
                builder: (context, snapshot) {
                  list = snapshot.connectionState == ConnectionState.done
                      ? snapshot.data
                      : list;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          elevation: 5.0,
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    buildListIconTileWithText(
                                        Icons.account_circle, list[index].name)
                                  ],
                                ),
                              ],
                            ),
                          ),
                          color: list[index].id == widget.task.idGroup
                              ? Color(0xFF333366)
                              : Colors.transparent,
                          onPressed: () => select(index),
                        );
                      });
                }),
            buildSpace(),
            buildCustomButton("Potwierdź", goBack),
          ])),
    );
  }

  Widget buildListIconTileWithText(IconData _icon, String _text) {
    return Container(
      child: Row(
        children: <Widget>[
          Icon(
            _icon,
            size: 18.0,
            color: Colors.white,
          ),
          Text(" $_text"),
        ],
      ),
    );
  }

  Widget buildCustomTextFieldwithValidation(
      String label, String hint, TextEditingController control) {
    return TextFormField(
        controller: control,
        decoration: new InputDecoration(
            enabledBorder: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.white)),
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.red),
            ),
            labelText: label,
            labelStyle: TextStyle(color: Colors.white),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey),
            suffixIcon: IconButton(
                icon: Icon(Icons.clear, color: Colors.white),
                onPressed: () {
                  control.clear();
                })),
        keyboardType: TextInputType.text,
        validator: (val) {
          if (val.isEmpty) {
            return 'Pole nie może być puste!';
          }
          return null;
        });
  }

  Widget buildRemoveButton(int _index) {
    return SizedBox(
      child: IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          removeFromList(_index);
        },
      ),
    );
  }

  Widget buildCustomButton(String text, void action()) {
    return RaisedButton(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.white,
        ),
      ),
      onPressed: () {
        action();
      },
      child: Text(
        '$text',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildSpace() {
    return SizedBox(
      height: 10.0,
    );
  }

  void goBack() {
    Navigator.pop(context);
  }

  void add() {
    if (_formKey.currentState.validate()) {
      GroupHelper.add(new Group(name: _text.text));
      _text.clear();
      setState(() {});
    }
  }

  void removeFromList(int _index) {
    list.removeAt(_index);
    setState(() {});
  }

  void select(int _index) {
    setState(() {
      widget.task.idGroup = list[_index].id;
    });
  }
}
