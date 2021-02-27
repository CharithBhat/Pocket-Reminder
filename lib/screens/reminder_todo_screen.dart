import 'package:flutter/material.dart';
import 'package:todo_application/screens/settings_screen.dart';
import 'package:todo_application/widgets/add_todo_dialog.dart';
import 'package:todo_application/widgets/reminder_tasks.dart';

class ReminderTodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reminders',
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
        backgroundColor: Theme.of(context).appBarTheme.color,
        elevation: 1,
        toolbarHeight: 50,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, size: 30),
            tooltip: "add a Reminder",
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                child: AddTodoDialog(),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            tooltip: "goes to the settings page",
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return SettingsScreen();
                  },
                ),
              );
            },
          )
        ],
      ),
      body: ReminderTasks(),
    );
  }
} 