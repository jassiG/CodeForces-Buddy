import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class MyResponse {
  String status;
  List<User> users;
  MyResponse({this.status = "NA", required this.users});

  factory MyResponse.fromJson(Map<String, dynamic> json) {
    List<User> tempList = [];
    for (var i in json['result']) {
      tempList.add(User.fromJson(i));
    }
    return MyResponse(
      status: json['status'],
      users: tempList,
    );
  }
}

class User {
  String lastName;
  int lastOnlineTimeSeconds;
  int rating;
  int friendOfCount;
  String titlePhoto;
  String handle;
  String avatar;
  String firstName;
  int contribution;
  String organization;
  String rank;
  int maxRating;
  int registrationTimeSeconds;
  String maxRank;
  String email;
  String vkId;
  String openId;
  String country;
  String city;

  User({
    this.lastName = "NA",
    this.avatar = "NA",
    this.contribution = 0,
    this.firstName = "NA",
    this.friendOfCount = 0,
    this.handle = "NA",
    this.lastOnlineTimeSeconds = 0,
    this.maxRank = "nubie",
    this.maxRating = 0,
    this.organization = "NA",
    this.rank = "NA",
    this.rating = 0,
    this.registrationTimeSeconds = 0,
    this.titlePhoto = "noimage",
    this.email = "NA",
    this.city = "NA",
    this.country = "NA",
    this.openId = "NA",
    this.vkId = "NA",
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      lastName: json['lastName'] == null ? "" : json['lastName'] as String,
      lastOnlineTimeSeconds: json['lastOnlineTimeSeconds'] == null
          ? -1
          : json['lastOnlineTimeSeconds'] as int,
      rating: json['rating'] == null ? -1 : json['rating'] as int,
      friendOfCount:
          json['friendOfCount'] == null ? -1 : json['friendOfCount'] as int,
      titlePhoto:
          json['titlePhoto'] == null ? "" : json['titlePhoto'] as String,
      handle: json['handle'] == null ? "" : json['handle'] as String,
      avatar: json['avatar'] == null ? "" : json['avatar'] as String,
      firstName: json['firstName'] == null ? "" : json['firstName'] as String,
      contribution:
          json['contribution'] == null ? -1 : json['contribution'] as int,
      organization:
          json['organization'] == null ? "" : json['organization'] as String,
      rank: json['rank'] == null ? "" : json['rank'] as String,
      maxRating: json['maxRating'] == null ? -1 : json['maxRating'] as int,
      registrationTimeSeconds: json['registrationTimeSeconds'] == null
          ? 0
          : json['registrationTimeSeconds'] as int,
      maxRank: json['maxRank'] == null ? "" : json['maxRank'] as String,
      email: json['email'] == null ? "" : json['email'] as String,
      vkId: json['vkId'] == null ? "" : json['vkId'] as String,
      openId: json['openId'] == null ? "" : json['openId'] as String,
      country: json['country'] == null ? "" : json['country'] as String,
      city: json['city'] == null ? "" : json['city'] as String,
    );
  }
}

MyResponse generateDummyResponse(int length) {
  return MyResponse(
    users: [
      for (int i = 0; i < length; i++)
        User(
            rating: Random(DateTime.now().millisecondsSinceEpoch + i)
                .nextInt(3500)),
    ],
  );
}

MyResponse addDummyUser(MyResponse MyResponse) {
  MyResponse.users.add(User(
      rating: Random(DateTime.now().millisecondsSinceEpoch).nextInt(3500)));
  return MyResponse;
}

Future<MyResponse> getMyResponse(String userhandle) async {
  var url =
      Uri.parse('https://codeforces.com/api/user.info?handles=' + userhandle);
  var response = await http.get(url);
  return parseMyResponse(response.body);
  //print(c);
}

MyResponse parseMyResponse(String responseBody) {
  final parsed = jsonDecode(responseBody);
  //print(MyResponse.fromJson(parsed));
  return MyResponse.fromJson(parsed);
}
