import 'package:cfbuddy/profile.dart';
import 'package:hive/hive.dart';
part 'profilehive.g.dart';

@HiveType(typeId: 0)
class ProfileHive extends HiveObject {
  @HiveField(0)
  String handle;

  @HiveField(1)
  int rating;

  @HiveField(2)
  String rank;

  @HiveField(3)
  String titlePhoto;

  ProfileHive(
      {required this.handle,
      required this.rating,
      required this.rank,
      required this.titlePhoto});
  @override
  toString() {
    return "handle: " +
        handle +
        "\n" +
        "rank: " +
        rank +
        "\n" +
        "rating: " +
        rating.toString() +
        "\n";
  }
}

void updateProfile(Box currentBox, ProfileHive nextProfile) {
  currentBox.clear();
  currentBox.add(nextProfile);
  return;
}

Box updateProfileFromHandle(Box currentBox, String newHandle, int newRating,
    String newRank, String newTitlePhoto) {
  if (currentBox.isNotEmpty) {
    currentBox.deleteAt(0);
  }
  currentBox.add(ProfileHive(
      handle: newHandle,
      rating: newRating,
      rank: newRank,
      titlePhoto: newTitlePhoto));
  return currentBox;
}
