import 'package:cfbuddy/utilities/config.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'homescreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String themeS = "System";
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      //print("Theme Changed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'This',
      theme: FlexColorScheme.light(scheme: FlexScheme.deepBlue).toTheme,
      darkTheme: FlexColorScheme.dark(scheme: FlexScheme.deepBlue).toTheme,
      themeMode: currentTheme.currentTheme(),
      home: const HomeScreen(),
    );
  }
}
