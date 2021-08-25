import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'utilities/response.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);
  static User user = User();
  Response response = Response(users: [user]);

  void _printResponse() {
    print(response.status);
    print(response.users[0].rating);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 150), // Padding For Profile
      color: Colors.white38,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
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
          children: [
            const Text(
              "Profile",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
