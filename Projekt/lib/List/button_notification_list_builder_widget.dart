import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pageview/Baza_danych/notification_helper.dart';
import 'package:pageview/Classes/Notifi.dart';

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
          return Row(
            children: <Widget>[
              RaisedButton(
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.account_circle,
                                    size: 18.0,
                                  ),
                                  Text(widget.lista[index].duration.toString()),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                color: Colors.amber[400],

              ),
              new IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  if(widget.lista[index].id != null) {
                    NotifiHelper.delete(widget.lista[index].id);
                  }
                  widget.lista.removeAt(index);
                  setState(() {});
                },
              ),
            ],
          );
        });
  }
}
