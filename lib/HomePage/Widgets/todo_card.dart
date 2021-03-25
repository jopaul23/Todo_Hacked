import 'package:Todo_App/Database/bloc/database_bloc_bloc.dart';
import 'package:Todo_App/Database/todo_model.dart';
import 'package:Todo_App/Overlays/Toast/toast_overlay.dart';
import 'package:Todo_App/Styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

class TodoCard extends HookWidget {
  final TodoModel todo;

  const TodoCard(this.todo);
  Widget build(BuildContext context) {
    return Column(
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
            Checkbox(
              onChanged: (bool value) async {
                markAsCompleted(context);
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
                // PageRouter.sailor.navigate(PageRouter.todoAddPage,
                //     args: TodoModel(
                //         id: todo.id,
                //         title: todo.title,
                //         dueDate: todo.dueDate,
                //         tagIconId: todo.tagIconId,
                //         completed: todo.completed,
                //         notificationOn: todo.notificationOn,
                //         remainderTime: todo.remainderTime));
              },
              child: Text(
                formatDueTime(todo.dueDate),
                style: TextStyle(fontSize: 15, color: Styles.grey4),
              ),
            )
          ],
        ),
      ],
    );
  }

  String formatDueTime(DateTime date) {
    return DateFormat("EEE,kk:mm").format(date);
  }

  void markAsCompleted(context) {
    BlocProvider.of<DatabaseBlocBloc>(context).add(MarkAsCompleted(todo));
    Toast toast = Toast("Marked as completed");
    toast.showToast(context);
  }
}
