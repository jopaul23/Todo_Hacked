import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path_provider/path_provider.dart';

part 'todo.g.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 3, max: 16)();
  TextColumn get tagName => text().withLength(min: 1, max: 6)();
  TextColumn get tagColor => text().withLength(min: 1, max: 7)();
  TextColumn get remainderTime => text().nullable()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  BoolColumn get completed => boolean().withDefault(Constant(false))();
  BoolColumn get notificationOn => boolean().withDefault(Constant(false))();
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

  Future<List<Todo>> getAllTodoss() {
    return (select(todos)
          ..orderBy([
            (u) => OrderingTerm(expression: u.dueDate, mode: OrderingMode.asc),
          ]))
        .get();
  }

  Stream<List<Todo>> watchAllTodoss() => select(todos).watch();
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
