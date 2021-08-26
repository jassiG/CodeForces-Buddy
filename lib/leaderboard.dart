import 'package:flutter/material.dart';
import 'utilities/response.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  Response response = generateDummyResponse(5);
  @override
  void initState() {
    super.initState();
    response.users.sort((a, b) => b.rating.compareTo(a.rating));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
                for (int i = 0; i < response.users.length; i++)
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(response.users[i].handle),
                    trailing: Text(response.users[i].rating.toString()),
                    onLongPress: () {
                      setState(() {
                        response.users.removeAt(i);
                      });
                    },
                  )
              ],
            ),
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
            child: Icon(Icons.add),
          ),
        )
      ],
    );
  }
}
