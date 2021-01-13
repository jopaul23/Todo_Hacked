import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../todo.dart';

final database = Provider<TodoDao>((ref) => TodoDao(TodoListDataBase()));
