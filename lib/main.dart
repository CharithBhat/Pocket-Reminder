import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/provider/app_theme_notifier.dart';
import 'package:todo_application/provider/todo_list.dart';
import 'package:todo_application/utilities/app_theme.dart';
import './screens/home_screen.dart';
import 'package:flutter/services.dart';
import 'database/dbhelper.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager.initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager.registerPeriodicTask(
    "2",

    //This is the value that will be
    // returned in the callbackDispatcher
    "simplePeriodicTask",

    // When no frequency is provided
    // the default 15 minutes is set.
    // Minimum frequency is 15 min.
    // Android will automatically change
    // your frequency to 15 min
    // if you have configured a lower frequency.
    frequency: Duration(minutes: 15),
  );
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
    // initialise the plugin of flutterlocalnotifications.
    FlutterLocalNotificationsPlugin flip =
        new FlutterLocalNotificationsPlugin();

    // app_icon needs to be a added as a drawable
    // resource to the Android head project.
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var IOS = new IOSInitializationSettings();

    // initialise settings for both Android and iOS device.
    var settings = new InitializationSettings(android: android, iOS: IOS);
    flip.initialize(settings);
    _showNotificationWithDefaultSound(flip);
    return Future.value(true);
  });
}

Future _showNotificationWithDefaultSound(flip) async {
  // Show a notification after every 15 minute with the first
  // appearance happening a minute after invoking the method
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    'your channel description',
    importance: Importance.max,
    priority: Priority.min,
  );
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

  // initialise channel platform for both Android and iOS device.
  var platformChannelSpecifics = new NotificationDetails(
    // androidPlatformChannelSpecifics,
    // iOSPlatformChannelSpecifics
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );
  await flip.show(
      0,
      'GeeksforGeeks',
      'Your are one step away to connect with GeeksforGeeks',
      platformChannelSpecifics,
      payload: 'Default_Sound');
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
