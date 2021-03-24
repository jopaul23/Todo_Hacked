// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Todo extends DataClass implements Insertable<Todo> {
  final int id;
  final String title;
  final int tagIconId;
  final DateTime remainderTime;
  final DateTime dueDate;
  final bool completed;
  final bool notificationOn;
  Todo(
      {@required this.id,
      @required this.title,
      @required this.tagIconId,
      this.remainderTime,
      this.dueDate,
      @required this.completed,
      @required this.notificationOn});
  factory Todo.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Todo(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      tagIconId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}tag_icon_id']),
      remainderTime: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}remainder_time']),
      dueDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}due_date']),
      completed:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}completed']),
      notificationOn: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}notification_on']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || tagIconId != null) {
      map['tag_icon_id'] = Variable<int>(tagIconId);
    }
    if (!nullToAbsent || remainderTime != null) {
      map['remainder_time'] = Variable<DateTime>(remainderTime);
    }
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    if (!nullToAbsent || completed != null) {
      map['completed'] = Variable<bool>(completed);
    }
    if (!nullToAbsent || notificationOn != null) {
      map['notification_on'] = Variable<bool>(notificationOn);
    }
    return map;
  }

  TodosCompanion toCompanion(bool nullToAbsent) {
    return TodosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      tagIconId: tagIconId == null && nullToAbsent
          ? const Value.absent()
          : Value(tagIconId),
      remainderTime: remainderTime == null && nullToAbsent
          ? const Value.absent()
          : Value(remainderTime),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      completed: completed == null && nullToAbsent
          ? const Value.absent()
          : Value(completed),
      notificationOn: notificationOn == null && nullToAbsent
          ? const Value.absent()
          : Value(notificationOn),
    );
  }

  factory Todo.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Todo(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      tagIconId: serializer.fromJson<int>(json['tagIconId']),
      remainderTime: serializer.fromJson<DateTime>(json['remainderTime']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      completed: serializer.fromJson<bool>(json['completed']),
      notificationOn: serializer.fromJson<bool>(json['notificationOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'tagIconId': serializer.toJson<int>(tagIconId),
      'remainderTime': serializer.toJson<DateTime>(remainderTime),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'completed': serializer.toJson<bool>(completed),
      'notificationOn': serializer.toJson<bool>(notificationOn),
    };
  }

  Todo copyWith(
          {int id,
          String title,
          int tagIconId,
          DateTime remainderTime,
          DateTime dueDate,
          bool completed,
          bool notificationOn}) =>
      Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        tagIconId: tagIconId ?? this.tagIconId,
        remainderTime: remainderTime ?? this.remainderTime,
        dueDate: dueDate ?? this.dueDate,
        completed: completed ?? this.completed,
        notificationOn: notificationOn ?? this.notificationOn,
      );
  @override
  String toString() {
    return (StringBuffer('Todo(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('tagIconId: $tagIconId, ')
          ..write('remainderTime: $remainderTime, ')
          ..write('dueDate: $dueDate, ')
          ..write('completed: $completed, ')
          ..write('notificationOn: $notificationOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(
              tagIconId.hashCode,
              $mrjc(
                  remainderTime.hashCode,
                  $mrjc(dueDate.hashCode,
                      $mrjc(completed.hashCode, notificationOn.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Todo &&
          other.id == this.id &&
          other.title == this.title &&
          other.tagIconId == this.tagIconId &&
          other.remainderTime == this.remainderTime &&
          other.dueDate == this.dueDate &&
          other.completed == this.completed &&
          other.notificationOn == this.notificationOn);
}

class TodosCompanion extends UpdateCompanion<Todo> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> tagIconId;
  final Value<DateTime> remainderTime;
  final Value<DateTime> dueDate;
  final Value<bool> completed;
  final Value<bool> notificationOn;
  const TodosCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.tagIconId = const Value.absent(),
    this.remainderTime = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.completed = const Value.absent(),
    this.notificationOn = const Value.absent(),
  });
  TodosCompanion.insert({
    this.id = const Value.absent(),
    @required String title,
    @required int tagIconId,
    this.remainderTime = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.completed = const Value.absent(),
    this.notificationOn = const Value.absent(),
  })  : title = Value(title),
        tagIconId = Value(tagIconId);
  static Insertable<Todo> custom({
    Expression<int> id,
    Expression<String> title,
    Expression<int> tagIconId,
    Expression<DateTime> remainderTime,
    Expression<DateTime> dueDate,
    Expression<bool> completed,
    Expression<bool> notificationOn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (tagIconId != null) 'tag_icon_id': tagIconId,
      if (remainderTime != null) 'remainder_time': remainderTime,
      if (dueDate != null) 'due_date': dueDate,
      if (completed != null) 'completed': completed,
      if (notificationOn != null) 'notification_on': notificationOn,
    });
  }

  TodosCompanion copyWith(
      {Value<int> id,
      Value<String> title,
      Value<int> tagIconId,
      Value<DateTime> remainderTime,
      Value<DateTime> dueDate,
      Value<bool> completed,
      Value<bool> notificationOn}) {
    return TodosCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      tagIconId: tagIconId ?? this.tagIconId,
      remainderTime: remainderTime ?? this.remainderTime,
      dueDate: dueDate ?? this.dueDate,
      completed: completed ?? this.completed,
      notificationOn: notificationOn ?? this.notificationOn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (tagIconId.present) {
      map['tag_icon_id'] = Variable<int>(tagIconId.value);
    }
    if (remainderTime.present) {
      map['remainder_time'] = Variable<DateTime>(remainderTime.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (notificationOn.present) {
      map['notification_on'] = Variable<bool>(notificationOn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodosCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('tagIconId: $tagIconId, ')
          ..write('remainderTime: $remainderTime, ')
          ..write('dueDate: $dueDate, ')
          ..write('completed: $completed, ')
          ..write('notificationOn: $notificationOn')
          ..write(')'))
        .toString();
  }
}

class $TodosTable extends Todos with TableInfo<$TodosTable, Todo> {
  final GeneratedDatabase _db;
  final String _alias;
  $TodosTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _tagIconIdMeta = const VerificationMeta('tagIconId');
  GeneratedIntColumn _tagIconId;
  @override
  GeneratedIntColumn get tagIconId => _tagIconId ??= _constructTagIconId();
  GeneratedIntColumn _constructTagIconId() {
    return GeneratedIntColumn(
      'tag_icon_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _remainderTimeMeta =
      const VerificationMeta('remainderTime');
  GeneratedDateTimeColumn _remainderTime;
  @override
  GeneratedDateTimeColumn get remainderTime =>
      _remainderTime ??= _constructRemainderTime();
  GeneratedDateTimeColumn _constructRemainderTime() {
    return GeneratedDateTimeColumn(
      'remainder_time',
      $tableName,
      true,
    );
  }

  final VerificationMeta _dueDateMeta = const VerificationMeta('dueDate');
  GeneratedDateTimeColumn _dueDate;
  @override
  GeneratedDateTimeColumn get dueDate => _dueDate ??= _constructDueDate();
  GeneratedDateTimeColumn _constructDueDate() {
    return GeneratedDateTimeColumn(
      'due_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _completedMeta = const VerificationMeta('completed');
  GeneratedBoolColumn _completed;
  @override
  GeneratedBoolColumn get completed => _completed ??= _constructCompleted();
  GeneratedBoolColumn _constructCompleted() {
    return GeneratedBoolColumn('completed', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _notificationOnMeta =
      const VerificationMeta('notificationOn');
  GeneratedBoolColumn _notificationOn;
  @override
  GeneratedBoolColumn get notificationOn =>
      _notificationOn ??= _constructNotificationOn();
  GeneratedBoolColumn _constructNotificationOn() {
    return GeneratedBoolColumn('notification_on', $tableName, false,
        defaultValue: Constant(true));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, title, tagIconId, remainderTime, dueDate, completed, notificationOn];
  @override
  $TodosTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'todos';
  @override
  final String actualTableName = 'todos';
  @override
  VerificationContext validateIntegrity(Insertable<Todo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('tag_icon_id')) {
      context.handle(_tagIconIdMeta,
          tagIconId.isAcceptableOrUnknown(data['tag_icon_id'], _tagIconIdMeta));
    } else if (isInserting) {
      context.missing(_tagIconIdMeta);
    }
    if (data.containsKey('remainder_time')) {
      context.handle(
          _remainderTimeMeta,
          remainderTime.isAcceptableOrUnknown(
              data['remainder_time'], _remainderTimeMeta));
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date'], _dueDateMeta));
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed'], _completedMeta));
    }
    if (data.containsKey('notification_on')) {
      context.handle(
          _notificationOnMeta,
          notificationOn.isAcceptableOrUnknown(
              data['notification_on'], _notificationOnMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Todo map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Todo.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TodosTable createAlias(String alias) {
    return $TodosTable(_db, alias);
  }
}

abstract class _$TodoListDataBase extends GeneratedDatabase {
  _$TodoListDataBase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $TodosTable _todos;
  $TodosTable get todos => _todos ??= $TodosTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [todos];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$TodoDaoMixin on DatabaseAccessor<TodoListDataBase> {
  $TodosTable get todos => attachedDatabase.todos;
}
