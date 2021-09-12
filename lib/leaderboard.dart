import 'dart:ui';

import 'package:cfbuddy/model/profilehive.dart';
import 'package:cfbuddy/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'utilities/response.dart';
import 'package:cfbuddy/utilities/response.dart' as responses;

class LeaderBoard extends StatefulWidget {
  Box friendProfilesBox;
  LeaderBoard({
    Key? key,
    required this.friendProfilesBox,
  }) : super(key: key);

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  //MyResponse response = generateDummyResponse(5);
  final _textFieldController = TextEditingController();
  var friendProfileList;
  @override
  void initState() {
    friendProfileList = widget.friendProfilesBox.values.toList();
    setState(() {
      friendProfileList.sort((a, b) => b.toString().compareTo(a.toString()));
    });
    super.initState();
    //response.users.sort((a, b) => b.rating.compareTo(a.rating));
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 100 + 40,
                color: Colors.grey.shade400.withOpacity(0.2),
                child: friendProfileList.length == 0
                    ? const Text("")
                    : Image.network(
                        friendProfileList[0].titlePhoto,
                        alignment: Alignment.center,
                        fit: BoxFit.fitWidth,
                      ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 4.0,
                  sigmaY: 4.0,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      width: 100,
                      height: 100,
                    ),
                    Container(
                      width: double.infinity,
                      height: 100,
                      decoration: ShapeDecoration(
                        color: Theme.of(context).backgroundColor,
                        // color: Colors.red,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: screenSize.height - 150 + 10,
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 100), // Padding For Profile
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 150 / 2),
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.07),
                        Theme.of(context).backgroundColor.withOpacity(0.0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                  ),
                  child: leaderboardBody(),
                ),
              ),
              // Container(
              //   width: 150,
              //   height: 150,
              //   margin: EdgeInsets.only(
              //       left: screenSize.width * 0.5 - 150 / 2, top: 100 - 150 / 2),
              //   padding: const EdgeInsets.all(5.0),
              //   child: Container(
              //       decoration: BoxDecoration(
              //         color: Colors.grey,
              //         border: Border.all(color: Colors.yellow, width: 2),
              //       ),
              //       //backgroundColor: Theme.of(context).cardColor,
              //       // radius: 150 / 2,
              //       child: friendProfileList.length < 1
              //           ? const Text("")
              //           : Image.network(friendProfileList[0].titlePhoto)),
              // ),
              titlePhoto(
                2,
                screenSize.width * 0.5 - (120 / 2) - 100 + 10,
                100 + 120 / 2 - 100,
                100,
              ),
              titlePhoto(
                3,
                screenSize.width * 0.5 +
                    (120 / 2) -
                    1 -
                    10, // Why tf do I have to subtract 1?
                100 + 120 / 2 - 90,
                90,
              ),
              titlePhoto(
                1,
                screenSize.width * 0.5 - 120 / 2,
                100 - 120 / 2,
                120,
              ),
            ],
          ),
        ),
        Positioned(
          right: 10,
          bottom: 10,
          child: FloatingActionButton(
            onPressed: () {
              _displayTextInputDialog(context);
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Widget leaderboardBody() {
    return Column(
      children: [
        const Divider(
          height: 20,
          color: Colors.transparent,
        ),
        const Text(
          "LeaderBoard",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        const Divider(
          height: 50,
          indent: 10,
          endIndent: 10,
        ),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            for (ProfileHive profile in friendProfileList)
              Slidable(
                actionPane: const SlidableDrawerActionPane(),
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(profile.handle),
                  trailing: Text(profile.rating.toString()),
                ),
                actions: <Widget>[
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () => setState(() {
                      widget.friendProfilesBox.delete(profile.key);
                      friendProfileList =
                          widget.friendProfilesBox.values.toList();
                    }),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }

  Widget titlePhoto(int rank, double leftMargin, double topMargin, int size) {
    return Container(
      width: size * 1.0,
      height: size * 1.0,
      margin: EdgeInsets.only(left: leftMargin * 1.0, top: topMargin * 1.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          boxShadow: const [
            BoxShadow(blurRadius: 5.0, color: Colors.black54),
          ],
          border: Border.all(
              color: rank == 1
                  ? Colors.yellow
                  : rank == 2
                      ? Colors.grey.shade200
                      : rank == 3
                          ? Colors.orangeAccent
                          : Colors.grey,
              width: 2),
        ),
        //backgroundColor: Theme.of(context).cardColor,
        // radius: 150 / 2,
        child: friendProfileList.length < rank
            ? const Text("")
            : Image.network(
                friendProfileList[rank - 1].titlePhoto,
                fit: BoxFit.fill,
              ),
      ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Type in the user handle to be added.'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: "Enter User Handle"),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text('Add User'),
              onPressed: () {
                //print(_textFieldController.text);
                _addFriendProfile();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _addFriendProfile() async {
    try {
      responses.MyResponse tempResponse =
          await responses.getMyResponse(_textFieldController.text);
      if (tempResponse.status != 'OK') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Sorry, No Such User Found"),
          duration: Duration(milliseconds: 1000),
        ));
      } else {
        widget.friendProfilesBox = updateFriendProfileFromHandle(
          widget.friendProfilesBox,
          tempResponse.users[0].handle,
          tempResponse.users[0].rating,
          tempResponse.users[0].rank,
          tempResponse.users[0].titlePhoto,
        );
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("User has been added successfully"),
          duration: Duration(milliseconds: 1000),
        ));
        setState(() {
          friendProfileList = widget.friendProfilesBox.values.toList();
          friendProfileList
              .sort((a, b) => b.toString().compareTo(a.toString()));
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("User Not Found"),
        //content: Text(e.toString()),
        duration: Duration(milliseconds: 1000),
      ));
    }
  }

  Future<void> _updateFriendsProfiles() async {
    for (int index = 0; index < widget.friendProfilesBox.length; index++) {
      String handle = widget.friendProfilesBox.getAt(index).toString();
      
    }
  }
}
