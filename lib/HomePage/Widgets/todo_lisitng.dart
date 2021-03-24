import 'package:Todo_App/AccountPage/Functions/user_details.dart';
import 'package:Todo_App/Database/todo.dart';
import 'package:Todo_App/HomePage/Functions/homepage_todo_function.dart';
import 'package:Todo_App/HomePage/Widgets/todo_Card_layout.dart';
import 'package:Todo_App/Styles/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'search.dart';

class TodoListing extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final mode = useProvider(homePageChangeModeProvider.state);
    return StreamBuilder(
        stream: mode == HomePageChangeMode.search
            ? UserTodoDetails.database
                .searchTodoss(HomePageTodoFunction.searchTodos)
            : mode == HomePageChangeMode.favorites
                ? UserTodoDetails.database.watchFav()
                : UserTodoDetails.database.watchAllTodoss(),
        builder: (context, AsyncSnapshot<List<Todo>> snapshot) {
          if (snapshot.hasData) {
            final List<String> availableDates = [];

            final todos = snapshot.data;
            return Column(
              children: [
                TodoListSearch(), //SearchBar

                const SizedBox(height: 10.0),

                if (todos.isEmpty) // if todo is empty
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.0),
                    child: Image.asset(
                      "assets/Images/man.png",
                      height: 200,
                      width: 200,
                    ),
                  )
                else
                  Column(
                    children: List.generate(todos.length,
                        (int index) => listTodos(todos[index], availableDates)),
                  )
              ],
            );
          }

          //loading animation
          return Center(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.2),
                child: CupertinoActivityIndicator(
                  radius: 20,
                )),
          );
        });
  }

  listTodos(todo, List<String> usedDates) {
    final card = TodoCardLayout(
      todo,
    );
    final String value = HomePageTodoFunction.getWeekDay(
      todo.dueDate,
    );

    //if the date is already present in the usedDates array ,then it will return the card itself ,otherwise the addDate widget.
    if (usedDates.contains(value))
      return card;
    else {
      usedDates.add(value);
      return addDate(value, card);
    }
  }

//Format the date of the todos
  Widget addDate(String day, TodoCardLayout card) {
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
