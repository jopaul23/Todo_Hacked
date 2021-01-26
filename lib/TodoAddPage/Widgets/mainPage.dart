import 'package:Todo_App/Database/provider.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../../Styles/styles.dart';
import '../Functions/addTodos.dart';
import 'appBar.dart';
import 'input_button.dart';
import '../../Overlays/clock_overlay.dart';
import '../../Overlays/reminder_clock_overlay.dart';
import '../../Overlays/calender_overlay.dart';
import '../../Helper Widgets/Clock/clock_digital_display.dart';

class TodoAddPage extends StatefulWidget {
  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {
  TextEditingController _controller;
  AddTodos addTodos;
  bool tagOverlay = false;
  OverlayEntry clockOverlay, reminderOverlay, calenderOverlay;
  @override
  void initState() {
    _controller = TextEditingController();
    addTodos = AddTodos(() {
      this.setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void closeAllOverlay() {
    if (clockOverlay != null) clockOverlay.remove();
    if (calenderOverlay != null) calenderOverlay.remove();
    if (reminderOverlay != null) reminderOverlay.remove();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer(builder: (context, watch, _) {
      final db = watch(databaseProvider);
      if (addTodos.db == null) addTodos.db = db;

      return WillPopScope(
        onWillPop: () {
          closeAllOverlay();
          return Future.value(true);
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Styles.cream,
            body: Stack(
              children: [
                TodoAddPageAppBar(
                  onBackButtonPressed: closeAllOverlay,
                  onSelected: (IconData icon) {
                    addTodos.tagIcon = icon;
                  },
                ),
                Padding(
                    padding: EdgeInsets.only(top: size.height * 0.098),
                    child:
                        ListView(padding: EdgeInsets.zero, children: <Widget>[
                      SizedBox(
                        height: size.height * 0.05,
                      ),

                      // TextField
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.1),
                        height: size.height * 0.06,
                        child: TextField(
                          autofocus: true,
                          controller: _controller,
                          cursorHeight: 40,
                          onChanged: (String val) {
                            if (val.length > 15) {
                              _controller.text =
                                  _controller.text.substring(0, 15);

                              _controller.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset: _controller.text.length));
                            }
                          },
                          style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                            hintText: "Add your text",
                          ),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                            color: Styles.white3,
                            boxShadow: [
                              Styles.shadow(),
                            ],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                            )),
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.08,
                            ),

                            // calender Overlay
                            InputButton(
                              text: DateFormat("d MMM y")
                                  .format(addTodos.dueDate),
                              icon: Icons.calendar_today_rounded,
                              width: 300,
                              buttoncolor: Styles.white3,
                              onPressed: () {
                                calenderOverlay =
                                    createCalenderOverlay(onSelected: (date) {
                                  calenderOverlay.remove();
                                  calenderOverlay = null;
                                  addTodos.updateDueDate(context, date);
                                });
                                Overlay.of(context).insert(calenderOverlay);
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.03,
                            ),

                            // Clock Overlay
                            InputButton(
                              text:
                                  DateFormat('kk:mm').format(addTodos.dueDate),
                              icon: Icons.access_time,
                              width: 300,
                              buttoncolor: Styles.white3,
                              onPressed: () {
                                clockOverlay = createClockOverlay(
                                    date: addTodos.dueDate,
                                    onSelected: (String hour, String minute) {
                                      clockOverlay.remove();
                                      clockOverlay = null;
                                      addTodos.updateDueDate(
                                          context, addTodos.dueDate,
                                          hour: hour, minute: minute);
                                    });
                                Overlay.of(context).insert(clockOverlay);
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.03,
                            ),

                            // Reminder Overlay
                            InputButton(
                              text: addTodos.reminder != null
                                  ? addTodos.formatReminder()
                                  : "Set Reminder",
                              icon: Icons.notifications,
                              buttoncolor: Styles.white3,
                              width: 300,
                              onPressed: () {
                                reminderOverlay = createReminderOverlay(
                                    hour: addTodos.reminder == null
                                        ? "00"
                                        : addTodos.reminder.split(":")[0],
                                    minute: addTodos.reminder == null
                                        ? "00"
                                        : addTodos.reminder.split(":")[1],
                                    clock: DigitalClock.remainder,
                                    onSelected: (Duration duration) {
                                      reminderOverlay.remove();
                                      reminderOverlay = null;
                                      final String hour =
                                          duration.inHours.toString().length ==
                                                  1
                                              ? "0${duration.inHours}"
                                              : duration.inHours.toString();
                                      final minute = duration.inMinutes;
                                      setState(() {
                                        addTodos.reminder =
                                            "$hour:${minute - int.parse(hour) * 60}";
                                        print(addTodos.reminder);
                                      });
                                    });
                                Overlay.of(context).insert(reminderOverlay);
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),

                            // Add task button
                            InputButton(
                                text: "Add task",
                                buttoncolor: Styles.t1Orange,
                                textcolor: Styles.white3,
                                width: 200,
                                onPressed: () {
                                  addTodos.title = _controller.text;
                                  print(addTodos.title);
                                  addTodos.add(
                                      context,
                                      clockOverlay == null &&
                                          reminderOverlay == null &&
                                          calenderOverlay == null);
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
}
