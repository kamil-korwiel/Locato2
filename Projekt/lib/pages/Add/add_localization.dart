import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:Locato/Baza_danych/localization_helper.dart';
import 'package:Locato/Classes/Localization.dart';
import 'package:Locato/Classes/Task.dart';
import 'package:Locato/pages/Add/add_location2.dart';

class AddLocalization extends StatefulWidget {
  @override
  _AddLocalizationState createState() => _AddLocalizationState();

  ///Element of a Task class.
  Task task;

  ///List of localizations which will be added to a task.
  List<Localization> listOfLocal;

  ///Adds localization.
  AddLocalization(this.task, this.listOfLocal);
}

class _AddLocalizationState extends State<AddLocalization> {
  ///List of localizations created by user.
  List<Localization> localizationlist;

  ///List of localizations from data base.
  List<Localization> downloadlist;

  @override
  void initState() {
    localizationlist = List();
    downloadlist = List();
    _downloadData();

    super.initState();
  }

  ///Downloads list of a localistions from data base.
  void _downloadData() {
    LocalizationHelper.lists().then((onList) {
      if (onList != null) {
        downloadlist = onList;

        if (0 != widget.task.localization.id) {
          localizationlist.add(widget.task.localization);
        }
        downloadlist.removeAt(0);
        downloadlist.forEach((l) {
          if (l.id != widget.task.localization.id) {
            localizationlist.add(l);
          }
        });

        if (widget.listOfLocal.isNotEmpty) {
          localizationlist.addAll(widget.listOfLocal);
        }

        setState(() {});
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dodaj Lokalizację",
          style: TextStyle(color: Colors.white),
        ),
        leading:
            new IconButton(icon: Icon(Icons.arrow_back), onPressed: goBack),
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

  ///Builds a Listview with a tiles containing every localization created by user.
  Widget buildList() {
    return new ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: localizationlist.length,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                              " " + localizationlist[index].name.toString()),
                        ),
                        buildRemoveButton(index),
                      ]),
                  color: localizationlist[index].isSelected
                      ? Color(0xFF333366)
                      : Colors.transparent,
                  onPressed: () => setState(() => checkifselected(index)),
                ),
              ),
            ],
          );
        });
  }

  ///Builds a button to remove a localization from list.
  ///Contains a warning about consequences of removing an element.
  Widget buildRemoveButton(

      ///Stores id of a list element.
      int _index) {
    return SizedBox(
      width: 30,
      child: IconButton(
        color: Colors.white,
        icon: Icon(Icons.clear),
        onPressed: () {
          if (localizationlist[_index].id != null) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Uwaga"),
                    content: Text(
                        "Usuniecie tego rekordu doprowadzi do Usunięcia w każdym innym Zadaniu Lokalizacji"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          LocalizationHelper.deleteAndReplaceIdTask(
                              localizationlist[_index].id);
                          removeFromList(_index);
                        },
                      ),
                      FlatButton(
                        child: Text("Anuluj"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          } else {
            removeFromList(_index);
          }
        },
      ),
    );
  }

  ///Builds a button used to display every localization created by user.
  Widget buildCustomButton(

      ///Stores a text displayed inside the button.
      String text,

      ///Receives a void function which is getting used after button pressed.
      GestureTapCallback onPressed) {
    return RaisedButton(
      color: Color(0xFF333366),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.white,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        '$text',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  ///Builds a space between widgets in a column.
  Widget buildSpace() {
    return SizedBox(
      height: 10.0,
    );
  }

  ///Takes user to previous page.
  void goBack() {
    widget.listOfLocal.clear();
    localizationlist.forEach((g) {
      if (g.id == null && g.isSelected == false) {
        widget.listOfLocal.add(g);
      }
    });

    Navigator.pop(context);

    setState(() {});
  }

  ///Takes user to localization pick page.
  void goToLocationPickPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddLocation(localizationlist)));
  }

  ///Removes an element from a list.
  void removeFromList(

      ///Stores id of a list element.
      int _index) {
    localizationlist.removeAt(_index);
    setState(() {});
  }

  ///Checks if localization is selected by user.
  void checkifselected(_index) {
    if (localizationlist[_index].isSelected == true) {
      localizationlist[_index].isSelected = false;
      widget.task.localization = Localization(id: 0);
    } else {
      localizationlist.forEach((g) => g.isSelected = false);
      localizationlist[_index].isSelected = true;
      widget.task.localization = localizationlist[_index];
    }
  }
}
