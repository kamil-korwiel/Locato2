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
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return new ListView.builder(
        shrinkWrap: true,
        itemCount: widget.lista.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new RaisedButton(
                child: Container(
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
                                Container(
                                  width: 20,
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 18.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 80,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 300,
                                  child: Text(printDuration(widget.lista[index].duration, abbreviated: true) + " przed"),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                                  width: 30,
                                ),
                          SizedBox(
                            child: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                if (widget.lista[index].id != null) {
                                  NotifiHelper.delete(widget.lista[index].id);
                                }
                                widget.lista.removeAt(index);
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                color: Colors.amber[400],
              ),
            ],
          );
        });
  }
}
