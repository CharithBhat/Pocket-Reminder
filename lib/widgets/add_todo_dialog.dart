import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return AlertDialog(
      content: Column(
        children: [
          Form(
            key: _formkey,
            child: Column(
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
          ), // here is where the todoform widget goes
        ],
      ),
    );
  }

  void addTodo() {
    final isValid = _formkey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final todo = Todo(
        title: title,
        description: description,
        date: DateTime.now(),
        completed: false,
      );
      final provider = Provider.of<TodoList>(context, listen: false);
      provider.addTodo(todo);
      Navigator.of(context).pop();
    }
  }
}
