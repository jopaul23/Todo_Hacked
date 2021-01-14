import 'package:Todo_App/Helper%20Widgets/inputfield.dart';
import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'message_box.dart';

enum ShowEditWindow { top, bottom }

class EditTodo extends StatelessWidget {
  final Offset offset;
  final double height;
  final ShowEditWindow viewPos;
  const EditTodo({Key key, this.offset, this.height, this.viewPos})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: viewPos == ShowEditWindow.top
            ? offset.dy - height - 100
            : offset.dy + height - 20,
        left: 20,
        right: 20,
        // bottom: viewPos == ShowEditWindow.top ? offset.dy -  : 20,
        child: SingleChildScrollView(
          reverse: true,
          child: Container(
            decoration: ShapeDecoration(
              color: Styles.t1Orange,

              shape: MessageBorder(viewPos == ShowEditWindow.bottom),
              // shadows: [
              //   BoxShadow(
              //       color: Colors.black, blurRadius: 4.0, offset: Offset(2, 2))
              // ]
            ),
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
                  buttoncolor: Styles.white1.withOpacity(0.8),
                  textcolor: Styles.t1Orange,
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
        ));
  }
}
