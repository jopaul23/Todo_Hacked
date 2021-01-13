import 'package:Todo_App/Database/Providers/database_providers.dart';
import 'package:Todo_App/Database/todo.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:moor/moor.dart';

class AddTodos {
  final String title, remainderTime, tagName, tagColor;
  final DateTime dueDate;
  ProviderContainer container;
  AddTodos(
      {this.title,
      this.remainderTime,
      this.tagName,
      this.tagColor,
      this.dueDate}) {
    container = ProviderContainer();
  }

  void addTodo() {
    final task = TodosCompanion(
      tagColor: Value(tagColor),
      tagName: Value(tagName),
      title: Value(title),
      remainderTime: Value(remainderTime),
      dueDate: Value(dueDate),
    );
    container.read(database).insertTodos(task);
  }
}
