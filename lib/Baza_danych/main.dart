//import 'package:baza/task.dart';
//import 'package:flutter/material.dart';
//
//import 'package:baza/database_helper.dart';
//import 'group_helper.dart';
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'SQFlite',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: MyHomePage(),
//    );
//  }
//}
//
//class MyHomePage extends StatelessWidget {
//
//  final dbHelper = DatabaseHelper.instance;
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('sqflite'),
//      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            RaisedButton(
//              child: Text('insert', style: TextStyle(fontSize: 20),),
//              onPressed: () {_insert();},
//            ),
//            RaisedButton(
//              child: Text('query', style: TextStyle(fontSize: 20),),
//              onPressed: () {_query();},
//            ),
//            RaisedButton(
//              child: Text('update', style: TextStyle(fontSize: 20),),
//              onPressed: () {_update();},
//            ),
//            RaisedButton(
//              child: Text('delete', style: TextStyle(fontSize: 20),),
//              onPressed: () {_delete();},
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//
//
//  void _insert() async {
//    GroupHelper.addGroup('s', 1,);
//    print('inserted row');
//  }
//
//  void _query() async {
//    final allRows = await dbHelper.queryAllRows('Grupa');
//    print('query all rows:');
//    allRows.forEach((row) => print(row));
//  }
//
//  void _update() async {
//    GroupHelper.updateGroup(1,'b', 2,);
//    print('updated row(s)');
//  }
//
//  void _delete() async {
//    GroupHelper.deleteGroup(1);
//    print('deleted row(s)');
//  }
//}