import 'dart:ui';

import 'package:cfbuddy/model/profilehive.dart';
import 'package:cfbuddy/utilities/rating_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'utilities/response.dart';

class Profile extends StatefulWidget {
  RatingHistory ratingHistory;
  ProfileHive myProfile;
  Profile({
    Key? key,
    required this.ratingHistory,
    required this.myProfile,
  }) : super(key: key);
  static User user = User();

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
                constraints: BoxConstraints(
                  minHeight: screenSize.height - 150 + 10,
                ),
                //height: screenSize.height - 150 + 10,
                padding: const EdgeInsets.only(top: 100), // Padding For Profile
                color: Colors.red,
                child: Container(
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    color: Theme.of(context).cardColor,
                    shadows: [
                      const BoxShadow(
                          blurRadius: 20.0,
                          offset: Offset(0, -8),
                          color: Colors.black12,
                          spreadRadius: 5.0),
                      BoxShadow(
                          blurRadius: 8.0,
                          offset: const Offset(0, 10),
                          color: Theme.of(context).backgroundColor,
                          spreadRadius: 5.0),
                    ],
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Divider(height: 150 / 2, color: Colors.transparent),
                      profileWidgets(),
                    ],
                  ),
                ),
              ),
              Container(
                width: 150,
                height: 150,
                margin: EdgeInsets.only(
                    left: screenSize.width * 0.5 - 150 / 2, top: 100 - 150 / 2),
                padding: const EdgeInsets.all(5.0),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).cardColor,
                  radius: 150 / 2,
                  foregroundImage: widget.myProfile.titlePhoto == "NA"
                      ? Image.asset('assets/noimagefound.png').image
                      : Image.network(widget.myProfile.titlePhoto).image,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget profileWidgets() {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            widget.myProfile.handle,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Divider(
          height: 50,
          indent: 10,
          endIndent: 10,
          color: Colors.transparent,
        ),
        //const Text("Rating History: \n"),
        Padding(
          padding: const EdgeInsets.all(4),
          child: infoCard(),
        )
      ],
    );
  }

  Widget infoCard() {
    return Card(
      elevation: 5.0,
      color: Theme.of(context).canvasColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ratingChartWidget(),
    );
  }

  Widget ratingChartWidget() {
    return SfCartesianChart(
      title: ChartTitle(text: "Rating History"),
      primaryXAxis: DateTimeAxis(),
      series: [
        LineSeries(
            dataSource: widget.ratingHistory.ratings,
            xValueMapper: (datum, index) => DateTime.fromMillisecondsSinceEpoch(
                widget.ratingHistory.updateTimes[index] * 1000),
            yValueMapper: (datum, index) => widget.ratingHistory.ratings[index])
      ],
      margin: const EdgeInsets.all(10),
    );
  }
}
