import 'package:flutter/material.dart';
import 'package:pageview/Classes/Task.dart';
class ItemTask extends StatefulWidget {
  @override
  _ItemTaskState createState() => _ItemTaskState();

  final Function function;

  String name;
  bool done;
  String where;
  DateTime date;

  ItemTask(String this.name,bool this.done,DateTime this.date,String this.where,{this.function});
  ItemTask.classtask(Task task,{this.function}){
    this.name = task.name;
    this.done = task.done;
    this.date = task.date;
    this.where = task.where;
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
                  onPressed: () {},
                )
            ),
            Expanded(
                child:  FlatButton(
                  child: Icon(Icons.delete),
                  color: Colors.redAccent,
                  onPressed: widget.function,
                )
            ),
          ],

        )
      ],
    );
  }
}