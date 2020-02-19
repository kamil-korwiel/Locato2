// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'task.dart';
// import 'database_helper.dart';

// class TaskHelper {
//   static final dbHelper = DatabaseHelper.instance;
//   static List<Task> _tasks = [];
//   List<Task> get tasks {
//     return [..._tasks];
//   }

//   static Future<void> addTask(
//     String pickedName,
//     DateTime pickedEndTime,
//     int pickedIdLocation,
//     int pickedGroup,
//   ) async {
//     int pickedIdTask = await dbHelper.queryRowCount('Task');
//     final newTask = Task(
//       idTask: pickedIdTask + 1,
//       name: pickedName,
//       endTime: pickedEndTime,
//       idLocation: pickedIdLocation,
//       group: pickedGroup,
//     );
//     _tasks.add(newTask);
//     dbHelper.insert('Task', {
//       'ID_Task': newTask.idTask,
//       'Nazwa': newTask.name,
//       'Do_Kiedy': newTask.endTime,
//       'ID_Lokalizacja': newTask.idLocation,
//       'Grupa': newTask.group,
//     });
//   }

//   static Future<void> updateTask(
//     int pickedIdTask,
//     String pickedName,
//     DateTime pickedEndTime,
//     int pickedIdLocation,
//     int pickedGroup,
//   ) async {
//     final updatedTask = Task(
//       idTask: pickedIdTask,
//       name: pickedName,
//       endTime: pickedEndTime,
//       idLocation: pickedIdLocation,
//       group: pickedGroup,
//     );

//     dbHelper.update('Task', 'ID_Task', pickedIdTask, {
//       'Nazwa': updatedTask.name,
//       'Do_Kiedy': updatedTask.endTime,
//       'ID_Lokalizacja': updatedTask.idLocation,
//       'Grupa': updatedTask.group,
//     });
//   }

//   static Future<void> deleteTask(
//     int pickedIdTask,
//   ) async {
//     dbHelper.delete('Task', 'ID_Task', pickedIdTask);
//   }

//   static Future<List<Task>> listsTasks() async {
//     final List<Map<String, dynamic>> maps = await dbHelper.queryAllRows('Task');
//     return List.generate(maps.length, (i) {
//       return Task(
//         idTask: maps[i]['ID_Task'],
//         name: maps[i]['Nazwa'],
//         endTime: maps[i]['Do_Kiedy'],
//         idLocation: maps[i]['ID_Lokalizacja'],
//         group: maps[i]['Grupa'],
//       );
//     });
//   }
// }
