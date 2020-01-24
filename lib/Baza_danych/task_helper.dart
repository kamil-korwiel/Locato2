import 'dart:io';
import 'package:flutter/foundation.dart';
import 'task.dart';
import 'database_helper.dart';

class TaskHelper {
  static final dbHelper = DatabaseHelper.instance;
  static List<Task> _tasks = [];
  List<Task> get tasks {
    return [..._tasks];
  }
  static Future<void> addTask(
    String pickedName,
    //DateTime pickedEndTime,
    int pickedLocation,
    String pickedDescription,
    int pickedGroup,
  ) async {
    int pickedIdTask = await dbHelper.queryRowCount('Task');
    final newTask = Task(
      idTask: pickedIdTask + 1,
      name: pickedName,
      //endTime: pickedEndTime,
      location: pickedLocation,
      description: pickedDescription,
      group: pickedGroup,
    );
    _tasks.add(newTask);
    dbHelper.insert('Task', {
      'ID_Task': newTask.idTask,
      'Nazwa': newTask.name,
      //'Do_Kiedy': newTask.endTime,
      'Lokalizacja': newTask.location,
      'Opis': newTask.description,
      'Grupa': newTask.group,
    });
  }

  static Future<void> updateTask(
    int pickedIdTask,
    String pickedName,
    //DateTime pickedEndTime,
    int pickedLocation,
    String pickedDescription,
    int pickedGroup,
  ) async {
    final updatedTask = Task(
      idTask: pickedIdTask,
      name: pickedName,
      //endTime: pickedEndTime,
      location: pickedLocation,
      description: pickedDescription,
      group: pickedGroup,
    );

    dbHelper.update('Task', 'ID_Task', pickedIdTask,{
      'Nazwa': updatedTask.name,
      //'Do_Kiedy': updatedTask.endTime,
      'Lokalizacja': updatedTask.location,
      'Opis': updatedTask.description,
      'Grupa': updatedTask.group,
    });
  }

  static Future<void> deleteTask(
    int pickedIdTask,
  ) async {
    dbHelper.delete('Task', 'ID_Task', pickedIdTask);
  }

  static Future<void> fetchAndSetTasks() async {
    final dataList = await dbHelper.queryAllRows('Task');
    _tasks = dataList
        .map(
          (task) => Task(
            idTask: task['ID_Task'],
            name: task['Nazwa'],
            //endTime: task['Do_Kiedy'],
            location: task['Lokalizacja'],
            description: task['Opis'],
            group: task['Grupa'],
          ),
        )
        .toList();
  }
}
