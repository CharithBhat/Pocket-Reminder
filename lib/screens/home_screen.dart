import 'package:flutter/material.dart';
import 'package:todo_application/screens/reminder_todo_screen.dart';
import 'package:todo_application/screens/birthday_todo_screen.dart';
import 'package:todo_application/screens/quick_todo_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      QuickTodoScreen(),
      ReminderTodoScreen(),
      BirthdayTodoScreen(),
    ];

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Todo Application',
      //     style: Theme.of(context).appBarTheme.textTheme.headline1,
      //   ),
      //   iconTheme: IconThemeData(color: Colors.white),
      //   backgroundColor: Theme.of(context).appBarTheme.color,
      //   elevation: 0,
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(Icons.add, color: Colors.white, size: 30),
      //       tooltip: "add a Todo",
      //       onPressed: () {
      //         showDialog(
      //           context: context,
      //           barrierDismissible: true,
      //           child: AddTodoDialog(),
      //         );
      //       },
      //     ),
      //     IconButton(
      //       icon: Icon(Icons.settings),
      //       tooltip: "goes to the settings page",
      //       onPressed: () {
      //         Navigator.of(context).push(
      //           MaterialPageRoute(
      //             builder: (context) {
      //               return SettingsScreen();
      //             },
      //           ),
      //         );
      //       },
      //     )
      //   ],
      // ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.flash_on),
            title: new Text('QuickTodo'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.notifications),
            title: new Text('Reminders'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.cake),
            title: new Text('Birthdays'),
          ),
        ],
      ),
    );
  }
}
