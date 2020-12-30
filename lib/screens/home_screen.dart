import 'package:flutter/material.dart';
import 'package:todo_application/screens/settings_screen.dart';
import 'package:todo_application/widgets/all_tasks.dart';
import 'package:todo_application/widgets/completed_tasks.dart';
import '../widgets/add_todo_dialog.dart';

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
      AllTasks(),
      CompletedTasks(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todo Application',
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).appBarTheme.color,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add,color: Colors.white),
            tooltip: "add a Todo",
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
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.all_inclusive),
            title: new Text('All'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.done),
            title: new Text('completed'),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     showDialog(
      //       context: context,
      //       barrierDismissible: true,
      //       child: AddTodoDialog(),
      //     );
      //   },
      //   child: Icon(Icons.add, color: Colors.white),
      //   backgroundColor: Colors.green,
      // ),
    );
  }
}
