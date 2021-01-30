import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/models/quickTodo.dart';
import 'package:todo_application/provider/quickTodo_list.dart';
import 'package:todo_application/widgets/quick_todo_form.dart';

class EditQuickTodoScreen extends StatefulWidget {
  final QuickTodo quickTodo;
  EditQuickTodoScreen({@required this.quickTodo});

  @override
  _EditQuickTodoScreenState createState() => _EditQuickTodoScreenState();
}

class _EditQuickTodoScreenState extends State<EditQuickTodoScreen> {
  final _formkey = GlobalKey<FormState>();
  String name = '';

  @override
  void initState() {
    super.initState();
    name = widget.quickTodo.name;
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
              final provider =
                  Provider.of<QuickTodoList>(context, listen: false);
              provider.removeQuickTodo(widget.quickTodo);
              // setState(() {
              //   dbhelper.deleteTodo(widget.todo.id);
              // });

              Navigator.of(context).pop();
              // final snackBar = SnackBar(content: Text('Deleted'));
              // Scaffold.of(context).showSnackBar(snackBar);
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
                Text('Edit QuickTodo'),
                SizedBox(height: 8),
                QuickTodoForm(
                  name: name,
                  onChangedName: (name) {
                    setState(() {
                      this.name = name;
                    });
                  },
                  onSavedTodo: () => editQuickTodo(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void editQuickTodo(BuildContext context) {
    final isValid = _formkey.currentState.validate();
    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<QuickTodoList>(context, listen: false);
      provider.updateQuickTodo(widget.quickTodo, name);
      Navigator.of(context).pop();
    }
  }
}
