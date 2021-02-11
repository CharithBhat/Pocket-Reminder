import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/models/birthdayTodo.dart';
import 'package:todo_application/provider/birthdayTodo_list.dart';
import 'package:todo_application/provider/notificationProvider.dart';
import 'package:todo_application/widgets/todo_form_widget.dart';

class BirthdayTodoDialog extends StatefulWidget {
  @override
  _BirthdayTodoDialogState createState() => _BirthdayTodoDialogState();
}

class _BirthdayTodoDialogState extends State<BirthdayTodoDialog> {
  final _formkey = GlobalKey<FormState>();
  String title = '';
  DateTime pickedDate;

  @override
  void initState() {
    super.initState();
    var androidInitilize =
        new AndroidInitializationSettings('mipmap/ic_launcher');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings = new InitializationSettings(
        android: androidInitilize, iOS: iOSinitilize);
    var fltrNotification = Notificationher().notific; // here
    //fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);
    pickedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      //insetPadding: EdgeInsets.symmetric(horizontal: 0)
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      content: Container(
        //height: height,
        width: width,
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
                onSavedTodo: addTodo,
              ),
              ListTile(
                title: Text(
                    "Date: ${pickedDate.year}, ${pickedDate.month}, ${pickedDate.day}"),
                trailing: Icon(Icons.keyboard_arrow_down),
                onTap: _pickDate,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 50),
      lastDate: DateTime(DateTime.now().year + 50),
      initialDate: pickedDate,
    );
    if (date != null)
      setState(() {
        pickedDate = date;
      });
  }

  void addTodo() {
    final isValid = _formkey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final todo = BirthdayTodo(
        id: DateTime.now().toIso8601String(),
        name: title,
        date: DateTime.now().toIso8601String(),
        birthDate: pickedDate.toString(),
      );
      final provider = Provider.of<BirthdayTodoList>(context, listen: false);
      provider.addBirthdayTodo(todo);
      Navigator.of(context).pop();
      _showNotification(todo.name + "says its his birthday", todo.id);
    }
  }

  Future<void> _showNotification(String title, String id) async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      "CHANNEL_DESCRIPTION",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidChannelSpecifics, iOS: iosChannelSpecifics);
    var scheduledTime;
    int currentAge = DateTime.now().year - pickedDate.year;

    print(pickedDate);
    print(DateTime.now());
    print(scheduledTime);

    var fltrNotification = Notificationher().notific; // herre

    fltrNotification.schedule(
          0,
          title,
          "",
          scheduledTime = pickedDate.add(
            Duration(
              days: currentAge * 365,
            ),
          ),
          platformChannelSpecifics,
          androidAllowWhileIdle: true);

          print(scheduledTime);
  }

  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification Clicked $payload"),
      ),
    );
  }
}
