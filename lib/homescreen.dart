import 'package:cfbuddy/Drawer/customdrawer.dart';
import 'package:cfbuddy/model/profilehive.dart';
import 'package:cfbuddy/utilities/rating_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'profile.dart';
import 'leaderboard.dart';

class HomeScreen extends StatefulWidget {
  Function callBack;
  RatingHistory myRatings;
  ProfileHive myProfile;
  Box friendProfilesBox;
  //List<int> ratingList;
  Box profileBox;
  HomeScreen({
    Key? key,
    required this.myRatings,
    required this.myProfile,
    //required this.ratingList,
    required this.profileBox,
    required this.callBack,
    required this.friendProfilesBox,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int navBarIndex = 0;
  @override
  void initState() {
    _getMyRatingHistory();
    super.initState();
  }

  _getMyRatingHistory() async {
    widget.myRatings = await getMyRatingHistory(widget.myProfile.handle);
    setState(() {});
    //widget.ratingList = widget.myRatings.ratings;
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
        drawer: CustomDrawer(myProfile: widget.myProfile),
        onDrawerChanged: (drawerState) {
          if (!drawerState) {
            widget.callBack();
          }
          //drawerState = !drawerState;
          //print(drawerState);
        },
        body: navBarIndex == 0
            ? Profile(
                //ratingList: widget.ratingList,
                ratingHistory: widget.myRatings,
                myProfile: widget.myProfile,
              )
            : LeaderBoard(
              friendProfilesBox: widget.friendProfilesBox,
            ),

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
                widget.myProfile = widget.profileBox.getAt(0);
                _getMyRatingHistory();
              } catch (_) {}
              //print("Profile after setState: " + myProfile.handle);
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
