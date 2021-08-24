import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cfbuddy/main.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);
  String themeSettings = "System";
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List<String> _themes = ['Light', 'Dark', 'System']; // Option 2
  String _selectedTheme = 'System'; // Option 2
  final set = Settings();

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("App Theme "),
                DropdownButton(
                  hint: const Text(
                      'Please choose a Theme'), // Not necessary for Option 1
                  value: _selectedTheme,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedTheme = newValue.toString();
                      set.themeSettings = newValue.toString();
                    });
                  },
                  items: _themes.map((theme) {
                    return DropdownMenuItem(
                      child: new Text(theme),
                      value: theme,
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
