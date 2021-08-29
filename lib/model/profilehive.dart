import 'package:cfbuddy/utilities/response.dart';
import 'package:hive/hive.dart';
part 'profilehive.g.dart';

@HiveType(typeId: 0)
class ProfileHive extends HiveObject {
  @HiveField(0)
  String handle;

  @HiveField(1)
  int rating;

  ProfileHive({required this.handle, required this.rating});
}
