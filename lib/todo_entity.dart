class Todo {
  const Todo({
    required this.id,
    required this.description,
    required this.priority,
    this.deadline,
    this.isCompleted = false,
  });

  final String id;
  final String description;
  final Priority priority;
  final DateTime? deadline;
  final bool isCompleted;

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
}

enum Priority {
  no,
  low,
  high,
}
