import 'package:Todo_App/Database/Providers/database_providers.dart';
import 'package:Todo_App/Database/todo.dart';
import 'package:Todo_App/Helper%20Widgets/basic_widget.dart';
import 'package:Todo_App/HomePage/Functions/homepage_todo_function.dart';
import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'calender.dart';
import 'search.dart';
import 'todo_card.dart';

class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BasicWidget(
      pageNo: 1,
      child: Container(
        height: size.height,
        decoration: BoxDecoration(
          gradient: Styles.t1Gradient,
        ),
        child: Stack(
          children: <Widget>[
            Calender(DateTime.now()),
            Padding(
              padding: EdgeInsets.only(top: 160),
              child: Container(
                height: size.height,
                padding: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                    color: Styles.white2.withOpacity(.96),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0))),
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 5, bottom: 80),
                    child: StreamBuilder(
                        stream: useProvider(database).watchAllTodoss(),
                        builder: (context, AsyncSnapshot<List<Todo>> snapshot) {
                          if (snapshot.hasData) {
                            final todos = snapshot.data;
                            return Column(
                              children: [
                                TodoListSearch(),
                                const SizedBox(height: 10.0),
                                Column(
                                  children:
                                      List.generate(todos.length, (int index) {
                                    final Todo todo = todos[index];
                                    final card =
                                        HomePageTodoFunction.makeCard(todo);
                                    final String value =
                                        HomePageTodoFunction.getWeekDay(
                                      index == 0
                                          ? null
                                          : todos[index - 1].dueDate,
                                      todo.dueDate,
                                    );
                                    if (value == null) return card;
                                    return addDate(value, card);
                                  }),
                                )
                              ],
                            );
                          }
                          return CircularProgressIndicator();
                        })),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addDate(String day, TodoCards card) {
    return Column(
      children: [
        const SizedBox(height: 10.0),
        Text(
          "$day",
          style: TextStyle(color: Styles.grey1, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        card
      ],
    );
  }
}
