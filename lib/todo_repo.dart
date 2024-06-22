import 'dart:async';

import 'package:flutter_todo_app/todo_entity.dart';

abstract class TodosRepo {
  FutureOr<void> addTodo(Todo todo);

  FutureOr<void> saveTodo(Todo todo);

  Stream<List<Todo>> getAllTodos();

  FutureOr<bool> deleteTodo(String id);
}

class MockTodosRepo extends TodosRepo {
  static final MockTodosRepo _internalSingleton = MockTodosRepo._internal();

  factory MockTodosRepo() => _internalSingleton;

  MockTodosRepo._internal();

  @override
  void addTodo(Todo todo) {
    todos.add(todo);
  }

  @override
  bool deleteTodo(String id) {
    todos = todos.where((todo) => todo.id != id).toList();
    return true;
  }

  @override
  Stream<List<Todo>> getAllTodos() {
    return Stream.value(todos);
  }

  @override
  void saveTodo(Todo todo) {
    todos = todos.map((elem) => elem.id == todo.id ? todo : elem).toList();
  }

  List<Todo> todos = <Todo>[
    Todo(
      id: '1',
      description: 'Buy groceries',
      priority: Priority.high,
      deadline: DateTime(2024, 6, 20),
      isCompleted: false,
    ),
    Todo(
      id: '2',
      description: 'Finish the project report',
      priority: Priority.high,
      deadline: DateTime(2024, 6, 21),
      isCompleted: false,
    ),
    Todo(
      id: '3',
      description: 'Schedule dentist appointment',
      priority: Priority.low,
      deadline: DateTime(2024, 6, 25),
      isCompleted: false,
    ),
    const Todo(
      id: '4',
      description: 'Clean the house',
      priority: Priority.no,
      deadline: null,
      isCompleted: false,
    ),
    Todo(
      id: '5',
      description: 'Reply to emails',
      priority: Priority.low,
      deadline: DateTime(2024, 6, 19),
      isCompleted: true,
    ),
    Todo(
      id: '6',
      description: 'Prepare for meeting',
      priority: Priority.high,
      deadline: DateTime(2024, 6, 22),
      isCompleted: false,
    ),
    Todo(
      id: '7',
      description: 'Renew gym membership',
      priority: Priority.low,
      deadline: DateTime(2024, 6, 30),
      isCompleted: false,
    ),
    const Todo(
      id: '8',
      description: 'Call the bank',
      priority: Priority.no,
      deadline: null,
      isCompleted: false,
    ),
    const Todo(
      id: '9',
      description: 'Read the new book',
      priority: Priority.low,
      deadline: null,
      isCompleted: false,
    ),
    Todo(
      id: '10',
      description: 'Plan the weekend trip',
      priority: Priority.high,
      deadline: DateTime(2024, 6, 28),
      isCompleted: false,
    ),
  ];
}
