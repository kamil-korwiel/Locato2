//import 'dart:io';
//import 'package:flutter/foundation.dart';
//import 'group.dart';
//import 'database_helper.dart';
//
//class GroupHelper {
//  static final dbHelper = DatabaseHelper.instance;
//  static List<Group> _groups = [];
//  List<Group> get groups {
//    return [..._groups];
//  }
//
//  static Future<void> addGroup(
//    String pickedName,
//    //DateTime pickedTerm,
//    int pickedColor,
//  ) async {
//    int pickedIdGroup = await dbHelper.queryRowCount('Grupa');
//    final newGroup = Group(
//      idGroup: pickedIdGroup + 1,
//      name: pickedName,
//      //term: pickedTerm,
//      color: pickedColor,
//    );
//    _groups.add(newGroup);
//    dbHelper.insert('Grupa', {
//      'ID_Grupa': newGroup.idGroup,
//      'Nazwa_grupa': newGroup.name,
//      //'Termin_grupa': newGroup.term,
//      'Kolor_grupa': newGroup.color,
//    });
//  }
//
//  static Future<void> updateGroup(
//    int pickedIdGroup,
//    String pickedName,
//    //DateTime pickedTerm,
//    int pickedColor,
//  ) async {
//    final updatedGroup = Group(
//      idGroup: pickedIdGroup,
//      name: pickedName,
//      //term: pickedTerm,
//      color: pickedColor,
//    );
//    dbHelper.update('Grupa', 'ID_Grupa', pickedIdGroup, {
//      'Nazwa': updatedGroup.name,
//      //'Termin_grupa': updatedGroup.term,
//      'Kolor_grupa': updatedGroup.color,
//    });
//  }
//
//  static Future<void> deleteGroup(
//    int pickedIdGroup,
//  ) async {
//    dbHelper.delete('Grupa', 'ID_Grupa', pickedIdGroup);
//  }
//
//  static Future<void> fetchAndSetGrupy() async {
//    final dataList = await dbHelper.queryAllRows('Grupa');
//    _groups = dataList
//        .map(
//          (group) => Group(
//            idGroup: group['ID_Grupa'],
//            name: group['Nazwa_grupa'],
//            //term: group['Termin_grupa'],
//            color: group['Kolor_grupa'],
//          ),
//        )
//        .toList();
//  }
//}
