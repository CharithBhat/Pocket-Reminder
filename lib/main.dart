import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/provider/app_theme_notifier.dart';
import 'package:todo_application/utilities/app_theme.dart';
import './screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppThemeNotifier>(
           create: (context) => AppThemeNotifier(),
        ),
      ],
      child: MyApp(),
    )
    );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: HomeScreen(),
    );
  }
}

