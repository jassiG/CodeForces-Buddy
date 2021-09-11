import 'package:cfbuddy/model/profilehive.dart';
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
  MyResponse response = generateDummyResponse(5);
  final _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    response.users.sort((a, b) => b.rating.compareTo(a.rating));
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
                color: Colors.grey.shade400,
              ),
              Column(
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
              Container(
                height: screenSize.height - 150 + 10,
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 100), // Padding For Profile
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
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
            ],
          ),
        ),
        Positioned(
          right: 10,
          bottom: 10,
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                response = addDummyUser(response);
                response.users.sort((a, b) => b.rating.compareTo(a.rating));
              });
            },
            child: const Icon(Icons.add),
          ),
        ),
        Positioned(
          left: 10,
          bottom: 10,
          child: FloatingActionButton(
            onPressed: () async {
              _displayTextInputDialog(context);
            },
            child: const Icon(Icons.info),
          ),
        )
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
            for (ProfileHive profile in widget.friendProfilesBox.values)
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
                      Key key = profile.key;
                      widget.friendProfilesBox.delete(key);
                    }),
                  ),
                ],
              ),
          ],
        ),
      ],
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
        widget.friendProfilesBox = updateProfileFromHandle(
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
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("User Not Found"),
        duration: Duration(milliseconds: 1000),
      ));
    }
  }
}
