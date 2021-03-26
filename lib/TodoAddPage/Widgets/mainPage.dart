import 'package:Todo_App/Database/Todo_model.dart';
import 'package:Todo_App/Database/provider.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';

import '../Functions/addTodos.dart';
import 'add_title.dart';
import 'input_button.dart';
import '../../Overlays/clock_overlay.dart';
import '../../Overlays/reminder_clock_overlay.dart';
import '../../Overlays/calender_overlay.dart';
import '../../Helper Widgets/Clock/Display Time/clock_digital_display.dart';

class TodoAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final args;
    // Sailor.args<TodoModel>(context);
    return TodoAdd();
  }
}

class TodoAdd extends StatefulWidget {
  final TodoModel todos;

  const TodoAdd({Key key, this.todos}) : super(key: key);
  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAdd> {
  TextEditingController _controller;
  AddTodos addTodos;
  bool isUpdateTodo = false;
  OverlayEntry clockOverlay, reminderOverlay, calenderOverlay;
  @override
  void initState() {
    if (widget.todos == null) {
      addTodos = AddTodos();
    } else {
      addTodos = AddTodos(todo: widget.todos);
      isUpdateTodo = true;
    }
    _controller = TextEditingController(text: addTodos.title ?? "");
    debugPrint(addTodos.reminder.split(":").toString());
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
      return WillPopScope(
        onWillPop: () {
          closeAllOverlay();
          return Future.value(true);
        },
        child: SafeArea(
          child: Scaffold(
            // backgroundColor: Styles.cream,
            body: Stack(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: size.height * 0.098),
                    child:
                        ListView(padding: EdgeInsets.zero, children: <Widget>[
                      SizedBox(
                        height: size.height * 0.05,
                      ),

                      // TextField
                      AddTitle(controller: _controller),
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
                            //     color: Styles.white3,
                            boxShadow: [
                              //        Styles.shadow(),
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
                              //   buttoncolor: Styles.white3,
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
                              //  buttoncolor: Styles.white3,
                              onPressed: () {
                                clockOverlay = createClockOverlay(
                                    date: addTodos.dueDate,
                                    onSelected: (String hour, String minute) {
                                      clockOverlay.remove();
                                      clockOverlay = null;
                                      this.setState(() {
                                        addTodos.updateDueDate(
                                            context, addTodos.dueDate,
                                            hour: hour, minute: minute);
                                      });
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
                                  ? "Remind me on " + addTodos.reminder
                                  : "Set Reminder",
                              icon: Icons.notifications,
                              //  buttoncolor: Styles.white3,
                              width: 300,
                              onPressed: () {
                                reminderOverlay = createReminderOverlay(
                                    hour: int.parse(
                                        addTodos.reminder.split(":")[0]),
                                    minute: int.parse(
                                        addTodos.reminder.split(":")[1]),
                                    clock: DigitalClock.remainder,
                                    onSelected: (String hour, String minute) {
                                      reminderOverlay.remove();
                                      reminderOverlay = null;

                                      setState(() {
                                        addTodos.reminder = "$hour:$minute";
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
                                text: isUpdateTodo ? "Update Task" : "Add task",
                                //   buttoncolor: Styles.t1Orange,
                                // textcolor: Styles.white3,
                                width: 200,
                                onPressed: () {
                                  addTodos.title = _controller.text;

                                  addTodos.add(
                                      context,
                                      isUpdateTodo,
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
