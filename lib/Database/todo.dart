import 'dart:io';
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

  Stream<List<Todo>> searchTodoss(String searchTodo) {
    return (select(todos)
          ..where((u) => u.title.like("%$searchTodo%"))
          ..orderBy([
            (u) => OrderingTerm(expression: u.dueDate, mode: OrderingMode.asc),
          ]))
        .watch();
  }

  Stream<List<Todo>> watchFav() {
    return (select(todos)
          ..where((u) => u.notificationOn.equals(true))
          ..orderBy([
            (u) => OrderingTerm(expression: u.dueDate, mode: OrderingMode.asc),
          ]))
        .watch();
  }

  Future getCompletedTask() {
    return (select(todos)..where((u) => u.completed.equals(true))).get();
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
