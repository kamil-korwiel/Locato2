import 'dart:ui';
import 'package:flutter/material.dart';
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
//                  color: widget.lista[index].isSelected
//                      ? Colors.amber[400]
//                      : Colors.grey,
                  onPressed: () => setState(() {
//                        if (widget.lista[index].isSelected == false)
//                          widget.lista[index].isSelected = true;
//                        else
//                          widget.lista[index].isSelected = false;
                      })),
              new IconButton(
                icon: Icon(Icons.block),
                onPressed: () {
                  widget.lista.removeAt(index);
                },
              ),
            ],
          );
        });
  }
}
