import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pageview/Baza_danych/group_helper.dart';
import 'package:pageview/Classes/Group.dart';
import 'package:pageview/Classes/Task.dart';




class AddGroup extends StatefulWidget {
  @override
  _AddGroupState createState() => _AddGroupState();

  Task task;
  List<Group> listOfGroup;

  AddGroup(this.task,this.listOfGroup);
}

class _AddGroupState extends State<AddGroup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _text = TextEditingController();


  List<Group> downloadlist;
  List<Group> list;

  @override
  void initState() {
    downloadlist = List();
    list = List();
    _downloadData();

    super.initState();
    //print(widget.task.idGroup);
  }

  void _downloadData(){

//    print("lenght of list before ${widget.listOfGroup.length}");
    GroupHelper.lists().then((onList) {
      if(onList != null) {
        downloadlist = onList;

        downloadlist.removeAt(0);

        list.addAll(downloadlist);

        if(widget.task.group.id != 0){
          list.add(widget.task.group);
        }
        if(widget.listOfGroup.isNotEmpty){
          //print("jestem");
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
        // tu kontrolujesz przycisk a
        leading: new IconButton(icon: Icon(Icons.arrow_back), onPressed: onBackPressed),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(children: <Widget>[
            Form(
                key: _formKey,
                child: buildCustomTextFieldwithValidation("Nowa Grupa", "Wprowadź nazwę nowej grupy", _text)),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(width: 30),
                                buildListIconTileWithText(Icons.account_circle, list[index].name),
                                SizedBox(width: 30),
                                buildRemoveButton(index),
                              ],
                            ),
                          ],
                        ),
                      ),
                      color: list[index].isSelected
                          ? Color(0xFF333366)
                          : Colors.transparent,
                      onPressed: () => select(index),
                    );
                  }),
            ),

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
          SizedBox(width: 30),
          Text(" $_text"),
        ],
      ),
    );
  }

  Widget buildCustomTextFieldwithValidation(String label, String hint, TextEditingController control) {
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

  Widget buildRemoveButton(int _index) {
    return SizedBox(
      child: IconButton(
        color: Colors.white,
        icon: Icon(Icons.clear),
        onPressed: () {
          removeFromList(_index);
        },
      ),
    );
  }


  Widget buildCustomButton(String text, void action()) {
    return RaisedButton(
      color: new Color(0xFF333366),
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

    widget.listOfGroup.clear();
    list.forEach((g){
      //print("id: ${g.id} added: ${g.name} bool: ${g.isSelected}");
      if(g.id == null && g.isSelected == false){
        //print("added: ${g.name} bool: ${g.isSelected}");
        widget.listOfGroup.add(g);
      }
    });


//    print("lenght of list after ${widget.listOfGroup.length}");

    Navigator.pop(context);
  }

  void add() {
    if (_formKey.currentState.validate()) {
//      GroupHelper.add(new Group(name: _text.text));
//      _text.clear();
//      setState(() {});
      list.add(Group(name: _text.text));
      setState(() {});
    }
  }

  void removeFromList(int _index) {
    list.removeAt(_index);
    setState(() {});
  }

  void select(int _index) {


    if(list[_index].isSelected == true) {
      list[_index].isSelected = false;
      widget.task.group = Group(id: 0);
    }else{
      list.forEach((g) => g.isSelected = false);
      list[_index].isSelected = true;
      widget.task.group = list[_index];
    }


    setState(() {});

  }

  void onBackPressed() {
    goBack();
  }
}