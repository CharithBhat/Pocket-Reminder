import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/provider/app_theme_notifier.dart';
import 'package:todo_application/provider/todo_list.dart';
import 'package:todo_application/utilities/app_theme.dart';
import './screens/home_screen.dart';
import 'package:flutter/services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
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

class MyApp extends StatelessWidget {
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
