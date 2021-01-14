import 'package:Todo_App/Database/todo.dart';
import 'package:Todo_App/Helper%20Widgets/Toast/toast.dart';
import 'package:Todo_App/Router/page_router.dart';
import 'package:flutter/cupertino.dart';

class AddTodos {
  dynamic db;
  BuildContext context;
  AddTodos(context);
  String validateTitleText(String text) {
    if (text.isEmpty)
      return "Title should not be empty";
    else
      return null;
  }

  String formatDate(
      DateTime date, String hour, String minute, bool isBeforeNoon) {
    final currentHour = DateTime.now().hour;

    if (!isBeforeNoon) {
      if (currentHour <= int.parse(hour)) {
        // checks if the time is before Noon ie AM
        if (hour != "12") {
          hour = (12 + int.parse(hour)).toString();
        }
      } else if (hour == "12") // if it AM then change 12 to 00
        hour = "00";
      String month = date.month.toString();
      if (month.length == 1) month = "0" + month;
      String day = date.day.toString();
      if (day.length == 1) day = "0" + day;
      String dateString = "${date.year}-$month-$day $hour:$minute";
      return dateString;
    }
    final errorMsg = "Time should greater than current time";
    Toast toast = Toast(errorMsg);
    toast.showToast(context);
    return null;
  }

  void add(TodosCompanion todo) {
    String message = validateTitleText(todo.title.value);
    if (message == null) {
      db.insertTodos(todo);
      Toast toast = Toast("Todo Added ");
      toast.showToast(context);
      PageRouter.sailor.navigate(PageRouter.homePage);
    } else {
      Toast toast = Toast("$message");
      toast.showToast(context);
    }
  }
}
