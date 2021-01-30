import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/models/reminderTodo.dart';
import 'package:todo_application/widgets/todo_form_widget.dart';
import '../provider/reminderTodo_list.dart';

class EditScreen extends StatefulWidget {
  final ReminderTodo reminderTodo;
  EditScreen({@required this.reminderTodo});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formkey = GlobalKey<FormState>();
  String title = '';

  @override
  void initState() {
    super.initState();
    title = widget.reminderTodo.title;
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
                  Provider.of<ReminderTodoList>(context, listen: false);
              provider.removeReminderTodo(widget.reminderTodo);
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
                Text('Edit Todo'),
                SizedBox(height: 8),
                TodoFormWidget(
                  title: title,
                  onChangedTitle: (title) {
                    setState(() {
                      this.title = title;
                    });
                  },
                  onSavedTodo: () => editReminderTodo(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void editReminderTodo(BuildContext context) {
    final isValid = _formkey.currentState.validate();
    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<ReminderTodoList>(context, listen: false);
      provider.updateReminderTodo(widget.reminderTodo, title);
      // final dbhelper = DatabaseHelper.instance;
      // setState(() {
      //   dbhelper.updateTodo(widget.todo);
      // });
      //provider.updateTodo(widget.todo, title, description);
      Navigator.of(context).pop();
    }
  }
}
