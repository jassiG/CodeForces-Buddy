import 'package:cfbuddy/model/profilehive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'utilities/response.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);
  static User user = User();

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  MyResponse response = MyResponse(users: [Profile.user]);

  Box profileBox = Hive.box<ProfileHive>('ProfileBox');

  ProfileHive myProfile =
      ProfileHive(handle: 'NA', rating: 0, rank: 'noob', titlePhoto: "NA");

  @override
  void initState() {
    try {
      myProfile = profileBox.getAt(0);
    } catch (e) {
      myProfile = myProfile;
    }
    super.initState();
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
                    child: Text(
                      myProfile.handle,
                      style: const TextStyle(
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
            child: CircleAvatar(
              radius: 150 / 2,
              foregroundImage: myProfile.titlePhoto == "NA"
                  ? Image.asset('assets/noimagefound.png').image
                  : Image.network(myProfile.titlePhoto).image,
            ),
          ),
        ],
      ),
    );
  }
}
