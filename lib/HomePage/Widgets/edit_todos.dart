import 'package:Todo_App/Helper%20Widgets/inputfield.dart';
import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditTodo extends StatelessWidget {
  final Offset offset;
  final double height;

  const EditTodo({Key key, this.offset, this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = Size(0, 200);
    return Positioned(
      top: offset.dy + height - 20,
      left: 20,
      right: 20,
      bottom: 20,
      child: SingleChildScrollView(
        reverse: true,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Icon(Icons.arrow_upward, color: Styles.t1Orange)),
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Styles.white3,
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    border: Border.all(color: Styles.t1Orange)),
                child: Column(
                  children: [
                    // SizedBox(
                    //   height: size.height * 0.08,
                    // ),
                    InputButton(
                      text: DateFormat('kk:mm').format(DateTime.now()),
                      buttoncolor: Styles.white3,
                      textcolor: Styles.grey2,
                      icon: Icons.access_time,
                      width: 300,
                      onPressed: () {
                        // debugPrint("Pressed");
                        // clock = _createClockOverlay();
                        // Overlay.of(context).insert(clock);
                      },
                    ),
                    // SizedBox(
                    //   height: size.height * 0.03,
                    // ),
                    InputButton(
                      text: DateFormat("d MMM y").format(DateTime.now()),
                      buttoncolor: Styles.white3,
                      textcolor: Styles.grey2,
                      icon: Icons.calendar_today_rounded,
                      width: 300,
                      // onPressed: displayCalender,
                    ),
                    // SizedBox(
                    //   height: size.height * 0.03,
                    // ),
                    InputButton(
                      text: "30 mins before",
                      buttoncolor: Styles.white3,
                      textcolor: Styles.grey2,
                      icon: Icons.notifications,
                      width: 300,
                    ),
                    // SizedBox(
                    //   height: size.height * 0.04,
                    // ),
                    InputButton(
                      text: "  Update task",
                      buttoncolor: Styles.t1Orange,
                      textcolor: Styles.white3,
                      width: 200,
                      onPressed: () {
                        // final todo = TodosCompanion(
                        //   tagColor: moor.Value("#000000"),
                        //   tagName: moor.Value("play"),
                        //   title: moor.Value(_controller.text),
                        //   remainderTime: moor.Value("11:00 am"),
                        //   dueDate: moor.Value(date),
                        // );
                        // db.insertTodos(todo);
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
