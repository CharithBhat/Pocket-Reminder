import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/models/reminderTodo.dart';
import 'package:todo_application/provider/reminderTodo_list.dart';
import 'package:todo_application/widgets/todo_form_widget.dart';
import '../provider/notificationProvider.dart';

class AddTodoDialog extends StatefulWidget {
  @override
  _AddTodoDialogState createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final _formkey = GlobalKey<FormState>();
  String title = '';
  //FlutterLocalNotificationsPlugin fltrNotification;
  DateTime pickedDate;
  TimeOfDay time;

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
    time = TimeOfDay.now();
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

    print(pickedDate);
    print(time);

    if (pickedDate.day == DateTime.now().day) {
      scheduledTime = DateTime.now().add(Duration(
        hours: time.hour - DateTime.now().hour,
        minutes: time.minute - DateTime.now().minute - 1,
        seconds: 60 - DateTime.now().second,
      ));
    } else {
      scheduledTime =
          pickedDate.add(Duration(hours: time.hour, minutes: time.minute));
    }
    print(pickedDate);
    print(DateTime.now());
    print(scheduledTime);

    var fltrNotification = Notificationher().notific; // herre
    fltrNotification.schedule(
        0, title, "", scheduledTime, platformChannelSpecifics,
        androidAllowWhileIdle: true);

    // fltrNotification.periodicallyShow(0, 'repeating title',
    // 'repeating body', RepeatInterval.everyMinute, platformChannelSpecifics,
    // androidAllowWhileIdle: true);
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
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: AlertDialog(
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
                ListTile(
                  title: Text("Time: ${time.hour}:${time.minute}"),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  onTap: _pickTime,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
    );
    if (date != null)
      setState(() {
        pickedDate = date;
      });
  }

  _pickTime() async {
    TimeOfDay t = await showTimePicker(context: context, initialTime: time);
    if (t != null)
      setState(() {
        time = t;
      });
  }

  void addTodo() {
    final isValid = _formkey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final todo = ReminderTodo(
        id: DateTime.now().toIso8601String(),
        title: title,
        date: DateTime.now().toIso8601String(),
        completed: 0,
      );
      final provider = Provider.of<ReminderTodoList>(context, listen: false);
      provider.addReminderTodo(todo);
      Navigator.of(context).pop();
      _showNotification(todo.title, todo.id);
    }
  }
}
