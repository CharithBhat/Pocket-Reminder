import 'package:flutter/material.dart';
import 'package:todo_application/models/todo.dart';

class TodoList with ChangeNotifier {
  List<Todo> _todoList = [
    Todo(
      id: 1,
      title: 'read books',
      description: 'read novels',
      completed: true,
      date: DateTime.now(),
    ),
    Todo(
      id: 2,
      title: 'breakfast',
      description: 'read novels',
      completed: false,
      date: DateTime.now(),
    ),
    Todo(
      id: 3,
      title: 'lunch',
      description: 'read novels',
      completed: true,
      date: DateTime.now(),
    ),
    Todo(
      id: 4,
      title: 'dinner',
      description: 'read novels',
      completed: true,
      date: DateTime.now(),
    ),
  ];

  List<Todo> get todoList {
    return _todoList;
  }

  void addTodo(Todo todo) {
    _todoList.add(todo);
    notifyListeners();
  }

  void toggleCompletion(Todo todo) {
    todo.completed = !todo.completed;
    notifyListeners();
  }

  void removeTodo(Todo todo){
    _todoList.remove(todo);
    notifyListeners();
  }

  void updateTodo(Todo todo, String title, String description){
    todo.title = title;
    todo.description = description;
    notifyListeners();
  }
}

// int id;
// String title;
// String description;
// bool completed;
// DateTime date;
