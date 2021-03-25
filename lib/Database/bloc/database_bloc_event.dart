part of 'database_bloc_bloc.dart';

abstract class DatabaseBlocEvent extends Equatable {
  const DatabaseBlocEvent();

  @override
  List<Object> get props => [];
}

class GetAllTodos extends DatabaseBlocEvent {
  GetAllTodos();
  @override
  List<Object> get props => [];
}

class GetSearchedTask extends DatabaseBlocEvent {
  final String keyword;

  GetSearchedTask(this.keyword);
  @override
  List<Object> get props => [keyword];
}

class MarkAsCompleted extends DatabaseBlocEvent {
  final TodoModel todoModel;

  MarkAsCompleted(this.todoModel);
  @override
  List<Object> get props => [todoModel];
}

class DeleteTodo extends DatabaseBlocEvent {
  final TodoModel todoModel;

  DeleteTodo(this.todoModel);
  @override
  List<Object> get props => [todoModel];
}
