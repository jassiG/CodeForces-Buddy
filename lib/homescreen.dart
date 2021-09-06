import 'dart:io';

import 'package:cfbuddy/Drawer/customdrawer.dart';
import 'package:cfbuddy/model/profilehive.dart';
import 'package:cfbuddy/utilities/ratingHistory.dart';
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
  RatingHistory myRatings = RatingHistory(status: 'OK', ratings: [0, 0]);
  List<int> ratingList = [0, 0];

  int navBarIndex = 0;

  Box profileBox = Hive.box<ProfileHive>('ProfileBox');
  ProfileHive myProfile =
      ProfileHive(handle: 'NA', rating: 0, rank: 'noob', titlePhoto: "NA");

  bool drawerState = false;

  @override
  void initState() {
    try {
      myProfile = profileBox.getAt(0);
      setState(() {});
      print("profile after initState: " + myProfile.handle);
      sleep(Duration(milliseconds: 1000));
    } catch (e) {
      myProfile = myProfile;
    }
    try {
      //sleep(Duration(milliseconds: 1000));
      _getMyRatingHistory();
      print("Get rating done!");
    } catch (e) {
      myRatings = myRatings;
    }
    ratingList = myRatings.ratings;
    print(ratingList);
    super.initState();
  }

  _getMyRatingHistory() async {
    myRatings = await getMyRatingHistory(myProfile.handle);
    setState(() {});
    ratingList = myRatings.ratings;
    //print(myRatings.ratings);
    //setState(() {});
    //print("setState in getRating");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: navBarIndex == 0
              ? const Text("Profile")
              : const Text("LeaderBoard"),
        ),
        //Frosted glass Custom Drawer, located in Drawer Folder
        drawer: CustomDrawer(myProfile: myProfile),
        onDrawerChanged: (drawerState) {
          if (!drawerState) {
            setState(() {
              try {
                myProfile = profileBox.getAt(0);
                _getMyRatingHistory();
              } catch (e) {}
            });
          }
          //drawerState = !drawerState;
          print(drawerState);
        },
        body: navBarIndex == 0
            ? Profile(
                ratingList: ratingList,
                myProfile: myProfile,
              )
            : const LeaderBoard(),

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
                _getMyRatingHistory();
              } catch (e) {}
              print("Profile after setState: " + myProfile.handle);
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
