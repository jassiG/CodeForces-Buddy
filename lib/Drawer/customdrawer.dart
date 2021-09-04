import 'dart:ui';

import 'package:cfbuddy/Drawer/setprofile.dart';
import 'package:cfbuddy/Drawer/settings.dart';
import 'package:cfbuddy/model/profilehive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomDrawer extends StatelessWidget {
  final ProfileHive myProfile;
  const CustomDrawer({Key? key, required this.myProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white.withOpacity(0.4),
        ),
        child: Drawer(
          elevation: 5.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DrawerHeader(
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(0),
                child: myProfile.titlePhoto == "NA"
                    ? Image.asset('assets/noimagefound.png')
                    : Image.network(
                        myProfile.titlePhoto,
                        fit: BoxFit.fitWidth,
                      ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  //mainAxisSize: MainAxisSize.max,
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.settings,
                        color: Colors.black87,
                      ),
                      title: const Text(
                        "Settings",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Settings())),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: Colors.black87,
                      ),
                      title: const Text(
                        "Change Profile",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SetProfile())),
                    ),
                    const ListTile(
                      leading: Icon(
                        Icons.info,
                        color: Colors.black87,
                      ),
                      title: Text(
                        "About",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
                indent: 20,
                endIndent: 20,
                //color: Colors.grey.shade500,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Made With ❤ By JassiG"),
                ],
              ),
              Divider(
                color: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
