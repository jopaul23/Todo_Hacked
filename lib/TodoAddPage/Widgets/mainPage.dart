import 'package:Todo_App/Database/Providers/database_providers.dart';
import 'package:Todo_App/Database/todo.dart';
import 'package:Todo_App/Helper%20Widgets/dropdown.dart';
import 'package:Todo_App/Helper%20Widgets/inputfield.dart';
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
  OverlayEntry clock;
  DateTime date;
  TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    DateTime now = DateTime.now();
    date = now;
    print(date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final db = Provider.of<TodoDao>(context, listen: false);
    final Size size = MediaQuery.of(context).size;
    return Consumer(builder: (context, watch, _) {
      final db = watch(databaseProvider);

      return Scaffold(
        backgroundColor: Styles.cream,
        body: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: size.height * 0.098,
              padding: EdgeInsets.only(left: 10),
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
                        Navigator.pop(context);
                      }),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CustomDropdown(
                      text: "Catagories",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              height: size.height * 0.06,
              child: TextField(
                controller: _controller,
                cursorHeight: 40,
                cursorColor: Styles.grey1,
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
                    offset: Offset(0, 2), // changes position of shadow
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
                      debugPrint("Pressed");
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
                    text: "30 mins before",
                    buttoncolor: Styles.white3,
                    textcolor: Styles.grey2,
                    icon: Icons.notifications,
                    width: 300,
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  InputButton(
                    text: "   Add task",
                    buttoncolor: Styles.t1Orange,
                    textcolor: Styles.white3,
                    width: 200,
                    onPressed: () {
                      // AddTodos addTodo = AddTodos(
                      //     title: _controller.text,
                      //     dueDate: date,
                      //     tagName: "Work",
                      //     tagColor: "#534234",
                      //     remainderTime: "10:00 am");
                      // addTodo.addTodo();

                      final task = TodosCompanion(
                        tagColor: moor.Value("#000000"),
                        tagName: moor.Value("Play"),
                        title: moor.Value(_controller.text),
                        remainderTime: moor.Value("11:00 am"),
                        dueDate: moor.Value(date),
                      );
                      db.insertTodos(task);
                      debugPrint("todo list added");
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  OverlayEntry _createClockOverlay() {
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
            isBeforeNoon: date.hour < 12,
            onClicked: (String hour, String minute, bool isBeforeNoon) {
              print("$hour:$minute");
              String month = date.month.toString();
              if (month.length == 1) month = "0" + month;
              String day = date.day.toString();
              if (day.length == 1) day = "0" + day;

              setState(() {
                if (!isBeforeNoon) {
                  if (hour != "12") hour = (12 + int.parse(hour)).toString();
                } else if (hour == "12") hour = "00";
                String dateString = "${date.year}-$month-$day $hour:$minute";
                date = DateTime.parse(dateString);
              });
              clock.remove();
            },
          ),
        ),
      );
    });
  }

  void displayCalender() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 2190)));
    if (picked != null) {
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
    }
  }
}
