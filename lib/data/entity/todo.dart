import 'package:flutter/material.dart';

class Todo {
  final String taskName;
  final bool isCompleted;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  Todo({
    required this.taskName,
    required this.isCompleted,
    required this.date,
    required this.startTime,
    required this.endTime,
  });
}
