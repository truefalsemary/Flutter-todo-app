import 'dart:async';

import 'package:flutter_todo_app/data/task_entity.dart';
import 'package:logging/logging.dart';

import 'importance_enum.dart';

abstract class TasksRepo {
  FutureOr<void> addTodo(TaskEntity todo);

  FutureOr<void> saveTodo(TaskEntity todo);

  Stream<List<TaskEntity>> getAllTodos();

  FutureOr<bool> deleteTodo(String id);
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
  bool deleteTodo(String id) {
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

  List<TaskEntity> todos = List.generate(
    20,
    (int idx) => TaskEntity(
      id: idx.toString(),
      text: 'text: $idx',
      importance:
          (idx.isEven ? Importance.important : Importance.low).parseToString(),
      createdAt: DateTime.now(),
      changedAt: DateTime.now(),
      lastUpdatedBy: 'macbook',
    ),
  );
// <Task>[
//   Task(
//     id: '1',
//     text: 'Buy groceries' * 10,
//     importance: Importance.important,
//     deadline: DateTime(2024, 6, 20),
//     done: false,
//   ),
//   Task(
//     id: '2',
//     text: 'Finish the project report',
//     importance: Importance.important,
//     deadline: DateTime(2024, 6, 21),
//     done: false,
//   ),
//   Task(
//     id: '3',
//     text: 'Schedule dentist appointment',
//     importance: Importance.basic,
//     deadline: DateTime(2024, 6, 25),
//     done: false,
//   ),
//   const Task(
//     id: '4',
//     text: 'Clean the house',
//     importance: Importance.basic,
//     deadline: null,
//     done: false,
//   ),
//   Task(
//     id: '5',
//     text: 'Reply to emails',
//     importance: Importance.basic,
//     deadline: DateTime(2024, 6, 19),
//     done: true,
//   ),
//   Task(
//     id: '6',
//     text: 'Prepare for meeting',
//     importance: Importance.important,
//     deadline: DateTime(2024, 6, 22),
//     done: false,
//   ),
//   Task(
//     id: '7',
//     text: 'Renew gym membership',
//     importance: Importance.basic,
//     deadline: DateTime(2024, 6, 30),
//     done: false,
//   ),
//   const Task(
//     id: '8',
//     text: 'Call the bank',
//     importance: Importance.basic,
//     deadline: null,
//     done: false,
//   ),
//   const Task(
//     id: '9',
//     text: 'Read the new book',
//     importance: Importance.basic,
//     deadline: null,
//     done: false,
//   ),
//   Task(
//     id: '10',
//     text: 'Plan the weekend trip',
//     importance: Importance.important,
//     deadline: DateTime(2024, 6, 28),
//     done: false,
//   ),
//   Task(
//     id: '11',
//     text: 'Find the Marauder’s Map',
//     importance: Importance.important,
//     deadline: DateTime(2024, 6, 20),
//     done: false,
//   ),
//   Task(
//     id: '12',
//     text: 'Brew a Polyjuice Potion',
//     importance: Importance.important,
//     deadline: DateTime(2024, 6, 21),
//     done: false,
//   ),
//   Task(
//     id: '13',
//     text: 'Attend a Quidditch match',
//     importance: Importance.basic,
//     deadline: DateTime(2024, 6, 25),
//     done: false,
//   ),
//   const Task(
//     id: '14',
//     text: 'Visit Honeydukes for magical sweets',
//     importance: Importance.basic,
//     deadline: null,
//     done: false,
//   ),
//   Task(
//     id: '15',
//     text: 'Help Dobby with his sock dilemma',
//     importance: Importance.basic,
//     deadline: DateTime(2024, 6, 19),
//     done: true,
//   ),
//   Task(
//     id: '16',
//     text: 'Defeat a Boggart',
//     importance: Importance.important,
//     deadline: DateTime(2024, 6, 22),
//     done: false,
//   ),
//   Task(
//     id: '17',
//     text: 'Learn to cast a Patronus charm',
//     importance: Importance.basic,
//     deadline: DateTime(2024, 6, 30),
//     done: false,
//   ),
//   const Task(
//     id: '18',
//     text: 'Find the Chamber of Secrets',
//     importance: Importance.basic,
//     deadline: null,
//     done: false,
//   ),
//   const Task(
//     id: '19',
//     text: 'Study at Hogwarts library',
//     importance: Importance.basic,
//     deadline: null,
//     done: false,
//   ),
//   Task(
//     id: '20',
//     text: 'Rescue a Hungarian Horntail dragon',
//     importance: Importance.important,
//     deadline: DateTime(2024, 6, 28),
//     done: false,
//   ),
// ];
}
