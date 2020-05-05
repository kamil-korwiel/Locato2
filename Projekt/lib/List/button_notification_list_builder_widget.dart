import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pageview/Baza_danych/notification_helper.dart';
import 'package:pageview/Classes/Notifi.dart';
import 'package:duration/duration.dart';

class ListNotifi extends StatefulWidget {
  List<Notifi> lista;

  ListNotifi(this.lista);

  @override
  _ListNotifiState createState() => _ListNotifiState();
}

class _ListNotifiState extends State<ListNotifi> {
  List<Notifi> list;

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                buildListIconTile(),
                                buildSpaceBetween(80),
                                buildListTextTile(index),
                              ],
                            ),
                          ),
                          buildSpaceBetween(30),
                          buildRemoveButton(index),
                        ],
                      ),
                    ],
                  ),
                ),
                buildSpace(),
              ],
            );
          }),
    );
  }

  Widget buildSpace() {
    return SizedBox(
      height: 10.0,
    );
  }

  Widget buildSpaceBetween(double _width) {
    return SizedBox(
      width: _width,
    );
  }

  Widget buildListTextTile(int _index) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 300,
      child: Text(
          printDuration(widget.lista[_index].duration, abbreviated: true) +
              " przed"),
    );
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

  Widget buildListIconTile() {
    return Container(
      width: 20,
      child: Icon(
        Icons.notifications,
        size: 18.0,
      ),
    );
  }

  void removeFromList(int _index) {
    if (widget.lista[_index].id != null) {
      NotifiHelper.delete(widget.lista[_index].id);
    }
    widget.lista.removeAt(_index);
    setState(() {});
  }
}
