import 'package:Todo_App/AccountPage/Functions/user_details.dart';
import 'package:Todo_App/Database/provider.dart';
import 'package:hooks_riverpod/all.dart';

class TodoChart {
  int pendingTask = 0, completedTask = 0;
  var _db;
  TodoChart() {
    // db = providerContainer.read(databaseProvider);
  }
  Future init() async {
    _db = UserTodoDetails.database;
    pendingTask = (await _db.getCompletedTask()).length;
    completedTask = (await _db.getPendingTask()).length;
  }

  static createBox(String username) {
    UserTodoDetails userTodoDetails = UserTodoDetails()
      ..userName = username
      ..userLoggedDate = DateTime.now();
    UserTodoDetails.hiveBox.put(0, userTodoDetails);
  }

  void updateChart(List newData) {
    final UserTodoDetails details = UserTodoDetails.hiveBox.getAt(0);
    details.chartData = newData;
    details.lastModifedDate = DateTime.now();
    details.save();
  }

  UserTodoDetails getChartData() => UserTodoDetails.hiveBox.getAt(0);
}
