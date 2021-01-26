import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart' as moor;

import '../../Database/todo.dart';
import '../../Notification/alarm_callback.dart';
import '../../Router/page_router.dart';
import '../../Overlays/Toast/toast_overlay.dart';

class AddTodos {
  var db; //database Reference
  IconData tagIcon = Icons.person;
  DateTime dueDate = DateTime.now();
  String title, reminder;
  final Function() updateWidget;
  AddTodos(this.updateWidget);

  String formatReminder() {
    List<dynamic> split = reminder.split(":");
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

  void updateDueDate(BuildContext context, DateTime date,
      {String hour, String minute}) {
    String _addZeros(String text) {
      if (text.length == 1) return "0" + text;
      return text;
    }

    final month = _addZeros(date.month.toString());
    final day = _addZeros(date.day.toString());
    hour = hour ?? _addZeros(date.hour.toString());
    minute = minute ?? _addZeros(date.minute.toString());

    final String dateString = "${date.year}-$month-$day $hour:$minute:00";
    debugPrint("date before");
    debugPrint(dateString.toString());
    dueDate = DateTime.parse(dateString);
    debugPrint("date conversion");
    debugPrint(dueDate.toString());
    updateWidget(); // rebuilds Widgets
  }

  _addData() => TodosCompanion(
      tagIconId: moor.Value(tagIcon.codePoint),
      title: moor.Value(title),
      remainderTime: moor.Value(DateTime.now().add(Duration(
          hours: int.parse(reminder.substring(0, 2)),
          minutes: int.parse(reminder.substring(3))))),
      dueDate: moor.Value(dueDate),
      notificationOn: moor.Value(false));

  void add(BuildContext context, bool overlayWindowClosed) async {
    String errorMsg = "";
    print(title);
    if (!overlayWindowClosed)
      errorMsg = "Close the current window";
    else if (title == null || title.isEmpty) {
      errorMsg = "Title should not be empty";
    } else if (reminder == null) errorMsg = "Set a reminder";
    if (dueDate.isBefore(DateTime.now()))
      errorMsg = "Oops! DueDate cannot be past";

    if (errorMsg.isEmpty) {
      final todo = _addData();
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
      Toast toast = Toast("$errorMsg");
      toast.showToast(context);
    }
  }
}
