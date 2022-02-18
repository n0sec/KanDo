import 'package:flutter/material.dart';

enum Priority {
  low,
  medium,
  high,
}

class ToDoItem {
  final String id;
  final List<String>? label;
  final Color? labelColor;
  final Enum priority;
  final String? description;
  final String taskName;
  final DateTime? dueDate;
  bool isCompleted;

  ToDoItem({
    required this.id,
    this.label,
    this.labelColor,
    this.priority = Priority.low,
    this.description,
    required this.taskName,
    this.dueDate,
    this.isCompleted = false,
  });
}
