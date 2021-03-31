import 'dart:ui';
import 'package:Todo_App/Database/bloc/database_bloc_bloc.dart';
import 'package:Todo_App/Database/todo_model.dart';
import 'package:Todo_App/Overlays/Toast/toast_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'todo_card.dart';
import '../../Themes/colors.dart' as appColors;

class TodoCardLayout extends StatelessWidget {
  final TodoModel todo;
  final Function() onDismissed;
  const TodoCardLayout({@required this.todo, @required this.onDismissed});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: theme.accentColor,
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        boxShadow: [appColors.shadow.scale(10)],
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
              color: theme.errorColor,
              borderRadius: const BorderRadius.all(Radius.circular(30.0)),
              boxShadow: [appColors.shadow],
            ),
            child:
                Icon(Icons.delete_forever, color: theme.accentColor, size: 40),
          ),
          onDismissed: (direction) {
            BlocProvider.of<DatabaseBlocBloc>(context).add(DeleteTodo(todo));
            Toast toast = Toast("Deleted task");
            toast.showToast(context);
            onDismissed();
          },
          child: TodoCard(todo)),
    );
  }
}
