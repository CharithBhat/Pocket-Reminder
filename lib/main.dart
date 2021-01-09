import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/provider/app_theme_notifier.dart';
import 'package:todo_application/provider/todo_list.dart';
import 'package:todo_application/utilities/app_theme.dart';
import './screens/home_screen.dart';
import 'package:flutter/services.dart';
import 'database/dbhelper.dart';

import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager.initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  Workmanager.registerOneOffTask("1", "simpleTask");
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AppThemeNotifier>(
              create: (context) => AppThemeNotifier(),
            ),
            ChangeNotifierProvider<TodoList>(
              create: (context) => TodoList(),
            ),
          ],
          child: MyApp(),
        ),
      );
    },
  );
}

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) {
    return Future.value(true);
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
    getitems();
  }

  void getitems() async {
    final provider = Provider.of<TodoList>(context, listen: false);
    final dbhelper = DatabaseHelper.instance;
    final theList = await dbhelper.queryall();
    for (var item in theList) {
      provider.addTodo(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeNotifier>(
      builder: (context, appTheme, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: appTheme.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
          home: HomeScreen(),
        );
      },
    );
  }
}
