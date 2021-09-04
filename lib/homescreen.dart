import 'package:cfbuddy/Drawer/customdrawer.dart';
import 'package:cfbuddy/model/profilehive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'profile.dart';
import 'leaderboard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int navBarIndex = 0;
  //void _doNothing() {}
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
    //double _wd = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: navBarIndex == 0
              ? const Text("Profile")
              : const Text("LeaderBoard"),
        ),
        drawer: CustomDrawer(myProfile: myProfile),
        body: navBarIndex == 0 ? Profile() : const LeaderBoard(),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          unselectedItemColor: Colors.white38,
          selectedItemColor: Colors.white,
          selectedIconTheme: const IconThemeData(size: 26),
          unselectedIconTheme: const IconThemeData(size: 18),
          onTap: (int val) {
            setState(() {
              navBarIndex = val;
              try {
                myProfile = profileBox.getAt(0);
              } catch (e) {}
            });
          },
          currentIndex: navBarIndex,
          elevation: 2.0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.profile_circled,
                color: Colors.white38,
              ),
              activeIcon: Icon(
                CupertinoIcons.profile_circled,
                color: Colors.white70,
              ),
              label: "Profile",
              backgroundColor: Colors.white38,
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.list_bullet),
              activeIcon: Icon(
                CupertinoIcons.list_bullet,
                color: Colors.white70,
              ),
              label: "LeaderBoard",
            ),
          ],
        ),
      ),
    );
  }
}
