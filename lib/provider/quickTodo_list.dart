import 'package:flutter/material.dart';
import '../models/quickTodo.dart';
import 'package:todo_application/database/dbhelper.dart';


class QuickTodoList with ChangeNotifier{
  List<QuickTodo> _quickTodoList = [];
  final dbhelper = DatabaseHelper.instance;

  List<QuickTodo> get quickTodoList{
    return _quickTodoList;
  }

  void removeQuickTodo(QuickTodo quickTodo){
    dbhelper.deleteQuickTodo(quickTodo.id);
    _quickTodoList.remove(quickTodo);
    notifyListeners();
  }

  void updateQuickTodo(QuickTodo quickTodo, String name, String date) {
    quickTodo.name = name;
    quickTodo.date = date;
    // datebase 
    notifyListeners();
  }

  void addQuickTodo(QuickTodo quickTodo) {
    _quickTodoList.add(quickTodo);
    notifyListeners();
  }
}