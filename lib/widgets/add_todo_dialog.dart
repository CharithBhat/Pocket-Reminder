import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
  FlutterLocalNotificationsPlugin fltrNotification;
  String _selectedParam;
  String task;
  int val;

  @override
  void initState() {
    super.initState();
    var androidInitilize = new AndroidInitializationSettings('app_icon');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings = new InitializationSettings(
        android: androidInitilize, iOS: iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);
  }

  Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "Desi programmer", "This is my channel",
        importance: Importance.max);
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iSODetails);

    // await fltrNotification.show(
    //     0, "Task", "You created a Task", generalNotificationDetails, payload: "Task");
    var scheduledTime;
    if (_selectedParam == "Hour") {
      scheduledTime = DateTime.now().add(Duration(hours: val));
    } else if (_selectedParam == "Minute") {
      scheduledTime = DateTime.now().add(Duration(minutes: val));
    } else {
      scheduledTime = DateTime.now().add(Duration(seconds: val));
    }

    fltrNotification.schedule(
        1, "Times Uppp", task, scheduledTime, generalNotificationDetails);
  }

  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification Clicked $payload"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //var height = MediaQuery.of(context).size.height;
    //var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      content: Container(
        //height: height,
        //width: width,
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
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  onChanged: (_val) {
                    task = _val;
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DropdownButton(
                    value: _selectedParam,
                    items: [
                      DropdownMenuItem(
                        child: Text("Seconds"),
                        value: "Seconds",
                      ),
                      DropdownMenuItem(
                        child: Text("Minutes"),
                        value: "Minutes",
                      ),
                      DropdownMenuItem(
                        child: Text("Hour"),
                        value: "Hour",
                      ),
                    ],
                    hint: Text(
                      "Select Your Field.",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    ),
                    onChanged: (_val) {
                      setState(() {
                        _selectedParam = _val;
                      });
                    },
                  ),
                  DropdownButton(
                    value: val,
                    items: [
                      DropdownMenuItem(
                        child: Text("1"),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text("2"),
                        value: 2,
                      ),
                      DropdownMenuItem(
                        child: Text("3"),
                        value: 3,
                      ),
                      DropdownMenuItem(
                        child: Text("4"),
                        value: 4,
                      ),
                    ],
                    hint: Text(
                      "Select Value",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10
                      ),
                    ),
                    onChanged: (_val) {
                      setState(() {
                        val = _val;
                      });
                    },
                  ),
                ],
              ),
              RaisedButton(
                onPressed: _showNotification,
                child: new Text('Set Task With Notification'),
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
      provider.addTodo(todo);
      Navigator.of(context).pop();
    }
  }
}
