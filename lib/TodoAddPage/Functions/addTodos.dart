import 'package:Todo_App/Database/todo.dart';
import 'package:Todo_App/Helper%20Widgets/Toast/toast.dart';
import 'package:Todo_App/Notification/alarm_manager.dart';
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

  String formatDate(
      DateTime date, String hour, String minute, bool isBeforeNoon) {
    final now = DateTime.now();

    if (!isBeforeNoon) {
      if (now.day < date.day ||
          now.hour <= int.parse(hour) + 12 && now.minute <= int.parse(minute)) {
        // checks if the time is before Noon ie AM
        if (hour != "12")
          hour = (12 + int.parse(hour)).toString();
        else if (hour == "12") // if it AM then change 12 to 00
          hour = "00";
        String month = date.month.toString();
        if (month.length == 1) month = "0" + month;
        String day = date.day.toString();
        if (day.length == 1) day = "0" + day;
        String dateString = "${date.year}-$month-$day $hour:$minute";
        return dateString;
      }
      showError();
    } else if (now.day < date.day ||
        now.hour <= int.parse(hour) && now.minute <= int.parse(minute)) {
    } else
      showError();
    return null;
  }

  void showError() {
    const String errorMsg = "Time should greater than current time";
    Toast toast = Toast(errorMsg);
    toast.showToast(context);
  }

  _alarmCallback() {
    print("[*] Called from AlarmManager");
    NotificationManager n = new NotificationManager();
    n.initNotificationManager();
    n.showNotificationWithDefaultSound("Title", "This is the body");

    return;
  }

  void add(TodosCompanion todo) {
    String message = validateTitleText(todo.title.value);
    if (message == null) {
      db.insertTodos(todo);
      // _alarmCallback();
      // AndroidAlarmManager.oneShotAt(
      //         DateTime.now().add(Duration(seconds: 5)), 0, _alarmCallback,
      //         exact: true,
      //         allowWhileIdle: true,
      //         wakeup: true,
      //         rescheduleOnReboot: true,
      //         alarmClock: true);

      Toast toast = Toast("Todo Added ");
      toast.showToast(context);
      PageRouter.sailor.navigate(PageRouter.homePage);
    } else {
      Toast toast = Toast("$message");
      toast.showToast(context);
    }
  }
}
