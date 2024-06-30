import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_todo_app/data/task_entity.dart';
import 'package:flutter_todo_app/data/tasks_repo.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';

import '../../data/task.dart';

part 'tasks_event.dart';

part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<ManyTasksEvent, AllTasksState> {
  TasksBloc(TasksRepo repo)
      : _repo = repo,
        super(const AllTasksState()) {
    on<AllTasksLoaded>(_onLoadTasks);
    on<SwitchTaskCompletition>(_onCompleteOneTask);
    on<OneTaskDeleted>(_onDeleteOneTask);
    on<AllTasksFilter>(_onFilterAllTasks);
    on<OneTaskSaved>(_onSaveOneTask);
  }

  late final _logger = Logger('TasksBloc');

  final TasksRepo _repo;

  Future<void> _onLoadTasks(
      AllTasksLoaded event, Emitter<AllTasksState> emit) async {
    await emit.forEach(
      _repo.getAllTodos(),
      onData: (todos) => AllTasksState(cachedTasks: todos, showCompleted: true),
      // TODO(TrueFalseMary): подумать над обработкой onError
    );
    _logger.fine(() => '_onLoadTasks');
  }

  Future<void> _onCompleteOneTask(
      SwitchTaskCompletition event, Emitter<AllTasksState> emit) async {
    final selectedTodos = state.cachedTasks
        ?.map((todo) => todo.id == event.id
            ? todo.done
                ? todo.copyWith(isCompleted: false)
                : todo.copyWith(isCompleted: true)
            : todo)
        .toList();
    if (selectedTodos != null) {
      _repo.saveTodo(selectedTodos.firstWhere((todo) => todo.id == event.id));
      emit(
        state.copyWith(cachedTasks: selectedTodos),
      );
    }

    _logger.fine(() => '_onCompleteOneTask: ${event.id}');
  }

  Future<void> _onDeleteOneTask(
      OneTaskDeleted event, Emitter<AllTasksState> emit) async {
    final todos =
        state.cachedTasks?.where((todo) => !(todo.id == event.id)).toList();
    if (todos != null) {
      emit(state.copyWith(cachedTasks: todos));
      _logger.fine(() => '_onDeleteOneTask: ${event.id}');
    }
    _repo.deleteTodo(event.id);
  }

  Future<void> _onFilterAllTasks(
      AllTasksFilter event, Emitter<AllTasksState> emit) async {
    emit(
      state.copyWith(showCompleted: !state.showCompleted),
    );
    _logger.fine(() => '_onFilterAllTasks: ${state.showCompleted}');
  }

  FutureOr<void> _onSaveOneTask(
      OneTaskSaved event, Emitter<AllTasksState> emit) async {
    final tasks = state.cachedTasks;
    if (tasks != null) {
      final index = tasks.indexWhere((element) => element.id == event.task.id);

      final newTodos = List<TaskEntity>.from(tasks);

      final newTask = index != -1
          ? TaskEntity.fromTask(
              event.task,
              createdAt: tasks[index].createdAt,
              changedAt: DateTime.now(),
              lastUpdatedBy: 'lastUpdatedBy',
            )
          : TaskEntity.fromTask(
              event.task,
              createdAt: DateTime.now(),
              changedAt: DateTime.now(),
              lastUpdatedBy: 'lastUpdatedBy',
            );

      if (index != -1) {
        newTodos[index] = newTask;
      }

      emit(state.copyWith(cachedTasks: newTodos));
      _repo.saveTodo(newTask);
      _logger.fine(() => '_onSaveOneTask: ${event.task}');
    }
  }

  @override
  AllTasksState? fromJson(Map<String, dynamic> json) {
    try {
      final tasks =
          (json['list'] as List).map((e) => TaskEntity.fromJson(e)).toList();
      final showCompleted = json['showCompleted'] as bool;
      final revision = json['revision'] as int;
      _logger.fine(() => 'fromJson:');
      return state.copyWith(
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
    _logger.fine(() => 'toJson:');
    return {
      'list': state.cachedTasks?.map((e) => e.toJson()).toList(),
      'showCompleted': state.showCompleted,
      'revision': state.revision,
    };
  }
}
