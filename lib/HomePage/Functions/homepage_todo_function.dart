import 'package:Todo_App/Database/todo.dart';
import 'package:Todo_App/HomePage/Widgets/todo_card.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class HomePageTodoFunction {
  static List<String> availableDates = [];
  static String formatDueTime(DateTime date) {
    return DateFormat("EEE,kk:mm").format(date);
  }

  static TodoCards makeCard(Todo todo) {
    return TodoCards(
      dateTime: formatDueTime(todo.dueDate),
      title: todo.title,
      tagColor: Color(int.parse("0xFF" + todo.tagColor.replaceFirst("#", ""))),
      tagName: todo.tagName,
    );
  }

  static String getWeekDay(DateTime dateTocheck) {
    print(dateTocheck);
    print("Avialbe dates $availableDates");
    final today = DateTime.now();

    if (today.day == dateTocheck.day)
      return "today";
    else if (dateTocheck.day == today.day + 1)
      return "Tommarrow";
    else {
      final format = DateFormat("d-M-y").format(dateTocheck);
      return "on " + format;
    }
  }

  static search(String val) {}
}
