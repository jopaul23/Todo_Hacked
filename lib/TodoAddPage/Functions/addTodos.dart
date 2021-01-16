import 'package:Todo_App/Database/todo.dart';
import 'package:Todo_App/Helper%20Widgets/Toast/toast.dart';
import 'package:Todo_App/Notification/alarm_callback.dart';
import 'package:Todo_App/Router/page_router.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/cupertino.dart';

class AddTodos {
  dynamic db;
  BuildContext context;
  AddTodos(context);
  String validateTitleText(String text) {
    if (text.isEmpty)
      return "Title should not be empty";
    else if (text.length > 15) return "Title character exceeds";
    return null;
  }

  String formatReminder(String time) {
    List<dynamic> split = time.split(":");
    List intTime = [];

    intTime.add(int.parse(split[0]));
    intTime.add(int.parse(split[1]));
    print(intTime);
    if (intTime[0] == 0)
      return "${intTime[1]} mins before";
    else if (intTime[1] == 0)
      return "${intTime[0]} hours before";
    else
      return "${intTime[0]} hours & ${intTime[1]} min before";
  }

  bool formatDate(DateTime date, String hour, String minute) {
    final now = DateTime.now();

    if (now.day > date.day ||
        now.hour >= int.parse(hour) && now.minute >= int.parse(minute)) {
      const String errorMsg = "Time should greater than current time";
      Toast toast = Toast(errorMsg);
      toast.showToast(context);
      return false;
    } else {
      return true;
    }
  }

  void add(TodosCompanion todo) async {
    String message = validateTitleText(todo.title.value);
    if (message == null) {
      await db.insertTodos(todo);
      final result = await db.getTodo(todo);
      int id = result[result.length - 1].id;
      AndroidAlarmManager.oneShotAt(
          todo.remainderTime.value, id, AlarmCallback.alarmCallback,
          exact: true,
          allowWhileIdle: true,
          wakeup: true,
          rescheduleOnReboot: true,
          alarmClock: true);

      Toast toast = Toast("Todo Added ");
      toast.showToast(context);
      PageRouter.sailor.navigate(PageRouter.homePage);
    } else {
      Toast toast = Toast("$message");
      toast.showToast(context);
    }
  }
}
