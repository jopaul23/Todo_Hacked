import 'dart:ui';

import 'package:Todo_App/Database/provider.dart';
import 'package:Todo_App/Database/todo.dart';
import 'package:Todo_App/Helper%20Widgets/Clock/Providers/time_provider.dart';
import 'package:Todo_App/Helper%20Widgets/Clock/clock_body.dart';
import 'package:Todo_App/Helper%20Widgets/Clock/clock_digital_display.dart';
import 'package:Todo_App/Helper%20Widgets/Toast/toast.dart';
import 'package:Todo_App/HomePage/Functions/homepage_todo_function.dart';
import 'package:Todo_App/HomePage/Widgets/edit_todos.dart';
import 'package:Todo_App/styles/images.dart';
import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moor/moor.dart' as moor;

class TodoCards extends HookWidget {
  final Todo todo;
  final Function(int) onCompleted;
  const TodoCards({Key key, this.todo, this.onCompleted}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    debugPrint("building");
    final GlobalKey cardKey = GlobalKey();
    final db = useProvider(databaseProvider);
    final fav = useState(false);
    fav.value = todo.notificationOn;

    return Container(
      key: cardKey,
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Styles.white2,
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        boxShadow: [
          BoxShadow(
            color: Styles.grey4.withOpacity(0.02),
            spreadRadius: 7,
            blurRadius: 7,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Dismissible(
        direction: DismissDirection.startToEnd,
        key: Key(todo.id.toString()),
        background: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
          ),
          decoration: BoxDecoration(
            color: Styles.red,
            borderRadius: const BorderRadius.all(Radius.circular(30.0)),
            boxShadow: [
              BoxShadow(
                color: Styles.grey4.withOpacity(0.02),
                spreadRadius: 7,
                blurRadius: 7,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Icon(Icons.delete_forever, color: Styles.white1, size: 40),
        ),
        onDismissed: (direction) {
          db.deleteTodos(todo);
          Toast toast = Toast("Deleted task");
          toast.showToast(context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  IconData(todo.tagIconId, fontFamily: 'MaterialIcons'),
                  color: Styles.t1Orange,
                ),
                // if (todo.dueDate.day < DateTime.now().day ||
                //     todo.dueDate.hour < DateTime.now().hour ||
                //     todo.dueDate.minute < DateTime.now().minute)
                if (todo.dueDate.isBefore(DateTime.now()))
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        color: Styles.red,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0))),
                    child: Text(
                      "Incompleted Task",
                      style: TextStyle(
                        color: Styles.white1,
                      ),
                    ),
                  ),
                Spacer(),
                TextButton(
                    onPressed: () {
                      fav.value = !fav.value;
                      db.updateTodos(TodosCompanion(
                        id: moor.Value(todo.id),
                        completed: moor.Value(todo.completed),
                        title: moor.Value(todo.title),
                        dueDate: moor.Value(todo.dueDate),
                        remainderTime: moor.Value(DateTime.now()),
                        notificationOn: moor.Value(fav.value),
                        tagIconId: moor.Value(todo.tagIconId),
                      ));
                      if (fav.value) {
                        Toast toast = Toast("Added to favourites");
                        toast.showToast(context);
                      } else {
                        Toast toast = Toast("Removed from favourites");
                        toast.showToast(context);
                      }
                    },
                    child: Image(
                      image: fav.value
                          ? ImportedImages.heartOn
                          : ImportedImages.heartOff,
                      height: 20,
                      width: 20,
                    )),

                const SizedBox(width: 5.0),
                // Icon(Icons.check_box_outline_blank_rounded)
                Checkbox(
                  onChanged: (bool value) async {
                    final updateTodo = TodosCompanion(
                        id: moor.Value(todo.id),
                        tagIconId: moor.Value(todo.tagIconId),
                        dueDate: moor.Value(todo.dueDate),
                        remainderTime: moor.Value(todo.remainderTime),
                        notificationOn: moor.Value(todo.notificationOn),
                        title: moor.Value(todo.title),
                        completed: moor.Value(value));

                    db.updateTodos(updateTodo);

                    Toast toast = Toast("Marked as completed");
                    toast.showToast(context);
                  },
                  value: false,
                )
              ],
            ),
            const SizedBox(height: 10.0),
            Text("${todo.title}",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Styles.grey4)),
            const SizedBox(height: 30.0),
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 30,
                  color: Styles.t1Orange,
                ),
                const SizedBox(width: 5.0),
                TextButton(
                  onPressed: () {
                    _createClockOverlay(context, db);
                  },
                  child: Text(
                    HomePageTodoFunction.formatDueTime(todo.dueDate),
                    style: TextStyle(fontSize: 15, color: Styles.grey4),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _createClockOverlay(context, db) {
    var clock;
    String hour = todo.dueDate.hour.toString();
    String minute = todo.dueDate.minute.toString();
    final bool isBeforeNoon = todo.dueDate.hour < 12;
    TimeProvider timeProvider = TimeProvider()
      ..updateHour(
          isBeforeNoon ? hour : "${int.parse(hour) - 12}", isBeforeNoon)
      ..updateMinute(minute);
    clock = OverlayEntry(builder: (context) {
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
                String month = todo.dueDate.month.toString();
                String day = todo.dueDate.day.toString();
                if (month.length == 1) month = "0" + month;
                if (day.length == 1) day = "0" + day;

                String dateString =
                    "${todo.dueDate.year}-$month-$day $hour:$minute:00";

                final updateTodo = TodosCompanion(
                    id: moor.Value(todo.id),
                    tagIconId: moor.Value(todo.tagIconId),
                    title: moor.Value(todo.title),
                    dueDate: moor.Value(DateTime.parse(dateString)),
                    remainderTime: moor.Value(todo.remainderTime),
                    notificationOn: moor.Value(todo.notificationOn),
                    completed: moor.Value(todo.completed));
                db.updateTodos(updateTodo);

                Toast toast = Toast("Updated task");
                toast.showToast(context);
                clock.remove();
              }),
        ),
      );
    });
    Overlay.of(context).insert(clock);
  }
}
