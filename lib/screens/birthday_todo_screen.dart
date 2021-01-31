import 'package:flutter/material.dart';
import 'package:todo_application/screens/settings_screen.dart';
import 'package:todo_application/widgets/Birthday_todo_dialog.dart';
import 'package:todo_application/widgets/birthday_task.dart';

class BirthdayTodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Birthdays',
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).appBarTheme.color,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, color: Colors.white, size: 30),
            tooltip: "add a Birthday",
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                child: BirthdayTodoDialog(),     // Do stuff
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
      body: BirthdayTasks(), // change this
    );
  }
}