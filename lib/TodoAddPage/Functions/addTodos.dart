import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart' as moor;
import 'package:todo_app/AccountPage/Functions/user_details.dart';
import 'package:todo_app/Database/todo_model.dart';

import '../../Database/todo.dart';
import '../../Notification/alarm_callback.dart';
import '../../Router/page_router.dart';
import '../../Overlays/Toast/toast_overlay.dart';

class AddTodos {
  var db; //database Reference
  IconData tagIcon = Icons.person;
  DateTime dueDate = DateTime.now();
  final TodoModel todo;

  String title, reminder = "00:00";
  AddTodos({this.todo}) {
    db = UserTodoDetails.database;
    if (todo != null) {
      title = todo.title;
      dueDate = todo.dueDate;
      tagIcon = IconData(todo.tagIconId);
      reminder = "${todo.remainderTime.hour}:${todo.remainderTime.minute}";
    }
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
    dueDate = DateTime.parse(dateString);
  }

  _updateData() => TodosCompanion(
      id: moor.Value(todo.id),
      tagIconId: moor.Value(tagIcon.codePoint),
      title: moor.Value(title),
      dueDate: moor.Value(dueDate),
      remainderTime: moor.Value(DateTime.now().add(Duration(
          hours: int.parse(reminder.split(":")[0]),
          minutes: int.parse(reminder.split(":")[1])))),
      notificationOn: moor.Value(todo.notificationOn),
      completed: moor.Value(todo.completed));

  _addData() => TodosCompanion(
      tagIconId: moor.Value(tagIcon.codePoint),
      title: moor.Value(title),
      remainderTime: moor.Value(DateTime.now().add(Duration(
          hours: int.parse(reminder.split(":")[0]),
          minutes: int.parse(reminder.split(":")[1])))),
      dueDate: moor.Value(dueDate),
      notificationOn: moor.Value(false));

  void add(
      BuildContext context, bool shouldUpdate, bool overlayWindowClosed) async {
    String errorMsg = "";
    if (!overlayWindowClosed)
      errorMsg = "Close the current window";
    else if (title == null || title.isEmpty) {
      errorMsg = "Title should not be empty";
    }
    if (dueDate.isBefore(DateTime.now()))
      errorMsg = "Oops! DueDate cannot be past";

    if (errorMsg.isEmpty) {
      var todo;

      if (shouldUpdate) {
        todo = _updateData();
        await db.updateTodos(todo);
      } else {
        todo = _addData();
        await db.insertTodos(todo);
      }
      final result = await db.getTodo(todo);
      int id = result[result.length - 1].id;
      // AndroidAlarmManager.oneShotAt(
      //     todo.remainderTime.value, id, AlarmCallback.alarmCallback,
      //     exact: true,
      //     allowWhileIdle: true,
      //     wakeup: true,
      //     rescheduleOnReboot: true,
      //     alarmClock: true);

      Toast toast = Toast(shouldUpdate ? "Updated Task" : "Todo Added ");
      toast.showToast(context);
      PageRouter.sailor.navigate(PageRouter.homePage);
    } else {
      Toast toast = Toast("$errorMsg");
      toast.showToast(context);
    }
  }
}
