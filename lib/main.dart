import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'homescreen.dart';
import 'Drawer/settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  String themeS = "System"; //Settings().themeSettings"";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'This',
      theme: FlexColorScheme.light(scheme: FlexScheme.deepBlue).toTheme,
      darkTheme: FlexColorScheme.dark(scheme: FlexScheme.deepBlue).toTheme,
      //theme: Theme(data: ThemeData(backgroundColor: Color.fromRGBO(r, g, b, opacity)),),
      themeMode: themeS == "System"
          ? ThemeMode.system
          : themeS == "Light"
              ? ThemeMode.light
              : ThemeMode.dark,
      home: const HomeScreen(),
    );
  }
}
