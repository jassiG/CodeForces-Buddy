import 'dart:math';

class Response {
  String status;
  List<User> users;
  Response({this.status = "NA", required this.users});
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
  });
}

Response generateDummyResponse(int length) {
  return Response(
    users: [
      for (int i = 0; i < length; i++)
        User(
            rating: Random(DateTime.now().millisecondsSinceEpoch + i)
                .nextInt(3500)),
    ],
  );
}

Response addDummyUser(Response response) {
  response.users.add(User(
      rating: Random(DateTime.now().millisecondsSinceEpoch).nextInt(3500)));
  return response;
}
