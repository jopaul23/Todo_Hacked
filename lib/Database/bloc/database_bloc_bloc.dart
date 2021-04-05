import 'dart:async';

import 'package:todo_app/AccountPage/Functions/user_details.dart';
import 'package:todo_app/Database/todo_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../todo.dart';

part 'database_bloc_event.dart';
part 'database_bloc_state.dart';

class DatabaseBlocBloc extends Bloc<DatabaseBlocEvent, DatabaseBlocState> {
  DatabaseBlocBloc() : super(TaskLoading());

  @override
  Stream<DatabaseBlocState> mapEventToState(
    DatabaseBlocEvent event,
  ) async* {
    if (event is GetAllTodos) {
      yield TaskLoading();
      yield TaskLoaded(await _getTaskRecords(UserTodoDetails.database));
    } else if (event is GetSearchedTask) {
      yield TaskLoading();
      yield TaskLoaded(
          await _getSearchedTodo(UserTodoDetails.database, event.keyword));
    } else if (event is MarkAsCompleted) {
      yield TaskLoaded(
          await _markAsCompleted(UserTodoDetails.database, event.todoModel));
    } else if (event is DeleteTodo) {
      await _deleteTodo(UserTodoDetails.database, event.todoModel);
    }
  }

  Future<List<TodoModel>> _getTaskRecords(db) async {
    final List<Todo> data = await db.getAllTodos();
    final List<TodoModel> todoModel = [];
    data.forEach((Todo element) {
      TodoModel _model = TodoModel(
          id: element.id,
          title: element.title,
          tagIconId: element.tagIconId,
          completed: element.completed,
          dueDate: element.dueDate,
          notificationOn: element.notificationOn);
      todoModel.add(_model);
    });
    return todoModel;
  }

  Future<List<TodoModel>> _getSearchedTodo(db, String keyword) async {
    final List<Todo> data = await db.searchTodoss(keyword);
    final List<TodoModel> todoModel = [];
    data.forEach((Todo element) {
      todoModel.add(db.convertTodoModel(element));
    });
    return todoModel;
  }

  Future<List<TodoModel>> _markAsCompleted(db, TodoModel todo) {
    db.updateTodos(db.convertTodosCompanion(todo));
    return _getTaskRecords(db);
  }

  Future<List<TodoModel>> _deleteTodo(db, TodoModel todo) {
    db.deleteTodos(db.convertTodosCompanion(todo));
    return _getTaskRecords(db);
  }
}
