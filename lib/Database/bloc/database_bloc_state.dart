part of 'database_bloc_bloc.dart';

abstract class DatabaseBlocState extends Equatable {
  const DatabaseBlocState();

  @override
  List<Object> get props => [];
}

class TaskLoading extends DatabaseBlocState {}

class TaskLoaded extends DatabaseBlocState {
  final List<TodoModel> todoModel;

  TaskLoaded(this.todoModel);
  @override
  List<Object> get props => [todoModel];
}
