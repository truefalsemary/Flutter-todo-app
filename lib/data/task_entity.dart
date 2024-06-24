import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  const TodoEntity({
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

  factory TodoEntity.empty(int id) {
    return TodoEntity(
      id: id,
      description: '',
      priority: Priority.low,
    );
  }

  TodoEntity copyWith({
    String? description,
    Priority? priority,
    DateTime? deadline,
    bool? isCompleted,
    bool? forceNullDeadline,
  }) {
    return TodoEntity(
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
  high,
}

extension PriorityExt on Priority {
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
