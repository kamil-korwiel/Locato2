import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:pageview/Classes/Localization.dart';
import 'package:pageview/pages/add_task.dart';
import 'package:pageview/pages/add_location2.dart';

class AddLocalization extends StatefulWidget {
  @override
  _AddLocalizationState createState() => _AddLocalizationState();

}


class _AddLocalizationState extends State<AddLocalization> {

  @override
  void initState() {
    super.initState();
  }

  String _value;
  List<Color> _colors = [Colors.grey, Colors.amber[400]];
  List<Localization> localizationlist = [];
  int currentIndex = 0;
  int length = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dodaj Lokalizację"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(children: <Widget>[
            new RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddLocation()));
              },
              child: Text('Nowa lokalizacja'),
            ),
            SizedBox(
              height: 10.0,
            ),
            new ListView.builder(
                shrinkWrap: true,
                itemCount: length,
                itemBuilder: (context, index) {
                  return RaisedButton(
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
                                      Icons.location_on,
                                      size: 18.0,
                                    ),
                                    Text(" " + localizationlist[index].name),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    color: localizationlist[index].isSelected ? Colors.amber[400] : Colors.grey,
                    onPressed: () => setState(() { 
                      if(localizationlist[index].isSelected == false){
                        for(int i = 0; i < localizationlist.length; i++) localizationlist[i].isSelected = false;
                        localizationlist[index].isSelected = true;
                      }
                      else
                      localizationlist[index].isSelected = false;
                      })
              );
                    }),
                
            SizedBox(
              height: 10.0,
            ),
            new RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Potwierdź'),
            ),
          ])),
    );
  }
}

