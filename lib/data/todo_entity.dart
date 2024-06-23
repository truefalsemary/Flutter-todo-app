class Todo {
  const Todo({
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

  factory Todo.empty(int id) {
    return Todo(
      id: id,
      description: '',
      priority: Priority.low,
    );
  }

  Todo copyWith({
    String? description,
    Priority? priority,
    DateTime? deadline,
    bool? isCompleted,
  }) {
    return Todo(
      id: id,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      deadline: deadline ?? this.deadline,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  String toString() {
    return 'Todo{id: $id, description: $description, priority: $priority, deadline: $deadline, isCompleted: $isCompleted}';
  }
}

enum Priority {
  no,
  low,
  high,
}


extension PriorityExt on Priority {
  parseToString(){
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