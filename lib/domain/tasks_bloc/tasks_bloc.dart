import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_todo_app/data/task_entity.dart';
import 'package:flutter_todo_app/data/tasks_repo.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'tasks_event.dart';

part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<ManyTasksEvent, AllTasksState> {
  TasksBloc(TasksRepo repo)
      : _repo = repo,
        super(TasksInitial()) {
    on<AllTasksLoaded>(_onLoadTasks);
    on<SwitchTaskCompletition>(_onCompleteOneTask);
    on<OneTaskDeleted>(_onDeleteOneTask);
    on<AllTasksFilter>(_onFilterAllTasks);
    on<OneTaskSaved>(_onSaveOneTask);
  }

  final TasksRepo _repo;

  Future<void> _onLoadTasks(
      AllTasksLoaded event, Emitter<AllTasksState> emit) async {
    emit(TasksInProgress());
    await emit.forEach(
      _repo.getAllTodos(),
      onData: (todos) => TasksSuccess(cachedTasks: todos, showCompleted: true),
      // TODO(TrueFalseMary): подумать над обработкой onError
    );
  }

  Future<void> _onCompleteOneTask(
      SwitchTaskCompletition event, Emitter<AllTasksState> emit) async {
    if (state is TasksSuccess) {
      final selectedTodos = (state as TasksSuccess)
          .cachedTasks
          .map((todo) => todo.id == event.task.id
              ? todo.isCompleted
                  ? event.task.copyWith(isCompleted: false)
                  : event.task.copyWith(isCompleted: true)
              : todo)
          .toList();
      emit(TasksSuccess(
        cachedTasks: selectedTodos,
        showCompleted: (state as TasksSuccess).showCompleted,
      ));
    }
    _repo.saveTodo(event.task.copyWith(isCompleted: true));
  }

  Future<void> _onDeleteOneTask(
      OneTaskDeleted event, Emitter<AllTasksState> emit) async {
    if (state is TasksSuccess) {
      final todos = (state as TasksSuccess)
          .cachedTasks
          .where((todo) => !(todo.id == event.task.id))
          .toList();
      emit(TasksSuccess(
        cachedTasks: todos,
        showCompleted: (state as TasksSuccess).showCompleted,
      ));
    }
    _repo.deleteTodo(event.task.id);
  }

  Future<void> _onFilterAllTasks(
      AllTasksFilter event, Emitter<AllTasksState> emit) async {
    if (state is TasksSuccess) {
      emit(
        TasksSuccess(
          cachedTasks: (state as TasksSuccess).cachedTasks,
          showCompleted: event.showCompleted,
        ),
      );
    }
  }

  FutureOr<void> _onSaveOneTask(
      OneTaskSaved event, Emitter<AllTasksState> emit) async {
    if (state is TasksSuccess) {
      final currentState = state as TasksSuccess;

      final index = currentState.cachedTasks
          .indexWhere((element) => element.id == event.task.id);

      final newTodos = List<TaskEntity>.from(currentState.cachedTasks);

      if (index != -1) {
        newTodos[index] = event.task;
      } else {
        newTodos.add(event.task);
      }
      emit(
        TasksSuccess(
            cachedTasks: newTodos,
            showCompleted: (state as TasksSuccess).showCompleted),
      );
      _repo.saveTodo(event.task);
    }
  }

  @override
  AllTasksState? fromJson(Map<String, dynamic> json) {
    try {
      final tasks =
          (json['tasks'] as List).map((e) => TaskEntity.fromJson(e)).toList();
      final showCompleted = json['showCompleted'] as bool;
      final revision = json['revision'] as int;
      return TasksSuccess(
        cachedTasks: tasks,
        showCompleted: showCompleted,
        revision: revision,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AllTasksState state) {
    if (state is TasksSuccess) {
      return {
        'tasks': state.cachedTasks.map((e) => e.toJson()).toList(),
        'showCompleted': state.showCompleted,
        'revision': state.revision,
      };
    }
    return null;
  }
}
