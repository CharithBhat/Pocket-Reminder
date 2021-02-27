import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/provider/app_theme_notifier.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Settings',
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
        backgroundColor: Theme.of(context).appBarTheme.color,
        elevation: 2,
        toolbarHeight: 50,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          children: [
            SwitchListTile(
            title: Text('Dark Mode'),
            value:
                Provider.of<AppThemeNotifier>(context, listen: true).isDarkModeOn,
            onChanged: (boolVal) {
              Provider.of<AppThemeNotifier>(context, listen: false)
                  .updateTheme(boolVal);
            },
          ),
          ],
        ),
      ),
    );
  }
}