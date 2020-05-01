import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pageview/Baza_danych/task_helper.dart';
import 'package:pageview/Classes/Task.dart';
import 'package:pageview/pages/add_task.dart';
class ItemTask extends StatefulWidget {
  @override
  _ItemTaskState createState() => _ItemTaskState();

  final Function onPressedEdit;
  final Function onPressedDelete;
  final Function onPressedDone;

  Task task;

  String name;
  bool done;
  String where;
  String date;

  //ItemTask(String this.name,bool this.done,String this.date,String this.where);
  ItemTask(Task task,{this.onPressedEdit,this.onPressedDelete,this.onPressedDone}){
    this.name = task.name;
    this.done = task.done;
    this.date =  DateFormat("yyyy-MM-dd hh:mm").format(task.endTime);
    this.where = "TO DO";
    this.task = task;
  }

}

class _ItemTaskState extends State<ItemTask> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.name),
      trailing: IconButton(
        //color: Colors.greenAccent,
        icon: widget.done ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank),
        onPressed: () => setState(() {
          widget.done ? widget.done = false :  widget.done = true;
          widget.onPressedDone;
        }),
      ),
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.pin_drop),
            Text(widget.where)
          ],
        ),
        Row(
          children: <Widget>[
            Icon(Icons.hourglass_empty),
            Text(widget.date.toString())
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
                child: FlatButton(
                  child: Icon(Icons.edit),
                  color: Colors.blueAccent,
                  onPressed: widget.onPressedEdit
                )
            ),
            Expanded(
                child:  FlatButton(
                  child: Icon(Icons.delete),
                  color: Colors.redAccent,
                  onPressed: widget.onPressedDelete
                )
            ),
          ],

        )
      ],
    );
  }
}