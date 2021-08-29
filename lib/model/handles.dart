import 'package:hive/hive.dart';
part 'handles.g.dart';

@HiveType(typeId: 1)
class Handles extends HiveObject {
  @HiveField(0)
  Map<String, int> users;

  Handles({required this.users});
}
