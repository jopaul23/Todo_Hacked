import 'package:Todo_App/Database/todo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final databaseProvider =
    Provider<TodoDao>((ref) => TodoDao(TodoListDataBase()));
