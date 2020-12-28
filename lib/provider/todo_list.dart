import 'package:flutter/material.dart';
import 'package:todo_application/database/dbhelper.dart';
import 'package:todo_application/models/todo.dart';

class TodoList with ChangeNotifier {
  List<Todo> _todoList = [];
  final dbhelper = DatabaseHelper.instance;

  List<Todo> get todoList{
    return _todoList;
  }

  void toggleCompletion(Todo todo) {
    if (todo.completed == 1) {
      todo.completed = todo.completed - 1;
      dbhelper.updateTodo(todo);
    } else {
      todo.completed = todo.completed + 1;
      dbhelper.updateTodo(todo);
    }
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    dbhelper.deleteTodo(todo.id);
    _todoList.remove(todo);
    notifyListeners();
  }

  void updateTodo(Todo todo, String title, String description) {
    todo.title = title;
    todo.description = description;
    todo.title = title;
    todo.description = description;
    dbhelper.updateTodo(todo);
    notifyListeners();
  }

  void addTodo(Todo todo) {
    _todoList.add(todo);
    dbhelper.insertTodo(todo);
    notifyListeners();
  }
}
