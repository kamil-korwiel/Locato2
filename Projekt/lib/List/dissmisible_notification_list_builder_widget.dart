import 'dart:ui';
import 'package:flutter/material.dart';

class BuildList extends StatefulWidget {
  List<dynamic> lista;

  @override
  _BuildListState createState() => _BuildListState();
}

class _BuildListState extends State<BuildList> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return new ListView.builder(
        shrinkWrap: true,
        itemCount: widget.lista.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(widget.lista[index].nazwa),
            onDismissed: (left) {
              setState(() {
                widget.lista.removeAt(index);
              });
            },
            child: RaisedButton(
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
                                Text(widget.lista[index].nazwa),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                color: widget.lista[index].isSelected
                    ? Colors.amber[400]
                    : Colors.grey,
                onPressed: () => setState(() {
                      if (widget.lista[index].isSelected == false)
                        widget.lista[index].isSelected = true;
                      else
                        widget.lista[index].isSelected = false;
                    })),
          );
        });
  }
}
