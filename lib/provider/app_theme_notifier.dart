import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeNotifier extends ChangeNotifier{
  
  final String key = "theme";
  SharedPreferences _pref;
  bool isDarkModeOn;

  AppThemeNotifier(){
    isDarkModeOn = false;
    loadFromPrefs();
  }

  void updateTheme(bool isDarkModeOn){
    this.isDarkModeOn = isDarkModeOn;
    _saveToPrefs(); 
    notifyListeners();
  }

  initPrefs() async {
    if(_pref == null)
      _pref  = await SharedPreferences.getInstance();
  }
  loadFromPrefs() async {
      await initPrefs();
      isDarkModeOn = _pref.getBool(key) ?? false;
      notifyListeners();
  }
  _saveToPrefs() async {
    await initPrefs();
    _pref.setBool(key, isDarkModeOn);
  }
}

