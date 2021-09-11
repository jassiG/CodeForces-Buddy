import 'dart:ui';

import 'package:cfbuddy/model/profilehive.dart';
import 'package:cfbuddy/utilities/rating_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
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
  double smoothness = 0.0;
  int currentRating = 0;
  int prevRating = 0;
  @override
  Widget build(BuildContext context) {
    setState(() {
      currentRating =
          widget.ratingHistory.ratings[widget.ratingHistory.ratings.length - 1];
      prevRating =
          widget.ratingHistory.ratings[widget.ratingHistory.ratings.length - 2];
    });
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
                child: widget.myProfile.titlePhoto == "NA"
                    ? Image.asset('assets/noimagefound.png')
                    : Image.network(
                        widget.myProfile.titlePhoto,
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
                width: double.infinity,
                constraints: BoxConstraints(
                  minHeight: screenSize.height - 150 + 10,
                ),
                //height: screenSize.height - 150 + 10,
                padding: const EdgeInsets.only(top: 100), // Padding For Profile
                child: Container(
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.07),
                        Colors.grey.shade800.withOpacity(0.09),
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
          child: Column(
            children: [
              Text(
                widget.myProfile.handle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.myProfile.rating.toString() + " ",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  currentRating >= prevRating
                      ? Row(
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          //textBaseline: TextBaseline.alphabetic,
                          children: [
                            const Icon(
                              Icons.arrow_upward,
                              size: 13,
                              color: Colors.green,
                            ),
                            Text(
                              (currentRating - prevRating).toString(),
                              style: const TextStyle(
                                color: Colors.green,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            const Icon(
                              Icons.arrow_downward,
                              size: 13,
                              color: Colors.red,
                            ),
                            Text(
                              (prevRating - currentRating).toString(),
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ],
                        )
                ],
              ),
            ],
          ),
        ),
        const Divider(
          height: 10,
          indent: 20,
          endIndent: 20,
          //color: Colors.transparent,
        ),
        //const Text("Rating History: \n"),
        Padding(
          padding: const EdgeInsets.all(4),
          child: infoCard(ratingChartWidget()),
        )
      ],
    );
  }

  Widget infoCard(Widget child) {
    return Card(
      elevation: 4.0,
      color: Theme.of(context).canvasColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  Widget ratingChartWidget() {
    double currentRating = 1.0 * widget.ratingHistory.ratings[0];
    return Column(
      children: [
        SfCartesianChart(
          title: ChartTitle(text: "Rating History"),
          primaryXAxis: DateTimeAxis(),
          zoomPanBehavior: ZoomPanBehavior(
            enablePanning: true,
            enablePinching: true,
            maximumZoomLevel: 5.0,
          ),
          series: [
            LineSeries(
                dataSource: widget.ratingHistory.ratings,
                xValueMapper: (datum, index) =>
                    DateTime.fromMillisecondsSinceEpoch(
                        widget.ratingHistory.updateTimes[index] * 1000),
                yValueMapper: (datum, index) {
                  if (index == 0) {
                    return widget.ratingHistory.ratings[index];
                  } else {
                    currentRating = (smoothness) * currentRating +
                        (1.0 - smoothness) *
                            widget.ratingHistory.ratings[index];
                    return currentRating;
                  }
                })
          ],
          margin: const EdgeInsets.all(10),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Smoothness"),
            Slider(
              value: smoothness,
              onChanged: (value) {
                smoothness = value;
                //_update();
                setState(() {});
              },
              min: 0.0,
              max: 0.90,
              //label: ((smoothness * 10).round()).toString(),
              divisions: 3,
            ),
          ],
        ),
      ],
    );
  }
}
