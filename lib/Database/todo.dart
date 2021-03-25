import 'dart:io';
import 'package:Todo_App/Database/todo_model.dart';
import 'package:path/path.dart' as p;
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path_provider/path_provider.dart';

part 'todo.g.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  IntColumn get tagIconId => integer()();
  DateTimeColumn get remainderTime => dateTime().nullable()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  BoolColumn get completed => boolean().withDefault(Constant(false))();
  BoolColumn get notificationOn => boolean().withDefault(Constant(true))();
}

@UseMoor(tables: [Todos])
class TodoListDataBase extends _$TodoListDataBase {
  TodoListDataBase() : super((_openConnection()));
  // Future<List<Todo>> getAllTodoss() => select(todos).get();
  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;
}

@UseDao(tables: [Todos])
class TodoDao extends DatabaseAccessor<TodoListDataBase> with _$TodoDaoMixin {
  final TodoListDataBase db;

  // Called by the AppDatabase class
  TodoDao(this.db) : super(db);

  Stream<List<Todo>> watchAllTodoss() {
    return (select(todos)
          ..where((u) => u.completed.equals(false))
          ..orderBy([
            (u) => OrderingTerm(expression: u.dueDate, mode: OrderingMode.asc),
          ]))
        .watch();
  }

  Future<List<Todo>> getAllTodos() {
    return (select(todos)
          ..where((u) => u.completed.equals(false))
          ..orderBy([
            (u) => OrderingTerm(expression: u.dueDate, mode: OrderingMode.asc),
          ]))
        .get();
  }

  Future<List<Todo>> searchTodoss(String searchTodo) {
    return (select(todos)
          ..where((u) => u.title.like("%$searchTodo%"))
          ..where((u) => u.completed.equals(false))
          ..orderBy([
            (u) => OrderingTerm(expression: u.dueDate, mode: OrderingMode.asc),
          ]))
        .get();
  }

  Stream<List<Todo>> watchFav() {
    return (select(todos)
          ..where((u) => u.notificationOn.equals(true))
          ..where((u) => u.completed.equals(false))
          ..orderBy([
            (u) => OrderingTerm(expression: u.dueDate, mode: OrderingMode.asc),
          ]))
        .watch();
  }

  Future getCompletedTask() {
    return (select(todos)..where((u) => u.completed.equals(true))).get();
  }

  Future getTodaysCompletedTask() {
    return (select(todos)
          ..where((u) => u.completed.equals(true))
          ..where((u) => u.dueDate.equals(DateTime.now())))
        .get();
  }

  Future getTodyaPendingTask() {
    return (select(todos)
          ..where((u) => u.completed.equals(false))
          ..where((u) => u.dueDate.equals(DateTime.now())))
        .get();
  }

  Future getPendingTask() {
    return (select(todos)..where((u) => u.completed.equals(false))).get();
  }

  Future getTodosUsingId(int id) {
    return (select(todos)..where((u) => u.id.equals(id))).get();
  }

  Future getTodo(Insertable<Todo> todo) => select(todos).get();

  Future insertTodos(Insertable<Todo> todo) => into(todos).insert(todo);
  Future updateTodos(Insertable<Todo> todo) => update(todos).replace(todo);
  Future deleteTodos(Insertable<Todo> todo) => delete(todos).delete(todo);

  TodoModel convertTodoModel(Todo element) => TodoModel(
      id: element.id,
      title: element.title,
      tagIconId: element.tagIconId,
      completed: element.completed,
      dueDate: element.dueDate,
      notificationOn: element.notificationOn);

  TodosCompanion convertTodosCompanion(TodoModel todo) => TodosCompanion(
      id: Value(todo.id),
      tagIconId: Value(todo.tagIconId),
      dueDate: Value(todo.dueDate),
      remainderTime: Value(todo.remainderTime),
      notificationOn: Value(todo.notificationOn),
      title: Value(todo.title),
      completed: Value(true));
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file, logStatements: true);
  });
}
