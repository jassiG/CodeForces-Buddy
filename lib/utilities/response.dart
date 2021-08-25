class Response {
  String name = "five";
  List<User> users = [
    User("lmao", "this", 5, "this", 5, "this", 5, "this", 5, "this", "this", 5,
        5, "this")
  ];
}

class User {
  User(
    this.lastName,
    this.avatar,
    this.contribution,
    this.firstName,
    this.friendOfCount,
    this.handle,
    this.lastOnlineTimeSeconds,
    this.maxRank,
    this.maxRating,
    this.organization,
    this.rank,
    this.rating,
    this.registrationTimeSeconds,
    this.titlePhoto,
  );
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
}
