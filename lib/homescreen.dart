import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //void _doNothing() {}

  @override
  Widget build(BuildContext context) {
    //double _wd = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('This'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: Text("HomeScreen"),
        ),
    );
  }
}
