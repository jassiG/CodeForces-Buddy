import 'package:cfbuddy/model/profilehive.dart';
import 'package:cfbuddy/utilities/rating_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'utilities/response.dart';

class Profile extends StatefulWidget {
  //List<int> ratingList;
  RatingHistory ratingHistory;
  ProfileHive myProfile;
  Profile({
    Key? key,
    //required this.ratingList,
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
        Container(
          width: screenSize.width,
          height: screenSize.height,
          color: Colors.grey.shade600,
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                //height: screenSize.height - 150 + 10,
                padding: const EdgeInsets.only(top: 100), // Padding For Profile
                color: Colors.grey.shade600,
                child: Container(
                  width: double.infinity,
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Divider(height: 150 / 2, color: Colors.transparent),
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
                      const Text("Rating History: \n"),
                      SfCartesianChart(
                        primaryXAxis: DateTimeAxis(),
                        series: [
                          LineSeries(
                              dataSource: widget.ratingHistory.ratings,
                              xValueMapper: (datum, index) =>
                                  DateTime.fromMillisecondsSinceEpoch(
                                      widget.ratingHistory.updateTimes[index] *
                                          1000),
                              yValueMapper: (datum, index) =>
                                  widget.ratingHistory.ratings[index])
                        ],
                        margin: const EdgeInsets.all(10),
                      ),
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
}
