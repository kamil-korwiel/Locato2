import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:Locato/Baza_danych/group_helper.dart';
import 'package:Locato/Classes/Group.dart';
import 'package:Locato/Classes/Task.dart';

class AddGroup extends StatefulWidget {
  @override
  _AddGroupState createState() => _AddGroupState();

  ///An object of a Task class.
  Task task;

  ///List of a groups created by user.
  List<Group> listOfGroup;

  AddGroup(this.task, this.listOfGroup);
}

class _AddGroupState extends State<AddGroup> {
  ///Individual key for a Form widget, used to validate user's input.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ///Stores user's input in a TextFormField.
  final _text = TextEditingController();

  ///Stores list of groups from data base.
  List<Group> downloadlist;

  ///Stores list of groups created by user on a group pick page.
  List<Group> list;

  @override
  void initState() {
    downloadlist = List();
    list = List();
    _downloadData();

    super.initState();
  }

  ///Downloads list of groups from data base.
  void _downloadData() {
    GroupHelper.lists().then((onList) {
      if (onList != null) {
        downloadlist = onList;

        if (0 != widget.task.group.id) {
          list.add(widget.task.group);
        }
        downloadlist.removeAt(0);
        downloadlist.forEach((g) {
          if (g.id != widget.task.group.id) {
            list.add(g);
          }
        });

        if (widget.listOfGroup.isNotEmpty) {
          list.addAll(widget.listOfGroup);
        }

        setState(() {});
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dodaj grupę", style: TextStyle(color: Colors.white)),
        leading:
            new IconButton(icon: Icon(Icons.arrow_back), onPressed: goBack),
      ),
      body: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView(children: <Widget>[
            buildSpace(),
            Form(
                key: _formKey,
                child: buildCustomTextFieldwithValidation(
                    "Nowa Grupa", "Wprowadź nazwę nowej grupy", _text)),
            buildSpace(),
            buildCustomButton("Dodaj", add),
            buildSpace(),
            SizedBox(
              height: 300,
              child: ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                buildListTileWithText(list[index].name),
                                buildRemoveButton(index),
                              ],
                            ),
                            color: list[index].isSelected
                                ? Color(0xFF333366)
                                : Colors.transparent,
                            onPressed: () => select(index),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            buildSpace(),
            buildCustomButton("Potwierdź", goBack),
          ])),
    );
  }

  ///Builds a field with a text inside of it.
  Widget buildListTileWithText(String _text) {
    return Container(
      child: Row(
        children: <Widget>[
          Text(" $_text"),
        ],
      ),
    );
  }

  ///Builds a TextFormField with a validation.
  ///Checks if user did fill the field.
  ///On empty field returns a message.
  Widget buildCustomTextFieldwithValidation(

      ///Stores text shown on the label of a TextFormField.
      String label,

      ///Stores text shown inside the TextFormField as a hint.
      String hint,

      ///Used to control user's input.
      TextEditingController control) {
    return TextFormField(
        controller: control,
        decoration: new InputDecoration(
            filled: true,
            fillColor: Color(0xFF333366),
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
            hintStyle: TextStyle(color: Colors.white),
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

  ///Builds a button to remove a group from list.
  Widget buildRemoveButton(

      ///Stores id of a list element.
      int _index) {
    return SizedBox(
      width: 30,
      child: IconButton(
        color: Colors.white,
        icon: Icon(Icons.clear),
        onPressed: () {
          if (list[_index].id != null) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Uwaga"),
                    content: Text(
                        "Usuniecie tego rekordu doprowadzi do przeniesienia innych zadan do 'Brak Grupy'"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          GroupHelper.deleteAndReplaceIdTask(list[_index].id);
                          removeFromList(_index);
                        },
                      ),
                      FlatButton(
                        child: Text("Anuluj"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          } else {
            removeFromList(_index);
          }
        },
      ),
    );
  }

  ///Builds a button used to display every group created by user.
  Widget buildCustomButton(

      ///Stores a text displayed inside the button.
      String text,

      ///Receives a void function which is getting used after button pressed.
      GestureTapCallback onPressed) {
    return RaisedButton(
      color: new Color(0xFF333366),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.white,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        '$text',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  ///Builds a space between widgets in a column.
  Widget buildSpace() {
    return SizedBox(
      height: 10.0,
    );
  }

  ///Takes user to previous page.
  void goBack() {
    widget.listOfGroup.clear();
    list.forEach((g) {
      print("id: ${g.id.toString()} added: ${g.name} bool: ${g.isSelected}");
      if (g.id == null && g.isSelected == false) {
        widget.listOfGroup.add(g);
        print(g.name);
        //addTaskState.setState((){});
      }
    });
    Navigator.pop(context);
  }

  ///Adds a new group with a name typed by user.
  void add() {
    if (_formKey.currentState.validate()) {
//      GroupHelper.add(new Group(name: _text.text));
//      _text.clear();
//      setState(() {});
      list.add(Group(name: _text.text, isSelected: false));
      setState(() {});
    }
  }

  ///Removes an element from a list.
  void removeFromList(

      ///Stores id of a list element.
      int _index) {
    list.removeAt(_index);
    setState(() {});
  }

  ///Marks elemnt from a list choosen by user.
  void select(

      ///Stores id of a list element.
      int _index) {
    if (list[_index].isSelected == true) {
      list[_index].isSelected = false;
      widget.task.group = Group(id: 0);
    } else {
      list.forEach((g) => g.isSelected = false);
      list[_index].isSelected = true;
      widget.task.group = list[_index];
    }

    setState(() {});
  }
}
