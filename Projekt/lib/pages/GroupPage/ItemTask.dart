import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pageview/Classes/Task.dart';



class ItemTask extends StatelessWidget {


  final Function onPressedEdit;
  final Function onPressedDelete;
  final Function onPressedDone;

  String name;
  bool done;
  String where;
  String date;
  String description;

  //ItemTask(String this.name,bool this.done,String this.date,String this.where);
  ItemTask(Task task, {this.onPressedEdit, this.onPressedDelete, this.onPressedDone}) {
    this.name = task.name;
    this.done = task.done;
    this.date = DateFormat("yyyy-MM-dd hh:mm").format(task.endTime);
    this.where = "${task.localization.name.toString()} / ${task.localization.city.toString()}, ${task.localization.street.toString()}";
    this.description = task.description;
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {},
      child: ExpansionTile(
        title: Text( name),
        trailing: _buildCheckBox(),
        children: <Widget>[
          _buildDescription(),
          _buildIconAndString(Icons.event,  date),
          _buildIconAndString(Icons.pin_drop,  where),
          _buildEditAndDeleteButton(),
        ],
      ),
    );
  }


  Widget _buildCheckBox() {
    return IconButton(
      //color: Colors.greenAccent,
      icon:  done ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank),
      onPressed:  onPressedDone,
    );
  }

  Widget _buildIconAndString(IconData icon, String text) {
    return Row(
      children: <Widget>[
        Icon(icon),
        Text(text)
      ],
    );
  }

  Widget _buildEditAndDeleteButton(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(
            child: FlatButton(
                child: Icon(Icons.edit),
                //color: Colors.blueAccent,
                onPressed:  onPressedEdit
            )
        ),
        Expanded(
            child: FlatButton(
                child: Icon(Icons.delete),
                //  color: Colors.redAccent,
                onPressed:  onPressedDelete
            )
        ),
      ],
    );
  }

  Widget _buildDescription(){
    return Center(
      child: Text( description),
    );
  }

}