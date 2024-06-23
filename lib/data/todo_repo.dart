import 'dart:async';

import 'package:flutter_todo_app/data/todo_entity.dart';
import 'package:logging/logging.dart';

abstract class TodosRepo {
  FutureOr<void> addTodo(Todo todo);

  FutureOr<void> saveTodo(Todo todo);

  Stream<List<Todo>> getAllTodos();

  FutureOr<bool> deleteTodo(int id);
}

class MockTodosRepo extends TodosRepo {
  static final MockTodosRepo _internalSingleton = MockTodosRepo._internal();

  factory MockTodosRepo() => _internalSingleton;

  MockTodosRepo._internal();

  late final _logger = Logger('MockTodosRepo');

  @override
  void addTodo(Todo todo) {
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
  Stream<List<Todo>> getAllTodos() {
    return Stream.value(todos);
  }

  @override
  void saveTodo(Todo todo) {
    final idx = todos.indexWhere((elem) => elem.id == todo.id);
    if (idx != -1) {
      todos[idx] = todo;
      _logger.fine('update todo: $todo');
    } else {
      todos.add(todo);
      _logger.fine('add new todo: $todo');
    }
  }

  List<Todo> todos = <Todo>[
    Todo(
      id: 1,
      description: 'Buy groceries' * 10,
      priority: Priority.high,
      deadline: DateTime(2024, 6, 20),
      isCompleted: false,
    ),
    Todo(
      id: 2,
      description: 'Finish the project report',
      priority: Priority.high,
      deadline: DateTime(2024, 6, 21),
      isCompleted: false,
    ),
    Todo(
      id: 3,
      description: 'Schedule dentist appointment',
      priority: Priority.low,
      deadline: DateTime(2024, 6, 25),
      isCompleted: false,
    ),
    const Todo(
      id: 4,
      description: 'Clean the house',
      priority: Priority.no,
      deadline: null,
      isCompleted: false,
    ),
    Todo(
      id: 5,
      description: 'Reply to emails',
      priority: Priority.low,
      deadline: DateTime(2024, 6, 19),
      isCompleted: true,
    ),
    Todo(
      id: 6,
      description: 'Prepare for meeting',
      priority: Priority.high,
      deadline: DateTime(2024, 6, 22),
      isCompleted: false,
    ),
    Todo(
      id: 7,
      description: 'Renew gym membership',
      priority: Priority.low,
      deadline: DateTime(2024, 6, 30),
      isCompleted: false,
    ),
    const Todo(
      id: 8,
      description: 'Call the bank',
      priority: Priority.no,
      deadline: null,
      isCompleted: false,
    ),
    const Todo(
      id: 9,
      description: 'Read the new book',
      priority: Priority.low,
      deadline: null,
      isCompleted: false,
    ),
    Todo(
      id: 10,
      description: 'Plan the weekend trip',
      priority: Priority.high,
      deadline: DateTime(2024, 6, 28),
      isCompleted: false,
    ),
    Todo(
      id: 11,
      description: 'Find the Marauder’s Map',
      priority: Priority.high,
      deadline: DateTime(2024, 6, 20),
      isCompleted: false,
    ),
    Todo(
      id: 12,
      description: 'Brew a Polyjuice Potion',
      priority: Priority.high,
      deadline: DateTime(2024, 6, 21),
      isCompleted: false,
    ),
    Todo(
      id: 13,
      description: 'Attend a Quidditch match',
      priority: Priority.low,
      deadline: DateTime(2024, 6, 25),
      isCompleted: false,
    ),
    const Todo(
      id: 14,
      description: 'Visit Honeydukes for magical sweets',
      priority: Priority.no,
      deadline: null,
      isCompleted: false,
    ),
    Todo(
      id: 15,
      description: 'Help Dobby with his sock dilemma',
      priority: Priority.low,
      deadline: DateTime(2024, 6, 19),
      isCompleted: true,
    ),
    Todo(
      id: 16,
      description: 'Defeat a Boggart',
      priority: Priority.high,
      deadline: DateTime(2024, 6, 22),
      isCompleted: false,
    ),
    Todo(
      id: 17,
      description: 'Learn to cast a Patronus charm',
      priority: Priority.low,
      deadline: DateTime(2024, 6, 30),
      isCompleted: false,
    ),
    const Todo(
      id: 18,
      description: 'Find the Chamber of Secrets',
      priority: Priority.no,
      deadline: null,
      isCompleted: false,
    ),
    const Todo(
      id: 19,
      description: 'Study at Hogwarts library',
      priority: Priority.low,
      deadline: null,
      isCompleted: false,
    ),
    Todo(
      id: 20,
      description: 'Rescue a Hungarian Horntail dragon',
      priority: Priority.high,
      deadline: DateTime(2024, 6, 28),
      isCompleted: false,
    ),
  ];
}
