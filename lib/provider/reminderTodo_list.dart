import 'package:flutter/material.dart';
import 'package:todo_application/database/dbhelper.dart';
import 'package:todo_application/models/reminderTodo.dart';

class ReminderTodoList with ChangeNotifier {
  List<ReminderTodo> _todoList = [];
  final dbhelper = DatabaseHelper.instance;

  List<ReminderTodo> get todoList{
    return _todoList;
  }

  void toggleCompletion(ReminderTodo reminderTodo) {
    if (reminderTodo.completed == 1) {
      reminderTodo.completed = reminderTodo.completed - 1;
      dbhelper.updateReminderTodo(reminderTodo);
    } else {
      reminderTodo.completed = reminderTodo.completed + 1;
      dbhelper.updateReminderTodo(reminderTodo);
    }
    notifyListeners();
  }

  void removeReminderTodo(ReminderTodo reminderTodo) {
    dbhelper.deleteReminderTodo(reminderTodo.id);
    _todoList.remove(reminderTodo);
    notifyListeners();
  }

  void updateReminderTodo(ReminderTodo reminderTodo, String title, String description) {
    reminderTodo.title = title;
    reminderTodo.description = description;
    // todo.title = title;
    // todo.description = description;
    dbhelper.updateReminderTodo(reminderTodo);
    notifyListeners();
  }

  void addReminderTodo(ReminderTodo reminderTodo) {
    _todoList.add(reminderTodo);
    dbhelper.insertReminderTodo(reminderTodo);
    notifyListeners();
  }
}
