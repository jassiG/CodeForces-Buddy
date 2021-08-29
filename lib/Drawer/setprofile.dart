import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SetProfile extends StatefulWidget {
  const SetProfile({Key? key}) : super(key: key);

  @override
  _SetProfileState createState() => _SetProfileState();
}

class _SetProfileState extends State<SetProfile> {
  final myController = TextEditingController();
  Box profileBox = Hive.box('ProfileBox');
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile Settings"),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: myController,
              ),
              const Divider(
                height: 20,
                color: Colors.transparent,
              ),
              ElevatedButton(
                  onPressed: () {
                    profileBox.clear();
                    profileBox.add(myController.text);
                    print(profileBox.getAt(0));
                  },
                  child: const Text("Get Profile")),
            ],
          ),
        ));
  }
}
