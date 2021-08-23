import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'homescreen.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'This',
      theme: FlexColorScheme.light(scheme: FlexScheme.deepBlue).toTheme,
      darkTheme: FlexColorScheme.dark(scheme: FlexScheme.deepBlue).toTheme,
      //theme: Theme(data: ThemeData(backgroundColor: Color.fromRGBO(r, g, b, opacity)),),
      themeMode: ThemeMode.system,
      home: HomeScreen(),
    );
  }
}