import 'package:flutter/material.dart';
import 'package:pageview/Baza_danych/event_helper.dart';
import 'package:pageview/Classes/Event.dart';
import 'package:pageview/pages/add_event.dart';

class ItemEvent extends StatefulWidget {
  @override
  _ItemEventState createState() => _ItemEventState();

  final Function function;

  String name;
  String eventStarts;
  String eventEnds;
  String cycle;
  bool is_cyclic;
  String description;

  Event event;

  Color color;
  //ItemEvent(String this.name,String this.eventStarts ,String this.eventEnds,String this.description,bool this.is_cyclic, String this.cycle, Color this.color,{this.function});
  ItemEvent.classevent(Event event, {this.function}){
    this.name = event.name;
    this.eventStarts = event.beginTime;
    this.eventEnds = event.endTime;
    this.description = event.description;
    this.is_cyclic = event.cycle.isEmpty ;
    this.cycle = event.cycle;
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddEvent()),
                    );
                  },
                )
            ),
            Expanded(
                child:  MaterialButton(
                  child: Icon(Icons.delete),
                  color: Colors.redAccent,
                  onPressed: (){
                    EventHelper.delete(widget.event.id);
                  },
                )
            ),
          ],

        )

      ],
    );
  }
}
