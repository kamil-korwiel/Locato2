import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pageview/Baza_danych/localization_helper.dart';
import 'package:pageview/Classes/Localization.dart';
import 'package:pageview/Classes/Task.dart';
import 'package:pageview/pages/Add/add_location2.dart';

class UpgradeLocalization extends StatefulWidget {
  @override
  _UpgradeLocalizationState createState() => _UpgradeLocalizationState();

  Task task;
  List<Localization> listOfLocal;

  UpgradeLocalization(this.task,this.listOfLocal);
}

class _UpgradeLocalizationState extends State<UpgradeLocalization> {

  List<Localization> localizationlist;
  List<Localization> downloadlist;
//  int currentIndex = 0;
//  int length = 0;

  @override
  void initState() {
    localizationlist = List();
    downloadlist = List();
    _downloadData();

    super.initState();
  }


  void _downloadData(){
    LocalizationHelper.lists().then((onList) {
      if(onList != null) {
        downloadlist = onList;

        downloadlist.removeAt(0);
        downloadlist.forEach((l){
          if(l.id !=  widget.task.localization.id){
            localizationlist.add(l);
          }else{
            localizationlist.add(widget.task.localization);
          }
        });

        if(widget.listOfLocal.isNotEmpty){
          localizationlist.addAll(widget.listOfLocal);
        }

        setState(() {});
      }
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dodaj Lokalizację", style: TextStyle(color: Colors.white),),
        // tu kontrolujesz przycisk wstecz
        leading: new IconButton(icon: Icon(Icons.arrow_back), onPressed: onBackPressed),
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
        itemCount: localizationlist.length,
        itemBuilder: (context, index) {
          return RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: Colors.white,
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
                            SizedBox(width: 30),
                            Icon(
                              Icons.location_on,
                              size: 18.0,
                              color: Colors.white,
                            ),
                            SizedBox(width: 30),
                            Text(" " + localizationlist[index].name.toString()),
                            SizedBox(width: 30),
                            buildRemoveButton(index),
                            SizedBox(width: 30),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            color: localizationlist[index].isSelected
                ? Color(0xFF333366)
                : Colors.transparent,
            onPressed: () => setState(() => checkifselected(index)),
          );
        });
  }

  Widget buildRemoveButton(int _index) {
    return SizedBox(
      child: IconButton(
        color: Colors.white,
        icon: Icon(Icons.clear),
        onPressed: () {
          removeFromList(_index);
        },
      ),
    );
  }

  Widget buildCustomButton(String text, void action()) {
    return RaisedButton(
      color: Color(0xFF333366),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.white,
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

    widget.listOfLocal.clear();
    localizationlist.forEach((g){
      if(g.id == null && g.isSelected == false){
        widget.listOfLocal.add(g);
      }
    });

    Navigator.pop(context);

    setState(() {});
  }

  void onBackPressed() {
    goBack();
  }

  void goToLocationPickPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddLocation(localizationlist)));
  }

  void removeFromList(int _index) {
    //TODO sprawdz która jest z bazy i dopiero wtedy wywal
    localizationlist.removeAt(_index);
    setState(() {});
  }

  void checkifselected(_index) {

    if(localizationlist[_index].isSelected  == true) {
      localizationlist[_index].isSelected = false;
      widget.task.localization = Localization(id:0);
    }else{
      localizationlist.forEach((g) => g.isSelected = false);
      localizationlist[_index].isSelected = true;
      widget.task.localization = localizationlist[_index];
    }
  }
}
