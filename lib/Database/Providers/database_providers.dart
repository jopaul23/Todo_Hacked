import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../todo.dart';

final databaseProvider =
    Provider<TodoDao>((ref) => TodoDao(TodoListDataBase()));

final todoListNotifierProvider =
    StateNotifierProvider<TodoListNotifier>((ref) => TodoListNotifier());

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier() : super([]);
  void updateTodoList(List<Todo> todoList) {
    state = todoList;
  }
}
