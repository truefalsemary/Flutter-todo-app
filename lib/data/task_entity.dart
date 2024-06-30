import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_entity.g.dart';

@JsonSerializable()
class TaskEntity extends Equatable {
  const TaskEntity({
    required this.id,
    required this.description,
    required this.priority,
    this.deadline,
    this.isCompleted = false,
  });

  final int id;
  final String description;
  final Priority priority;
  final DateTime? deadline;
  final bool isCompleted;

  factory TaskEntity.empty(int id) {
    return TaskEntity(
      id: id,
      description: '',
      priority: Priority.low,
    );
  }

  TaskEntity copyWith({
    String? description,
    Priority? priority,
    DateTime? deadline,
    bool? isCompleted,
    bool? forceNullDeadline,
  }) {
    return TaskEntity(
      id: id,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      deadline: (forceNullDeadline ?? false) ? null : deadline ?? this.deadline,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  String toString() {
    return 'Todo{id: $id, description: $description, priority: $priority, deadline: $deadline, isCompleted: $isCompleted}';
  }

  @override
  List<Object?> get props => [id, description, priority, deadline, isCompleted];
}

enum Priority {
  no,
  low,
  high;

  parseToString() {
    switch (this) {
      case Priority.no:
        return 'no';
      case Priority.low:
        return 'low';
      case Priority.high:
        return 'high';
    }
  }
}
