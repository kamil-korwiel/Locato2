import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pageview/pages/add_event.dart';
import 'package:pageview/Classes/Cycle.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class AddCycle extends StatefulWidget {
  @override
  _AddCycleState createState() => _AddCycleState();

  // Cycle cycle;
  // AddCycle({this.cycle});
}

class _AddCycleState extends State<AddCycle> {

  final TextEditingController _text = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  List<Color> _colors = [Colors.grey, Colors.amber[400]];
  List<MyCycle> cyclelist = [];
  int _currentIndex = 0;
  List<String> unitlist = ["Dni", "Tygodnie", "Miesiące"];
  String holder = "Dni";
  String _value = "Dni";

  int czas;
  int length = 0;
  String pom;
  String name;
  

  void getDropDownItem(){
    setState(() {
      holder = _value ;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dodaj cykl"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(children: <Widget>[
            new Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
DropdownButton<String>(
	value: _value,
	icon: Icon(Icons.arrow_drop_down),
	iconSize: 24,
	elevation: 16,
	onChanged: (String data) {
	  setState(() {
		_value = data;
    getDropDownItem();
	  });
	},
	items: unitlist.map<DropdownMenuItem<String>>((String value) {
	  return DropdownMenuItem<String>(
		value: value,
		child: Text(value),
	  );
	}).toList(),
  ),
      Flexible(
        child: Form(
        key: _formKey,
        child: TextFormField(
              controller: _text,
              decoration: new InputDecoration(
                labelText: "Cykl",
                hintText: "Liczba dni/tygodni/miesięcy"
              ),
              keyboardType: TextInputType.number,
               validator: (val) {
                if (val.isEmpty) {
                  return 'Pole nie może być puste!';
                }
                return null;
              },
            ),
        ),
      ),
    ],
           ),
            SizedBox(
              height: 10.0,
            ),
            new RaisedButton(
              onPressed: () {

                if(_formKey.currentState.validate()){

                if(holder == "Dni"){
                czas = int.parse(_text.text);
                pom = holder;
                name = "co $czas dni";
                }
                if(holder == "Tygodnie"){
                czas = int.parse(_text.text);
                pom = holder;
                name = " co $czas tygodni";
                }
                if(holder == "Miesiące"){
                czas = int.parse(_text.text);
                pom = holder;
                name = "co $czas miesięcy";
                }
                cyclelist.add(new MyCycle(id: _currentIndex, amount: czas, type: pom, nazwa: name));
                _text.clear();
                _currentIndex++;
                length = cyclelist.length;
                
                setState(() {});
                }

              },
              child: Text('Dodaj'),
            ),
            SizedBox(
              height: 10.0,
            ),
            new ListView.builder(
                shrinkWrap: true,
                itemCount: cyclelist.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(cyclelist[index].nazwa),
                    onDismissed: (left) {
                      setState(() {
                        cyclelist.removeAt(index);
                      });
                    },
                    child:  RaisedButton(
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
                                    Text(cyclelist[index].nazwa),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    color: cyclelist[index].isSelected ? Colors.amber[400] : Colors.grey,
                    onPressed: () => setState(() { 
                       if (cyclelist[index].isSelected == false) {
                              for (int i = 0; i < cyclelist.length; i++)
                                cyclelist[i].isSelected = false;
                              cyclelist[index].isSelected = true;
                            } else
                              cyclelist[index].isSelected = false;
                          })));
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

