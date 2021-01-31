import 'package:flutter/material.dart';
import 'package:todo_application/models/birthdayTodo.dart';
import '../models/birthdayTodo.dart';
import 'package:todo_application/database/dbhelper.dart';

class BirthdayTodoList with ChangeNotifier {
  List<BirthdayTodo> _birthdayTodoList = [];
  final dbhelper = DatabaseHelper.instance;

  List<BirthdayTodo> get birthdayTodoList {
    return _birthdayTodoList;
  }

  void removeBirthdayTodo(BirthdayTodo birthdayTodo) {
    dbhelper.deleteBirthdayTodo(birthdayTodo.id);
    _birthdayTodoList.remove(birthdayTodo);
    notifyListeners();
  }

  // void updateBirthdayTodo(BirthdayTodo birthdayTodo, String name) {
  //   birthdayTodo.name = name;
  //   dbhelper.updateBirthdayTodo(birthdayTodo);
  //   notifyListeners();
  // }

  void addBirthdayTodo(BirthdayTodo birthdayTodo) {
    _birthdayTodoList.add(birthdayTodo);
    dbhelper.insertBirthdayTodo(birthdayTodo);
    notifyListeners();
  }
}
