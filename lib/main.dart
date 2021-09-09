import 'package:cfbuddy/utilities/config.dart';
import 'package:cfbuddy/utilities/ratingHistory.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'homescreen.dart';
import 'model/handles.dart';
import 'model/profilehive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProfileHiveAdapter());
  Hive.registerAdapter(HandlesAdapter());

  await Hive.openBox<ProfileHive>('ProfileBox');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  RatingHistory myRatings = RatingHistory(status: 'OK', ratings: [0, 0]);
  List<int> ratingList = [0, 0];

  Box profileBox = Hive.box<ProfileHive>('ProfileBox');
  ProfileHive myProfile =
      ProfileHive(handle: 'NA', rating: 0, rank: 'noob', titlePhoto: "NA");

  @override
  void initState() {
    try {
      myProfile = profileBox.getAt(0);
      setState(() {});
    } catch (e) {
      myProfile = myProfile;
    }
    try {
      _getMyRatingHistory();
    } catch (e) {
      myRatings = myRatings;
    }
    ratingList = myRatings.ratings;
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  void _callBack() {
    try {
      myProfile = profileBox.getAt(0);
    } catch (e) {
      myProfile = myProfile;
    }
    try {
      _getMyRatingHistory();
    } catch (e) {
      myRatings = myRatings;
    }
    ratingList = myRatings.ratings;
    setState(() {});
  }

  _getMyRatingHistory() async {
    myRatings = await getMyRatingHistory(myProfile.handle);
    setState(() {});
    ratingList = myRatings.ratings;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CF Buddy',
      theme: FlexColorScheme.light(scheme: FlexScheme.deepBlue).toTheme,
      darkTheme: FlexColorScheme.dark(scheme: FlexScheme.deepBlue).toTheme,
      themeMode: currentTheme.currentTheme(),
      home: HomeScreen(
        myProfile: myProfile,
        profileBox: profileBox,
        ratingList: ratingList,
        myRatings: myRatings,
        callBack: _callBack,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
