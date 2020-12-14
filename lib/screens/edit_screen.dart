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
  void initState() {
    super.initState();
    title = widget.todo.title;
    description = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              final provider = Provider.of<TodoList>(context, listen: false);
              provider.removeTodo(widget.todo);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
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
                      this.title = title;
                    });
                  },
                  onChangedDescription: (description) {
                    setState(() {
                      this.description = description;
                    });
                  },
                  onSavedTodo: editTodo,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void editTodo() {
    final isValid = _formkey.currentState.validate();
    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<TodoList>(context,listen: false);
      provider.updateTodo(widget.todo, title, description);
      Navigator.of(context).pop();
    }
  }
}
