import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'utilities/response.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  MyResponse response = generateDummyResponse(5);
  final myController = TextEditingController();

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
                //color: Theme.of(context).backgroundColor,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.07),
                        //Colors.grey.shade800.withOpacity(0.09),
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
                  child: Column(
                    children: [
                      const Divider(
                        height: 20,
                        color: Colors.transparent,
                      ),
                      const Text(
                        "LeaderBoard",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
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
                          for (int i = 0; i < response.users.length; i++)
                            Slidable(
                              actionPane: const SlidableDrawerActionPane(),
                              child: ListTile(
                                leading: const Icon(Icons.person),
                                title: Text(response.users[i].handle),
                                trailing:
                                    Text(response.users[i].rating.toString()),
                              ),
                              actions: <Widget>[
                                IconSlideAction(
                                  caption: 'Delete',
                                  color: Colors.red,
                                  icon: Icons.delete,
                                  onTap: () => setState(() {
                                    response.users.removeAt(i);
                                  }),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
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
              MyResponse fuckingFinally = await getMyResponse('jassigill');
              response.users.add(fuckingFinally.users[0]);
              setState(() {
                response.users.sort((a, b) => b.rating.compareTo(a.rating));
              });
            },
            child: const Icon(Icons.info),
          ),
        )
      ],
    );
  }
}
