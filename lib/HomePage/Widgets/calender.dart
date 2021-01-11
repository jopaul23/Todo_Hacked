import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';

class Calender extends StatelessWidget {
  final DateTime date;

  const Calender(this.date);

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
        color: Styles.white2,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.none);
    const List<String> weekDays = [
      "mon",
      "tue",
      "wed",
      "thu",
      "fri",
      "sat",
      "sun"
    ];
    final days = generateDays();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 30.0, bottom: 20.0),
            child: Text(getMonth(), style: style.copyWith(fontSize: 25))),
        Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(weekDays.length, (int index) {
                  return Text(
                    "${weekDays[index]}",
                    style: TextStyle(
                        color: Styles.white1.withOpacity(0.7),
                        fontSize: 14,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal),
                  );
                })),
            const SizedBox(height: 20.0),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(days.length, (int index) {
                  return Container(
                    height: 25,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: days[index] == "${date.day}"
                            ? Styles.white1
                            : Colors.transparent),
                    child: Text(
                      "${days[index]}",
                      style: TextStyle(
                          color: days[index] == "${date.day}"
                              ? Styles.t1Orange
                              : Styles.white1.withOpacity(0.7),
                          fontSize: 16,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal),
                    ),
                  );
                })),
          ],
        )
      ],
    );
  }

  List<String> generateDays() {
    int weekday = date.weekday;
    int day = date.day;
    int start = (day - weekday).abs(), end = start + 7;
    List<String> days = [];
    for (int i = start; i < end; i++) days.add("${i + 1}");
    return days;
  }

  String getMonth() {
    String month;
    switch (date.month) {
      case 1:
        month = "January";
        break;
      case 2:
        month = "February";
        break;
      case 3:
        month = "March";
        break;
      case 4:
        month = "April";
        break;
      case 5:
        month = "May";
        break;
      case 6:
        month = "June";
        break;
      case 7:
        month = "July";
        break;
      case 8:
        month = "August";
        break;
      case 9:
        month = "September";
        break;
      case 10:
        month = "October";
        break;
      case 11:
        month = "November";
        break;
      case 12:
        month = "December";
        break;
    }
    return month;
  }
}
