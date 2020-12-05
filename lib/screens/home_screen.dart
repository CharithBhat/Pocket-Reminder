import 'package:flutter/material.dart';
import 'package:todo_application/screens/settings_screen.dart';
import '../widgets/place_holder.dart';

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
      PlaceholderWidget(Colors.white),
      PlaceholderWidget(Colors.orange),
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
        onTap: onTabTapped, // new
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
    );
  }
}
