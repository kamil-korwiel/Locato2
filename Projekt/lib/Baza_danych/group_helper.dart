// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'group.dart';
// import 'database_helper.dart';

// class GroupHelper {
//   static final dbHelper = DatabaseHelper.instance;
//   static List<Group> _groups = [];
//   List<Group> get groups {
//     return [..._groups];
//   }

//   static Future<void> addGroup(
//     String pickedName,
//     int pickedhowMuchDone,
//   ) async {
//     int pickedIdGroup = await dbHelper.queryRowCount('Grupa');
//     final newGroup = Group(
//       idGroup: pickedIdGroup + 1,
//       name: pickedName,
//       howMuchDone: pickedhowMuchDone,
//     );
//     _groups.add(newGroup);
//     dbHelper.insert('Grupa', {
//       'ID_Grupa': newGroup.idGroup,
//       'Nazwa_grupa': newGroup.name,
//       'Ile_wykonane': newGroup.howMuchDone,
//     });
//   }

//   static Future<void> updateGroup(
//     int pickedIdGroup,
//     String pickedName,
//     int pickedhowMuchDone,
//   ) async {
//     final updatedGroup = Group(
//       idGroup: pickedIdGroup,
//       name: pickedName,
//       howMuchDone: pickedhowMuchDone,
//     );
//     dbHelper.update('Grupa', 'ID_Grupa', pickedIdGroup, {
//       'Nazwa_grupa': updatedGroup.name,
//       'Ile_wykonane': updatedGroup.howMuchDone,
//     });
//   }

//   static Future<void> deleteGroup(
//     int pickedIdGroup,
//   ) async {
//     dbHelper.delete('Grupa', 'ID_Grupa', pickedIdGroup);
//   }

//   static Future<List<Group>> listsGroups() async {
//     final List<Map<String, dynamic>> maps =
//         await dbHelper.queryAllRows('Grupa');
//     return List.generate(maps.length, (i) {
//       return Group(
//         idGroup: maps[i]['ID_Wydarzenie'],
//         name: maps[i]['Nazwa_grupa'],
//         howMuchDone: maps[i]['Ile_wykonane'],
//       );
//     });
//   }
// }
