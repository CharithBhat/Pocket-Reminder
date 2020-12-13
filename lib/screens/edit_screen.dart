import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/models/todo.dart';
import 'package:todo_application/provider/todo_list.dart';
import 'package:todo_application/widgets/todo_form_widget.dart';

class EditScreen extends StatefulWidget {
  final Todo todo;
  EditScreen({@required this.todo});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formkey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: height / 3,
        // width: width / 2,
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Edit Todo'),
              SizedBox(height: 8),
              TodoFormWidget(
                title: title,
                description: description,
                onChangedTitle: (title) {
                  setState(() {
                    widget.todo.title = title;
                  });
                },
                onChangedDescription: (description) {
                  setState(() {
                    widget.todo.description = description;
                  });
                },
                onSavedTodo: editTodo,
              ),
            ],
          ),
        ),
      );
  }

  void editTodo(){
    final isValid = _formkey.currentState.validate();
    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<TodoList>(context);
      provider.updateTodo(widget.todo, title, description);
      Navigator.of(context).pop();
    }
  }
}