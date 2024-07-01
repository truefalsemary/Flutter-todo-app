import 'dart:async';

import 'package:flutter_todo_app/data/repo/tasks_repo.dart';
import 'package:logging/logging.dart';

import '../importance_enum.dart';
import '../task_entity.dart';

class MockTasksRepo extends TasksRepo {
  static final MockTasksRepo _internalSingleton = MockTasksRepo._internal();

  factory MockTasksRepo() => _internalSingleton;

  MockTasksRepo._internal();

  late final _logger = Logger('MockTodosRepo');

  int revision = 0;

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

  @override
  FutureOr<({int? revision})> deleteTodo(String id) {
    todos = todos.where((todo) => todo.id != id).toList();
    _logger.fine('delete todo $id');
    revision += 1;
    return (revision: revision);
  }

  @override
  ({int? revision, List<TaskEntity>? tasks}) getAllTodos() {
    return (revision: revision, tasks: todos);
  }

  @override
  ({int? revision, List<TaskEntity>? tasks}) updateTodos({
    required List<TaskEntity> tasks,
    required int revision,
  }) {
    todos.clear();
    todos.addAll(tasks);
    this.revision = revision + 1;
    return (revision: this.revision, tasks: todos);
  }

  @override
  FutureOr<({int? revision})> addTodo(
      {required TaskEntity todo, required int revision}) {
    todos.add(todo);
    this.revision = revision + 1;
    return (revision: this.revision);
  }

  @override
  FutureOr<({int? revision})> updateTodo(
      {required TaskEntity todo, required int revision}) {
    final idx = todos.indexWhere((elem) => elem.id == todo.id);
    if (idx != -1) {
      todos[idx] = todo;
      _logger.fine('update todo: $todo');
    } else {
      todos.add(todo);
      _logger.fine('add new todo: $todo');
    }
    this.revision = revision + 1;
    return (revision: this.revision);
  }
}
