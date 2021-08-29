import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cfbuddy/utilities/config.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);
  String themeSettings = "System";
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool themeValue = currentTheme.getDark();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.wb_sunny),
              title: const Text("Dark Theme", style: TextStyle(fontSize: 18)),
              trailing: Switch(
                value: themeValue,
                onChanged: (value) {
                  setState(() {
                    themeValue = value;
                  });
                  currentTheme.setDarkViaBool(value);
                  //print(value);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
