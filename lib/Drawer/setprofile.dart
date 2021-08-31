import 'package:cfbuddy/model/profilehive.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:cfbuddy/utilities/response.dart' as responses;
import 'package:http/http.dart';

class SetProfile extends StatefulWidget {
  const SetProfile({Key? key}) : super(key: key);

  @override
  _SetProfileState createState() => _SetProfileState();
}

class _SetProfileState extends State<SetProfile> {
  final myController = TextEditingController();
  Box profileBox = Hive.box<ProfileHive>('ProfileBox');
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
                  onPressed: () async {
                    try {
                      responses.MyResponse tempResponse =
                          await responses.getMyResponse(myController.text);
                      if (tempResponse.status != 'OK') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Sorry, No Such User Found"),
                          duration: Duration(milliseconds: 1000),
                        ));
                      } else {
                        profileBox = updateProfileFromHandle(
                          profileBox,
                          tempResponse.users[0].handle,
                          tempResponse.users[0].rating,
                          tempResponse.users[0].rank,
                          tempResponse.users[0].titlePhoto,
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("User has been added successfully"),
                          duration: const Duration(milliseconds: 1000),
                        ));
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("User Not Found"),
                        duration: Duration(milliseconds: 1000),
                      ));
                    }
                  },
                  child: const Text("Get Profile")),
            ],
          ),
        ));
  }
}
