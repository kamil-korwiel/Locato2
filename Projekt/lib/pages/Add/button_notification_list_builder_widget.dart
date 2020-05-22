import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:Locato/Baza_danych/notification_helper.dart';
import 'package:Locato/Classes/Notifi.dart';
import 'package:duration/duration.dart';

class ListNotifi extends StatefulWidget {
  List<Notifi> lista;

  ListNotifi(this.lista);

  @override
  _ListNotifiState createState() => _ListNotifiState();
}

class _ListNotifiState extends State<ListNotifi> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: new ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.lista.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF333366),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.white),
                  ),
                  height: 50.0,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(10),
                          child: buildListTextTile(index)),
                      buildRemoveButton(index),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  ///Builds a space between widgets in a column.
  Widget buildSpace() {
    return SizedBox(
      height: 10.0,
    );
  }

  ///Builds a space between widgets in a row.
  Widget buildSpaceBetween(

      ///Specifies width of a space.
      double _width) {
    return SizedBox(
      width: _width,
    );
  }

  ///Builds a field with a text displayed inside of it.
  Widget buildListTextTile(

      ///Stores id of a list element.
      int _index) {
    return SizedBox(
      width: 150,
      child: Text(
          printDuration(widget.lista[_index].duration, abbreviated: true) +
              " przed"),
    );
  }

  ///Builds a button to remove an element from list.
  Widget buildRemoveButton(

      ///Stores id of a list element.
      int _index) {
    return SizedBox(
      child: IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          removeFromList(_index);
        },
      ),
    );
  }

  ///Builds a field with an icon displayed inside of it.
  Widget buildListIconTile() {
    return Container(
      width: 20,
      child: Icon(
        Icons.notifications,
        size: 18.0,
      ),
    );
  }

  ///Removes an element from a list.
  void removeFromList(int _index) {
    if (widget.lista[_index].id != null) {
      NotifiHelper.delete(widget.lista[_index].id);
    }
    widget.lista.removeAt(_index);
    setState(() {});
  }
}
