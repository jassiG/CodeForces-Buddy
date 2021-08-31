import 'package:cfbuddy/Drawer/settings.dart';
import 'package:cfbuddy/model/profilehive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'profile.dart';
import 'leaderboard.dart';
import 'Drawer/setprofile.dart';

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
    myProfile = profileBox.getAt(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //double _wd = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: navBarIndex == 0
            ? const Text("Profile")
            : const Text("LeaderBoard"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: myProfile.titlePhoto == "NA"
                  ? Image.asset('assets/noimagefound.png')
                  : Image.network(
                      myProfile.titlePhoto,
                      fit: BoxFit.,
                    ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Settings())),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Change Profile"),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SetProfile())),
            ),
            const ListTile(
              leading: Icon(Icons.info),
              title: Text("About"),
            )
          ],
        ),
      ),
      body: navBarIndex == 0 ? Profile() : LeaderBoard(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        unselectedItemColor: Colors.white38,
        selectedItemColor: Colors.white,
        selectedIconTheme: const IconThemeData(size: 26),
        unselectedIconTheme: const IconThemeData(size: 18),
        onTap: (int val) {
          setState(() {
            navBarIndex = val;
            myProfile = profileBox.getAt(0);
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
    );
  }
}
