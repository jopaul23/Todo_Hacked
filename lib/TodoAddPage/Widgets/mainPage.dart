import 'package:Todo_App/Database/provider.dart';
import 'package:Todo_App/Database/todo.dart';
import 'package:Todo_App/Helper%20Widgets/Clock/Providers/time_provider.dart';
import 'package:Todo_App/Helper%20Widgets/Clock/clock_digital_display.dart';
import 'package:Todo_App/Helper%20Widgets/Dropdown/dropdown.dart';
import 'package:Todo_App/Helper%20Widgets/Toast/toast.dart';
import 'package:Todo_App/Helper%20Widgets/calender.dart';
import 'package:Todo_App/Helper%20Widgets/inputfield.dart';
import 'package:Todo_App/Router/page_router.dart';
import 'package:Todo_App/Router/provider.dart';
import 'package:Todo_App/TodoAddPage/Functions/addTodos.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:Todo_App/Helper%20Widgets/Clock/clock_body.dart';
import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart' as moor;

class TodoAddPage extends StatefulWidget {
  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {
  OverlayEntry clock, reminder;
  DateTime date;
  OverlayEntry calenderOverlay;
  String reminderTime;
  TextEditingController _controller;
  final tagIcons = [
    Icons.work_rounded,
    Icons.local_taxi,
    Icons.home_rounded,
    Icons.fitness_center
  ];
  AddTodos addTodos;
  bool tagOverlay = false;
  IconData tagIcon = Icons.person;
  @override
  void initState() {
    _controller = TextEditingController();
    addTodos = AddTodos(context);
    DateTime now = DateTime.now();
    date = now;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer(builder: (context, watch, _) {
      final db = watch(databaseProvider);
      final pageStack = watch(pageStackProvider);
      return WillPopScope(
        onWillPop: () {
          pageStack.popWid();
          return Future.value(true);
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Styles.cream,
            body: Stack(
              children: [
                Container(
                  height: size.height * 0.098,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Styles.grey4.withOpacity(0.02),
                          spreadRadius: 10,
                          blurRadius: 7,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      gradient: Styles.t1Gradient,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Styles.t1Orange.withOpacity(0.7),
                            size: 40,
                          ),
                          onPressed: () {
                            if (clock == null &&
                                reminder == null &&
                                !tagOverlay &&
                                calenderOverlay == null) {
                              pageStack.popWid();
                              ;
                              Navigator.pop(context);
                            }
                          }),
                      SimpleAccountMenu(
                        borderRadius: BorderRadius.circular(5),
                        icons: tagIcons,
                        iconColor: Colors.white,
                        overLayChanged: (bool val) {
                          tagOverlay = val;
                        },
                        onChange: (index) {
                          tagIcon = tagIcons[index];
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: size.height * 0.098),
                    child:
                        ListView(padding: EdgeInsets.zero, children: <Widget>[
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.1),
                        height: size.height * 0.06,
                        child: TextField(
                          autofocus: true,
                          controller: _controller,
                          cursorHeight: 40,
                          cursorColor: Styles.grey1,
                          onChanged: (String val) {
                            if (val.length > 15) {
                              _controller.text =
                                  _controller.text.substring(0, 15);
                              _controller.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset: _controller.text.length));
                            }
                          },
                          style: TextStyle(
                            fontSize: 30,
                            color: Styles.grey2,
                          ),
                          decoration: InputDecoration(
                              hintText: "Add your text",
                              hintStyle: TextStyle(
                                color: Styles.grey1.withOpacity(0.8),
                                fontWeight: FontWeight.w400,
                                fontSize: 30,
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Container(
                        height: size.height -
                            size.height * 0.1 -
                            size.height * 0.098 -
                            size.height * 0.06,
                        decoration: BoxDecoration(
                          color: Styles.white3,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                              color: Styles.grey4.withOpacity(0.03),
                              spreadRadius: 10,
                              blurRadius: 9,
                              offset:
                                  Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.08,
                            ),
                            InputButton(
                              text: DateFormat('kk:mm').format(date),
                              buttoncolor: Styles.white3,
                              textcolor: Styles.grey2,
                              icon: Icons.access_time,
                              width: 300,
                              onPressed: () {
                                clock = _createClockOverlay();
                                Overlay.of(context).insert(clock);
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            InputButton(
                              text: DateFormat("d MMM y").format(date),
                              buttoncolor: Styles.white3,
                              textcolor: Styles.grey2,
                              icon: Icons.calendar_today_rounded,
                              width: 300,
                              onPressed: displayCalender,
                            ),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            InputButton(
                              text: reminderTime != null
                                  ? addTodos.formatReminder(reminderTime)
                                  : "Set Reminder",
                              buttoncolor: Styles.white3,
                              textcolor: Styles.grey2,
                              icon: Icons.notifications,
                              width: 300,
                              onPressed: () {
                                reminder = _createReminderOverlay();
                                Overlay.of(context).insert(reminder);
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            InputButton(
                                text: "Add task",
                                buttoncolor: Styles.t1Orange,
                                textcolor: Styles.white3,
                                width: 200,
                                onPressed: () {
                                  if (clock == null &&
                                      reminder == null &&
                                      calenderOverlay == null) {
                                    if (reminderTime != null) {
                                      final remind = DateTime.now().add(
                                          Duration(
                                              hours: int.parse(
                                                  reminderTime.substring(0, 2)),
                                              minutes: int.parse(
                                                  reminderTime.substring(3))));
                                      final todo = TodosCompanion(
                                          tagIconId:
                                              moor.Value(tagIcon.codePoint),
                                          title: moor.Value(_controller.text),
                                          remainderTime: moor.Value(remind),
                                          dueDate: moor.Value(date),
                                          notificationOn: moor.Value(false));
                                      addTodos
                                        ..context = context
                                        ..db = db
                                        ..add(todo);
                                    } else {
                                      Toast("Set a reminder")
                                        ..showToast(context);
                                    }
                                  } else {
                                    Toast("Close the current window")
                                      ..showToast(context);
                                  }
                                })
                          ],
                        ),
                      )
                    ]))
              ],
            ),
          ),
        ),
      );
    });
  }

  OverlayEntry _createClockOverlay() {
    String hour = date.hour.toString();
    String minute = date.minute.toString();

    final bool isBeforeNoon = date.hour < 12;
    TimeProvider timeProvider = TimeProvider()
      ..updateHour(
          isBeforeNoon ? hour : "${int.parse(hour) - 12}", isBeforeNoon)
      ..updateMinute(minute);
    return OverlayEntry(builder: (context) {
      return Align(
        alignment: Alignment.center,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30.0),
          decoration: BoxDecoration(
            color: Styles.white1,
            borderRadius: const BorderRadius.all(Radius.circular(35.0)),
            boxShadow: [
              BoxShadow(
                color: Styles.grey4.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 7,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: ClockBody(
            digitalClock: DigitalClock.normal,
            timeContainer: timeProvider,
            beforeNoon: isBeforeNoon,
            onClicked: (String hour, String minute) {
              addTodos.context = context;
              if (addTodos.formatDate(date, hour, minute)) {
                String month = date.month.toString();
                String day = date.day.toString();
                if (month.length == 1) month = "0" + month;
                if (day.length == 1) day = "0" + day;

                String dateString = "${date.year}-$month-$day $hour:$minute:00";
                // if (dateString != null)
                setState(() {
                  date = DateTime.parse(dateString);
                });
                clock.remove();
                clock = null;
              }
            },
          ),
        ),
      );
    });
  }

  void displayCalender() async {
    calenderOverlay = OverlayEntry(builder: (context) {
      final Size size = MediaQuery.of(context).size;
      return Positioned(
        top: size.height * 0.5 - 200,
        // left: size.width * 0.5 - 200,
        left: 10,
        child: Center(
          child: HomeCalendarPage(
            onSelected: (picked) {
              calenderOverlay.remove();

              String month = picked.month.toString();
              if (month.length == 1) month = "0" + month;
              String day = picked.day.toString();
              if (day.length == 1) day = "0" + day;
              String hour = date.hour.toString();
              String minute = date.minute.toString();
              if (hour.length == 1) hour = "0" + hour;
              if (minute.length == 1) minute = "0" + minute;
              String dateString = "${picked.year}-$month-$day $hour:$minute";
              setState(() {
                date = DateTime.parse(dateString);
              });
              calenderOverlay = null;
            },
          ),
        ),
      );
    });
    Overlay.of(context).insert(calenderOverlay);
  }

  OverlayEntry _createReminderOverlay() {
    TimeProvider timeProvider = TimeProvider()
      ..time = reminderTime == null ? "00:00" : reminderTime;

    return OverlayEntry(builder: (context) {
      return Align(
        alignment: Alignment.center,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30.0),
          decoration: BoxDecoration(
            color: Styles.white1,
            borderRadius: const BorderRadius.all(Radius.circular(35.0)),
            boxShadow: [
              BoxShadow(
                color: Styles.grey4.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 7,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: ClockBody(
            timeContainer: timeProvider,
            digitalClock: DigitalClock.remainder,
            beforeNoon: true,
            onClicked: (String hour, String minute) {
              setState(() {
                reminderTime = "$hour:$minute";
              });

              reminder.remove();
              reminder = null;
            },
          ),
        ),
      );
    });
  }
}
