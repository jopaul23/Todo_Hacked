import 'package:Todo_App/AccountPage/Functions/chart.dart';

class Graph {
  int n;
  int maxValue = 0;
  int yMultiple;
  int usingDays;

  List graphValues(TodoChart todoChart) {
    final now = DateTime.now();
    final userTodoDetails = todoChart.getChartData();
    bool isModifiedToday = userTodoDetails.lastModifedDate.day == now.day;
    usingDays = now.day - userTodoDetails.lastModifedDate.day + 1;

    if (usingDays < 7) {
      n = DateTime.now().subtract(Duration(days: (usingDays - 1))).day;
      userTodoDetails.chartData[usingDays - 1] = [
        todoChart.completedTask,
        todoChart.pendingTask
      ];
    } else {
      n = DateTime.now().subtract(Duration(days: 6)).day;
      if (!isModifiedToday) {
        for (int i = 1; i < 7; i++) {
          userTodoDetails.chartData[i - 1] = userTodoDetails.chartData[i];
        }
      }
      userTodoDetails.chartData[6] = [
        todoChart.completedTask,
        todoChart.pendingTask
      ];
    }

    //yValues
    for (var i in userTodoDetails.chartData) {
      for (int j in i) {
        if (j > maxValue) {
          maxValue = j;
        }
      }
    }
    maxValue = maxValue;
    yMultiple = maxValue ~/ 4 + 1;

    userTodoDetails.lastModifedDate = now;
    userTodoDetails.save();
    print(todoChart.pendingTask);
    print(userTodoDetails.chartData);
    return userTodoDetails.chartData;
  }
}
