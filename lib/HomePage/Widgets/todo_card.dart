import 'package:Todo_App/AccountPage/Functions/user_details.dart';
import 'package:Todo_App/Database/todo.dart';
import 'package:Todo_App/Database/todo_model.dart';
import 'package:Todo_App/HomePage/Functions/homepage_todo_function.dart';
import 'package:Todo_App/Overlays/Toast/toast_overlay.dart';
import 'package:Todo_App/Router/page_router.dart';
import 'package:Todo_App/Styles/images.dart';
import 'package:Todo_App/Styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:moor/moor.dart' as moor;

class TodoCard extends HookWidget {
  final Todo todo;

  const TodoCard(this.todo);
  Widget build(BuildContext context) {
    final fav = useState(false);
    fav.value = todo.notificationOn;
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
            TextButton(
                onPressed: () {
                  addTofav(context, fav);
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
                markAsCompleted(context, value);
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
    );
  }

  void addTofav(context, fav) {
    fav.value = !fav.value;
    UserTodoDetails.database.updateTodos(TodosCompanion(
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
  }

  void markAsCompleted(context, bool value) {
    final updateTodo = TodosCompanion(
        id: moor.Value(todo.id),
        tagIconId: moor.Value(todo.tagIconId),
        dueDate: moor.Value(todo.dueDate),
        remainderTime: moor.Value(todo.remainderTime),
        notificationOn: moor.Value(todo.notificationOn),
        title: moor.Value(todo.title),
        completed: moor.Value(value));

    UserTodoDetails.database.updateTodos(updateTodo);

    Toast toast = Toast("Marked as completed");
    toast.showToast(context);
  }
}
