import 'package:flutter/material.dart';
import 'package:todo_application/database/dbhelper.dart';
import 'package:todo_application/models/todo.dart';

class TodoList with ChangeNotifier {
  final dbhelper = DatabaseHelper.instance;

  // List<Todo> get todoList {
  //   return _todoList;
  // }

  void refresh() {
    notifyListeners();
  }

  // void toggleCompletion(Todo todo) {
  //   if(todo.completed == 1) todo.completed = todo.completed -1;
  //   else{todo.completed = todo.completed + 1;}
  //   notifyListeners();
  // }

  // void removeTodo(Todo todo){
  //   _todoList.remove(todo);
  //   notifyListeners();
  // }

  // void updateTodo(Todo todo, String title, String description){
  //   todo.title = title;
  //   todo.description = description;
  //   notifyListeners();
  // }
}

