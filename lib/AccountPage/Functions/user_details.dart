import 'package:hive/hive.dart';

part 'user_details.g.dart';

@HiveType()
class UserTodoDetails extends HiveObject {
  @HiveField(0)
  String userName;
  @HiveField(1)
  DateTime userLoggedDate;
  @HiveField(2)
  DateTime lastModifedDate;
  @HiveField(3)
  List chartData = [
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0]
  ];
  static Box hiveBox;
  static var database;
}
