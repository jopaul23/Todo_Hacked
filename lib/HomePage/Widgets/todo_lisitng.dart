import 'package:Todo_App/Database/bloc/database_bloc_bloc.dart';
import 'package:Todo_App/Database/todo_model.dart';
import 'package:intl/intl.dart';
import 'package:Todo_App/HomePage/Widgets/todo_Card_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'search.dart';

class TodoListing extends StatefulWidget {
  @override
  _TodoListingState createState() => _TodoListingState();
}

class _TodoListingState extends State<TodoListing> {
  // ignore: close_sinks
  final DatabaseBlocBloc bloc = DatabaseBlocBloc();
  List<TodoModel> todoModels;
  @override
  void initState() {
    super.initState();
    bloc.add(GetAllTodos());
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder(
        cubit: bloc,
        builder: (context, DatabaseBlocState state) {
          if (state is TaskLoaded) {
            final List<String> availableDates = [];
            todoModels = state.todoModel;
            return Column(
              children: [
                TodoListSearch(), //SearchBar

                const SizedBox(height: 10.0),

                if (state.todoModel.isEmpty) // if todo is empty
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
                    children: List.generate(
                        state.todoModel.length,
                        (int index) =>
                            listTodos(todoModels[index], availableDates)),
                  )
              ],
            );
          } else
            return loading(MediaQuery.of(context).size.height);
        },
      ),
    );
  }

  Widget loading(double height) {
    return Center(
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: height * 0.2),
          child: CupertinoActivityIndicator(
            radius: 20,
          )),
    );
  }

  listTodos(TodoModel todo, List<String> usedDates) {
    final card = TodoCardLayout(
        todo: todo,
        onDismissed: () {
          this.setState(() {
            todoModels.remove(todo);
          });
        });
    final String value = getWeekDay(
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

  Widget addDate(String day, TodoCardLayout card) {
    return Column(
      children: [
        const SizedBox(height: 10.0),
        Text(
          "$day",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        card
      ],
    );
  }

  String getWeekDay(DateTime dateTocheck) {
    final today = DateTime.now();

    if (today.day == dateTocheck.day)
      return "today";
    else if (dateTocheck.day == today.day + 1)
      return "Tommarrow";
    else {
      final format = DateFormat("d-M-y").format(dateTocheck);
      return "on " + format;
    }
  }
}
