import 'package:Todo_App/HomePage/Functions/homepage_todo_function.dart';
import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';

class TodoListSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
      decoration: BoxDecoration(
          color: Styles.grey1.withOpacity(0.2),
          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Styles.grey4.withOpacity(0.01),
              spreadRadius: 50,
              blurRadius: 20,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ]),
      child: Consumer(builder: (context, watch, _) {
        final mode = watch(homePageChangeModeProvider);
        return TextField(
          cursorColor: Styles.grey2,
          style: TextStyle(fontSize: 20, color: Styles.grey2),
          onChanged: (val) {
            HomePageTodoFunction.searchTodos = val;
            if (val.replaceAll(" ", "").isEmpty)
              mode.changeMode(HomePageChangeMode.normal);
            else
              mode.changeMode(HomePageChangeMode.search);
          },
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 20.0),
              hintText: "Search",
              hintStyle:
                  TextStyle(fontSize: 20, color: Styles.grey1.withOpacity(0.7)),
              border: InputBorder.none),
        );
      }),
    );
  }
}
