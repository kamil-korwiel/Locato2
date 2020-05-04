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
            buildCustomButton("Nowa lokalizacja", goToLocationPickPage),
            buildSpace(),
            SizedBox(height: 300, child: buildList()),
            buildSpace(),
            buildCustomButton("Potwierdź", goBack),
          ])),
    );
  }

  Widget buildList() {
    return new ListView.builder(
      physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: length,
        itemBuilder: (context, index) {
          return RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: Colors.amber[400],
              ),
            ),
            elevation: 5.0,
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
                              color: Colors.white,
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
            color: localizationlist[index].isSelected
                ? Colors.grey
                : Colors.transparent,
            onPressed: () => setState(() => checkifselected(index)),
          );
        });
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

  Widget buildCustomButton(String text, void action()) {
    return RaisedButton(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.amber[400],
        ),
      ),
      onPressed: () {
        action();
      },
      child: Text(
        '$text',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildSpace() {
    return SizedBox(
      height: 10.0,
    );
  }

  void goBack() {
    Navigator.pop(context);
  }

  void goToLocationPickPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddLocation()));
  }

  void removeFromList(int _index) {
    localizationlist.removeAt(_index);
    setState(() {});
  }

  void checkifselected(_index) {
    if (localizationlist[_index].isSelected == false) {
      for (int i = 0; i < localizationlist.length; i++)
        localizationlist[i].isSelected = false;
      localizationlist[_index].isSelected = true;
    } else
      localizationlist[_index].isSelected = false;
  }
}
