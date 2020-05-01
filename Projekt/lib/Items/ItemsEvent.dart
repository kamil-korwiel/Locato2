import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pageview/Baza_danych/event_helper.dart';
import 'package:pageview/Classes/Event.dart';
import 'package:pageview/pages/add_event.dart';

class ItemEvent extends StatefulWidget {
  @override
  _ItemEventState createState() => _ItemEventState();

  final Function onPressedEdit;
  final Function onPressedDelete;

  String name;
  String eventStarts;
  String eventEnds;
  String cycle;
  bool is_cyclic;
  String description;
  Event event;
  Color color;

  //ItemEvent(String this.name,String this.eventStarts ,String this.eventEnds,String this.description,bool this.is_cyclic, String this.cycle, Color this.color,{this.function});
  ItemEvent(Event event, {this.onPressedEdit,this.onPressedDelete}){
    this.name = event.name;
    this.eventStarts = DateFormat("yyyy-MM-dd hh:mm").format(event.beginTime);
    this.eventEnds = DateFormat("yyyy-MM-dd hh:mm").format(event.endTime);
    this.description = event.description;
    this.is_cyclic = true;//event.cycle.isEmpty ;
    this.cycle = "DERROR";//event.cycle;
    this.color = Colors.blueAccent;//event.color;
    this.event = event;
  }

}

class _ItemEventState extends State<ItemEvent> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.name),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(widget.eventStarts),
          Text("|"),
          Text(widget.eventEnds),
        ],
      ),

      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.description),
        ),
        !widget.is_cyclic ? Container() : Row(
          children: <Widget>[
            Icon(Icons.repeat,color: widget.color),
            Text(widget.cycle)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
                child: MaterialButton(
                    child: Icon(Icons.edit),
                    color: Colors.blueAccent,
                    onPressed: widget.onPressedEdit
                )
            ),
            Expanded(
                child:  MaterialButton(
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
