import 'dart:async';

import 'package:flutter_todo_app/data/task_entity.dart';
import 'package:logging/logging.dart';

abstract class TasksRepo {
  FutureOr<void> addTodo(TaskEntity todo);

  FutureOr<void> saveTodo(TaskEntity todo);

  Stream<List<TaskEntity>> getAllTodos();

  FutureOr<bool> deleteTodo(int id);
}

class MockTasksRepo extends TasksRepo {
  static final MockTasksRepo _internalSingleton = MockTasksRepo._internal();

  factory MockTasksRepo() => _internalSingleton;

  MockTasksRepo._internal();

  late final _logger = Logger('MockTodosRepo');

  @override
  void addTodo(TaskEntity todo) {
    todos.add(todo);
    _logger.fine('add todo: $todo');
  }

  @override
  bool deleteTodo(int id) {
    todos = todos.where((todo) => todo.id != id).toList();
    _logger.fine('delete todo $id');
    return true;
  }

  @override
  Stream<List<TaskEntity>> getAllTodos() {
    return Stream.value(todos);
  }

  @override
  void saveTodo(TaskEntity todo) {
    final idx = todos.indexWhere((elem) => elem.id == todo.id);
    if (idx != -1) {
      todos[idx] = todo;
      _logger.fine('update todo: $todo');
    } else {
      todos.add(todo);
      _logger.fine('add new todo: $todo');
    }
  }

  List<TaskEntity> todos = <TaskEntity>[
    TaskEntity(
      id: 1,
      description: 'Buy groceries' * 10,
      priority: Priority.high,
      deadline: DateTime(2024, 6, 20),
      isCompleted: false,
    ),
    TaskEntity(
      id: 2,
      description: 'Finish the project report',
      priority: Priority.high,
      deadline: DateTime(2024, 6, 21),
      isCompleted: false,
    ),
    TaskEntity(
      id: 3,
      description: 'Schedule dentist appointment',
      priority: Priority.low,
      deadline: DateTime(2024, 6, 25),
      isCompleted: false,
    ),
    const TaskEntity(
      id: 4,
      description: 'Clean the house',
      priority: Priority.no,
      deadline: null,
      isCompleted: false,
    ),
    TaskEntity(
      id: 5,
      description: 'Reply to emails',
      priority: Priority.low,
      deadline: DateTime(2024, 6, 19),
      isCompleted: true,
    ),
    TaskEntity(
      id: 6,
      description: 'Prepare for meeting',
      priority: Priority.high,
      deadline: DateTime(2024, 6, 22),
      isCompleted: false,
    ),
    TaskEntity(
      id: 7,
      description: 'Renew gym membership',
      priority: Priority.low,
      deadline: DateTime(2024, 6, 30),
      isCompleted: false,
    ),
    const TaskEntity(
      id: 8,
      description: 'Call the bank',
      priority: Priority.no,
      deadline: null,
      isCompleted: false,
    ),
    const TaskEntity(
      id: 9,
      description: 'Read the new book',
      priority: Priority.low,
      deadline: null,
      isCompleted: false,
    ),
    TaskEntity(
      id: 10,
      description: 'Plan the weekend trip',
      priority: Priority.high,
      deadline: DateTime(2024, 6, 28),
      isCompleted: false,
    ),
    TaskEntity(
      id: 11,
      description: 'Find the Marauder’s Map',
      priority: Priority.high,
      deadline: DateTime(2024, 6, 20),
      isCompleted: false,
    ),
    TaskEntity(
      id: 12,
      description: 'Brew a Polyjuice Potion',
      priority: Priority.high,
      deadline: DateTime(2024, 6, 21),
      isCompleted: false,
    ),
    TaskEntity(
      id: 13,
      description: 'Attend a Quidditch match',
      priority: Priority.low,
      deadline: DateTime(2024, 6, 25),
      isCompleted: false,
    ),
    const TaskEntity(
      id: 14,
      description: 'Visit Honeydukes for magical sweets',
      priority: Priority.no,
      deadline: null,
      isCompleted: false,
    ),
    TaskEntity(
      id: 15,
      description: 'Help Dobby with his sock dilemma',
      priority: Priority.low,
      deadline: DateTime(2024, 6, 19),
      isCompleted: true,
    ),
    TaskEntity(
      id: 16,
      description: 'Defeat a Boggart',
      priority: Priority.high,
      deadline: DateTime(2024, 6, 22),
      isCompleted: false,
    ),
    TaskEntity(
      id: 17,
      description: 'Learn to cast a Patronus charm',
      priority: Priority.low,
      deadline: DateTime(2024, 6, 30),
      isCompleted: false,
    ),
    const TaskEntity(
      id: 18,
      description: 'Find the Chamber of Secrets',
      priority: Priority.no,
      deadline: null,
      isCompleted: false,
    ),
    const TaskEntity(
      id: 19,
      description: 'Study at Hogwarts library',
      priority: Priority.low,
      deadline: null,
      isCompleted: false,
    ),
    TaskEntity(
      id: 20,
      description: 'Rescue a Hungarian Horntail dragon',
      priority: Priority.high,
      deadline: DateTime(2024, 6, 28),
      isCompleted: false,
    ),
  ];
}
