import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/database/dbhelper.dart';
import 'package:todo_application/models/todo.dart';
import 'package:todo_application/provider/todo_list.dart';
import 'package:todo_application/widgets/todo_form_widget.dart';

class AddTodoDialog extends StatefulWidget {
  @override
  _AddTodoDialogState createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final _formkey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    //var height = MediaQuery.of(context).size.height;
    //var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      content: Container(
        // height: height / 3,
        // width: width / 2,
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Add todo'),
              SizedBox(height: 8),
              TodoFormWidget(
                onChangedTitle: (title) {
                  setState(() {
                    this.title = title;
                  });
                },
                onChangedDescription: (description) {
                  setState(() {
                    this.description = description;
                  });
                },
                onSavedTodo: addTodo,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addTodo() {
    final isValid = _formkey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final todo = Todo(
        id: DateTime.now().toIso8601String(),
        title: title,
        description: description,
        date: DateTime.now().toIso8601String(),
        completed: 0,
      );
      final provider = Provider.of<TodoList>(context, listen: false);
      final dbhelper = DatabaseHelper.instance;
      dbhelper.insertTodo(todo);
      provider.addTodo(todo);
      Navigator.of(context).pop();
    }
  }
}
