import 'package:Todo_App/Database/todo.dart';
import 'package:Todo_App/HomePage/Widgets/todo_card.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class HomePageTodoFunction {
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

  static String getWeekDay(DateTime dateToCompare, DateTime dateTocheck) {
    print(dateToCompare);
    print(dateTocheck);
    final today = DateTime.now();
    if (dateToCompare == null) if (today.day == dateTocheck.day) return "today";
    if (dateTocheck.day == dateToCompare.day)
      return null;
    else if (dateTocheck.day == dateToCompare.day + 1)
      return "Tommarrow";
    else {
      final format = DateFormat("d-M-y").format(dateTocheck);
      return "on " + format;
    }
  }
}
