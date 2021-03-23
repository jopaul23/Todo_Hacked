import 'dart:ui';
import 'package:Todo_App/Database/Todo_model.dart';
import 'package:Todo_App/Overlays/clock_overlay.dart';
import 'package:Todo_App/Router/page_router.dart';
import 'package:Todo_App/TodoAddPage/Functions/addTodos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moor/moor.dart' as moor;

import '../../Database/todo.dart';
import '../../Database/provider.dart';
import '../../Overlays/Toast/toast_overlay.dart';
import '../Functions/homepage_todo_function.dart';
import '../../styles/images.dart';
import '../../styles/styles.dart';

class TodoCards extends HookWidget {
  final Todo todo;
  final Function(int) onCompleted;
  const TodoCards({Key key, this.todo, this.onCompleted}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final db = useProvider(databaseProvider);
    final fav = useState(false);
    fav.value = todo.notificationOn;

    return Container(
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
                    PageRouter.sailor.navigate(PageRouter.todoAddPage,
                        args: TodoModel(
                            id: todo.id,
                            title: todo.title,
                            dueDate: todo.dueDate,
                            tagIconId: todo.tagIconId,
                            completed: todo.completed,
                            notificationOn: todo.notificationOn,
                            remainderTime: todo.remainderTime));
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

  void updateDueDate(context, db, clock, {String hour, String minute}) {
    String month = todo.dueDate.month.toString();
    String day = todo.dueDate.day.toString();
    if (month.length == 1) month = "0" + month;
    if (day.length == 1) day = "0" + day;

    String dateString = "${todo.dueDate.year}-$month-$day $hour:$minute:00";
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
  }
}
