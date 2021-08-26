import 'package:flutter/material.dart';

class MyTheme with ChangeNotifier {
  // ignore: prefer_final_fields
  static bool _isDark = true;

  ThemeMode currentTheme() {
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme() {
    _isDark != _isDark;
    notifyListeners();
  }

  void setLight() {
    _isDark = false;
    notifyListeners();
  }

  void setDark() {
    _isDark = true;
    notifyListeners();
  }

  void setDarkViaBool(bool dark) {
    _isDark = dark;
    notifyListeners();
  }

  bool getDark() {
    return _isDark;
  }
}
