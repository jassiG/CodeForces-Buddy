import 'dart:convert';
import 'package:http/http.dart' as http;

class RatingHistory {
  String status;
  List<int> ratings;
  RatingHistory({required this.status, required this.ratings});
  //Method to convert the Json data to a RatingHistory object
  factory RatingHistory.fromJson(Map<String, dynamic> json) {
    List<int> tempList = [];
    for (var i in json['result']) {
      tempList.add(i['newRating']);
    }
    return RatingHistory(
      status: json['status'],
      ratings: tempList,
    );
  }
}

Future<RatingHistory> getMyRatingHistory(String userhandle) async {
  var url =
      Uri.parse('https://codeforces.com/api/user.rating?handle=' + userhandle);
  var response = await http.get(url);
  return parseMyRatingHistory(response.body);
}

RatingHistory parseMyRatingHistory(String responseBody) {
  final parsed = jsonDecode(responseBody);
  //print(MyResponse.fromJson(parsed));
  return RatingHistory.fromJson(parsed);
}
