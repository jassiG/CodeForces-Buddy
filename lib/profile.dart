import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'utilities/response.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);
  static User user = User();
  MyResponse response = MyResponse(users: [user]);

  void _printResponse() {
    print(response.status);
    print(response.users[0].rating);
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 1000,
            padding: const EdgeInsets.only(top: 150), // Padding For Profile
            color: Colors.white38,
            child: Container(
              width: double.infinity,
              decoration: ShapeDecoration(
                color: Theme.of(context).cardColor,
                shadows: const [
                  BoxShadow(
                      blurRadius: 15.0,
                      offset: Offset(0, 0),
                      color: Colors.black12,
                      spreadRadius: 5.0)
                ],
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Divider(height: 150 / 2, color: Colors.transparent),
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 50,
                    indent: 10,
                    endIndent: 10,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 150,
            height: 150,
            margin: EdgeInsets.only(
                left: _screenWidth * 0.5 - 150 / 2, top: 150 - 150 / 2),
            padding: const EdgeInsets.all(5.0),
            child: Container(
              child: const CircleAvatar(
                radius: 150 / 2,
                child: FlutterLogo(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
