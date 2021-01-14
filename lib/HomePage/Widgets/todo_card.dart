import 'dart:ui';

import 'package:Todo_App/Database/provider.dart';
import 'package:Todo_App/Database/todo.dart';
import 'package:Todo_App/Helper%20Widgets/Toast/toast.dart';
import 'package:Todo_App/HomePage/Functions/homepage_todo_function.dart';
import 'package:Todo_App/HomePage/Widgets/edit_todos.dart';
import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moor/moor.dart' as moor;

class TodoCards extends HookWidget {
  final Todo todo;
  final Function(Todo) onCompleted;
  const TodoCards({Key key, this.todo, this.onCompleted}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final GlobalKey cardKey = GlobalKey();
    final editOverlay = useState();
    final opacity = useState(1.0);
    final completedTodo = useState(todo.completed);
    final db = useProvider(databaseProvider);
    final cardTapped = useState(false);
    return BackdropFilter(
      filter: ImageFilter.blur(
          sigmaX: cardTapped.value ? 1 : 0, sigmaY: cardTapped.value ? 1 : 0),
      child: GestureDetector(
        onLongPress: () {
          final pos = findDropdownData(cardKey);
          cardTapped.value = !cardTapped.value;
          if (cardTapped.value) {
            editOverlay.value = OverlayEntry(builder: (context) {
              final deviceHeight = MediaQuery.of(context).size.height;
              final ShowEditWindow showEditWin = deviceHeight - pos[0].dy > 450
                  ? ShowEditWindow.bottom
                  : ShowEditWindow.top;
              return EditTodo(
                offset: pos[0],
                height: pos[1],
                viewPos: showEditWin,
              );
            });
            Overlay.of(context).insert(editOverlay.value);
          } else
            editOverlay.value.remove();
        },
        child: AnimatedOpacity(
          opacity: opacity.value,
          duration: const Duration(milliseconds: 1000),
          child: Container(
            key: cardKey,
            margin:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0),
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Styles.white2,
              borderRadius: const BorderRadius.all(Radius.circular(30.0)),
              boxShadow: [
                BoxShadow(
                  color: Styles.grey4.withOpacity(0.02),
                  spreadRadius: cardTapped.value ? 20 : 7,
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
                // margin: const EdgeInsets.only(
                //     left: 20.0, right: 20.0, bottom: 30.0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                ),
                decoration: BoxDecoration(
                  color: Styles.red,
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Styles.grey4.withOpacity(0.02),
                      spreadRadius: cardTapped.value ? 20 : 7,
                      blurRadius: 7,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child:
                    Icon(Icons.delete_forever, color: Styles.white1, size: 40),
              ),
              onDismissed: (direction) {
                db.deleteTodos(todo);
                Toast toast = Toast("Deleted Todo");
                toast.showToast(context);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      tags(),
                      const SizedBox(width: 10.0),
                      Icon(Icons.edit_outlined),
                      Spacer(),
                      Icon(Icons.favorite_border_rounded),
                      const SizedBox(width: 5.0),
                      Icon(Icons.notifications_none_rounded),
                      const SizedBox(width: 5.0),
                      // Icon(Icons.check_box_outline_blank_rounded)
                      Checkbox(
                        onChanged: (bool value) {
                          completedTodo.value = value;
                          final updateTodo = TodosCompanion(
                              id: moor.Value(todo.id),
                              tagColor: moor.Value(todo.tagColor),
                              tagName: moor.Value(todo.tagName),
                              title: moor.Value(todo.title),
                              completed: moor.Value(value));
                          db.updateTodos(updateTodo);
                          opacity.value = 0;
                          onCompleted(todo);
                          Toast toast = Toast("Marked as completed");
                          toast.showToast(context);
                        },
                        value: completedTodo.value,
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
                      Text(
                        HomePageTodoFunction.formatDueTime(todo.dueDate),
                        style: TextStyle(fontSize: 15, color: Styles.grey4),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget tags() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
      decoration: BoxDecoration(
          color: Color(int.parse("0xFF" + todo.tagColor.replaceFirst("#", ""))),
          borderRadius: const BorderRadius.all(Radius.circular(30.0))),
      child: Text(
        "${todo.tagName}",
        style: TextStyle(color: Styles.white3),
      ),
    );
  }

  List findDropdownData(GlobalKey cardKey) {
    RenderBox renderBox = cardKey.currentContext.findRenderObject();
    final height = renderBox.size.height;
    final width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    // xPosition = offset.dx;
    // yPosition = offset.dy;
    return [offset, height];
  }
}
