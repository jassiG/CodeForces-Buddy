import 'package:cfbuddy/utilities/config.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'homescreen.dart';
import 'model/handles.dart';
import 'model/profilehive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProfileHiveAdapter());
  Hive.registerAdapter(HandlesAdapter());

  await Hive.openBox<ProfileHive>('ProfileBox');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      title: 'CF Buddy',
      theme: FlexColorScheme.light(scheme: FlexScheme.deepBlue).toTheme,
      darkTheme: FlexColorScheme.dark(scheme: FlexScheme.deepBlue).toTheme,
      themeMode: currentTheme.currentTheme(),
      home: const HomeScreen(),
    );
  }
}
