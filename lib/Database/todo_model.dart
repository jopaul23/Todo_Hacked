import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';

class TodoModel extends Equatable {
  final int id;
  final String title;
  final int tagIconId;
  final DateTime remainderTime;
  final DateTime dueDate;
  final bool completed;
  final bool notificationOn;
  TodoModel(
      {@required this.id,
      @required this.title,
      @required this.tagIconId,
      this.remainderTime,
      this.dueDate,
      @required this.completed,
      @required this.notificationOn});

  @override
  List<Object> get props =>
      [id, title, tagIconId, remainderTime, dueDate, completed, notificationOn];
}
