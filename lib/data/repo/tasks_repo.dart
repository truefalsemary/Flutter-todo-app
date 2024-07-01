import 'dart:async';

import 'package:flutter_todo_app/data/task_entity.dart';

abstract class TasksRepo {
  FutureOr<({int? revision})> addTodo({
    required TaskEntity todo,
    required int revision,
  });

  FutureOr<({int? revision})> updateTodo({
    required TaskEntity todo,
    required int revision,
  });

  FutureOr<({List<TaskEntity>? tasks, int? revision})> getAllTodos();

  FutureOr<({int? revision})> deleteTodo(String id);

  FutureOr<({List<TaskEntity>? tasks, int? revision})> updateTodos({
    required List<TaskEntity> tasks,
    required int revision,
  });
}
