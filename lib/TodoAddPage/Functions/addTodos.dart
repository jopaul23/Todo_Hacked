import 'package:Todo_App/Database/provider.dart';
import 'package:Todo_App/Database/todo.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:moor/moor.dart';

class TodoStrcture {
  final String title, tagColor, tagName, remainder;
  final DateTime dueDate;

  TodoStrcture(
      {this.title, this.tagColor, this.tagName, this.remainder, this.dueDate});
}

class AddTodos {
  final dynamic db;
  AddTodos(this.db);
}
