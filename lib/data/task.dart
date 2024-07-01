import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import 'importance_enum.dart';

class Task extends Equatable {
  const Task({
    required this.id,
    required this.text,
    required this.importance,
    this.deadline,
    this.done = false,
  });

  final String id;
  final String text;
  final Importance importance;
  final DateTime? deadline;
  final bool done;

  factory Task.empty() {
    return Task(
      id: const Uuid().v1(),
      text: '',
      importance: Importance.basic,
    );
  }

  Task copyWith({
    String? description,
    Importance? priority,
    DateTime? deadline,
    bool? isCompleted,
    bool? forceNullDeadline,
  }) {
    return Task(
      id: id,
      text: description ?? text,
      importance: priority ?? importance,
      deadline: (forceNullDeadline ?? false) ? null : deadline ?? deadline,
      done: isCompleted ?? done,
    );
  }

  @override
  String toString() {
    return 'Task{id: $id, description: $text, priority: $importance, deadline: $deadline, isCompleted: $done}';
  }

  @override
  List<Object?> get props => [id, text, importance, deadline, done];
}
