import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/provider/app_theme_notifier.dart';
import 'package:todo_application/provider/birthdayTodo_list.dart';
import 'package:todo_application/provider/quickTodo_list.dart';
import 'package:todo_application/provider/reminderTodo_list.dart';
import 'package:todo_application/utilities/app_theme.dart';
import './screens/home_screen.dart';
import 'package:flutter/services.dart';
import 'database/dbhelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AppThemeNotifier>(
              create: (context) => AppThemeNotifier(),
            ),
            ChangeNotifierProvider<ReminderTodoList>(
              create: (context) => ReminderTodoList(),
            ),
            ChangeNotifierProvider<QuickTodoList>(
              create: (context) => QuickTodoList(),
            ),
            ChangeNotifierProvider<BirthdayTodoList>(
              create: (context) => BirthdayTodoList(),
            ),
          ],
          child: MyApp(),
        ),
      );
    },
  );
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
    final provider = Provider.of<ReminderTodoList>(context, listen: false);
    final quickProvider = Provider.of<QuickTodoList>(context, listen: false);
    final birthdayProvider = Provider.of<BirthdayTodoList>(context, listen: false);
    final dbhelper = DatabaseHelper.instance;
    final theList = await dbhelper.queryallReminderTodo();
    final quickTodoList = await dbhelper.queryallQuickTodo();
    final birthdayTodoList = await dbhelper.queryallBirthdayTodo();
    for (var item in theList) {
      provider.addReminderTodo(item);
    }
    for(var item in quickTodoList){
      quickProvider.addQuickTodo(item);
    }
    for(var item in birthdayTodoList){
      birthdayProvider.addBirthdayTodo(item);
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
