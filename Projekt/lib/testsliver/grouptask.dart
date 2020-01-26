import 'package:flutter/material.dart';

class GroupTask extends StatelessWidget {
  static List<SimpleTask> _dummListSimpletask = [
    SimpleTask("task 0",false),
    SimpleTask("task 1",false),
    SimpleTask("task 2",false),
    SimpleTask("task 3",false),
  ];

  List<ComplexTask> listOfComplexTask= [
    ComplexTask("Group",false, _dummListSimpletask, 90),
    ComplexTask("Group",false, _dummListSimpletask, 20),
    ComplexTask("Group",false, _dummListSimpletask, 70),
    ComplexTask("Group",false, _dummListSimpletask, 45),
    ComplexTask("Group",false, _dummListSimpletask, 0),
  ];




  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(delegate: SliverChildBuilderDelegate(
          _buildWidgetGroup,
          childCount:listOfComplexTask.length,
        ),
        ),
      ],

    );
  }

//  Widget _buildWidgetGroup(BuildContext context, int index) {
////
////    return Stack(
////      children: <Widget>[
////        Container(
////          height: 57,
////          decoration: BoxDecoration(
////              boxShadow: <BoxShadow>[
////                BoxShadow(
////                  color: Colors.black54,
////                  blurRadius: 5.0,
////                  offset: Offset(0.0, 0.75),
////                ),
////              ]
////          ),
////          child: Row(
////            children: <Widget>[
////              Expanded(
////                flex: listOfComplexTask[index].percent,
////                child: Container(
////                  color: Colors.greenAccent,
////                ),
////              ),
////              Expanded(
////                flex: 100 - listOfComplexTask[index].percent,
////                child: Container(
////                  color: Colors.blue,
////                ),
////              ),
////            ],
////          ),
////        ),
////        ExpansionTile(
////          title: Text(listOfComplexTask[index].name),
////          children: _buildListofTask(listOfComplexTask[index]),
////        ),
////      ],
////    );
////  }
////////////////

//  Widget _buildWidgetGroup(BuildContext context, int index) {
//    double donePercent = listOfComplexTask[index].percent/100;
//    return  new Container(
//      decoration: new BoxDecoration(
//        color: Colors.purple,
//        gradient: new LinearGradient(
//            colors: [Colors.green, Colors.blue],
//            begin: Alignment.centerLeft,
//            stops: [donePercent, donePercent+0.5],
//            end: Alignment.centerRight,
//            tileMode: TileMode.clamp
//        ),
//      ),
//      child: ExpansionTile(
//        title: Text(listOfComplexTask[index].name),
//        children: _buildListofTask(listOfComplexTask[index]),
//        backgroundColor: Colors.white,
//      ),
//    );
//  }

  Widget _buildWidgetGroup(BuildContext context, int index) {
    double donePercent = listOfComplexTask[index].percent/100;
    return Stack(
      children: <Widget>[
        Container(
          height: 56,
          decoration: BoxDecoration(
            gradient: new LinearGradient(
            colors: [Colors.green, Colors.blue],
            begin: Alignment.centerLeft,
            stops: [donePercent , donePercent <= 0.03 ? 0 : donePercent+0.2],
            end: Alignment.centerRight,
        ),
//              boxShadow: <BoxShadow>[
//                BoxShadow(
//                  color: Colors.black54,
//                  blurRadius: 3.0,
//                  offset: Offset(0.0, 0.2),
//                ),
//              ]
          ),
        ),
        ExpansionTile(
          initiallyExpanded: true,
          title: Text(listOfComplexTask[index].name,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 20
            ),
          ),
          //backgroundColor: Colors.green,
          trailing: Text(listOfComplexTask[index].percent.toString()+"%",
            style: TextStyle(
                color: Colors.white,
                fontSize: 17),
          ),
          children: _buildListofTask(listOfComplexTask[index]),
        ),
      ],
    );
  }


  List<Widget> _buildListofTask (ComplexTask complexTask){
    List<Widget> listOfWidget = new List<Widget>();

    for (SimpleTask task in complexTask.listOfSimpleTask) {
      listOfWidget.add(ListTile(
        title: Text(task.name),
      ));
    }

    return listOfWidget;
  }

  Widget _buildGroup(){
    return Stack(
      children: <Widget>[
        Container(
          height: 57,
          decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 5.0,
                  offset: Offset(0.0, 0.75),
                ),
              ]
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 30,
                child: Container(
                  color: Colors.greenAccent,
                ),
              ),
              Expanded(
                flex: 70,
                child: Container(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),


        ExpansionTile(
          title: Text("test"),
          children: <Widget>[
            ListTile(title: Text("lol"),),
            ListTile(title: Text("lol2"),),
            ListTile(title: Text("lol3"),),
          ],
        ),
      ],
    );
  }


}


//////////////////////////////////////
///////////////CLASS//////////////////
//////////////////////////////////////
class DataTask {
  String name;
  String group;
  String description;
  DateTime date;
  List<DateTime> listOfnotyfies;
  bool done;
  bool location;

}

class SimpleTask {
  String name;
  DateTime date;
  List<DateTime> listOfnotifies;
  bool done;

  SimpleTask(this.name, this.done);
//SimpleTask(this.name, this.date, this.listOfnotifies, this.done);



}
class ComplexTask  extends SimpleTask{
  List<SimpleTask> listOfSimpleTask;
  int percent;

  ComplexTask(name, done ,this.listOfSimpleTask, this.percent):
        super(name, done);
}