import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/data/task_entity.dart';
import 'package:flutter_todo_app/data/tasks_repo.dart';

part 'tasks_event.dart';

part 'tasks_state.dart';

class TasksBloc extends Bloc<ManyTasksEvent, AllTasksState> {
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
      onData: (todos) => TasksSuccess(tasks: todos, showCompleted: true),
      // TODO(TrueFalseMary): подумать над обработкой onError
    );
  }

  Future<void> _onCompleteOneTask(
      SwitchTaskCompletition event, Emitter<AllTasksState> emit) async {
    if (state is TasksSuccess) {
      final selectedTodos = (state as TasksSuccess)
          .tasks
          .map((todo) => todo.id == event.task.id
              ? todo.isCompleted
                  ? event.task.copyWith(isCompleted: false)
                  : event.task.copyWith(isCompleted: true)
              : todo)
          .toList();
      emit(TasksSuccess(
        tasks: selectedTodos,
        showCompleted: (state as TasksSuccess).showCompleted,
      ));
    }
    _repo.saveTodo(event.task.copyWith(isCompleted: true));
  }

  Future<void> _onDeleteOneTask(
      OneTaskDeleted event, Emitter<AllTasksState> emit) async {
    if (state is TasksSuccess) {
      final todos = (state as TasksSuccess)
          .tasks
          .where((todo) => !(todo.id == event.task.id))
          .toList();
      emit(TasksSuccess(
        tasks: todos,
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
          tasks: (state as TasksSuccess).tasks,
          showCompleted: event.showCompleted,
        ),
      );
    }
  }

  FutureOr<void> _onSaveOneTask(
      OneTaskSaved event, Emitter<AllTasksState> emit) async {
    if (state is TasksSuccess) {
      final currentState = state as TasksSuccess;

      final index = currentState.tasks
          .indexWhere((element) => element.id == event.task.id);

      final newTodos = List<TaskEntity>.from(currentState.tasks);

      if (index != -1) {
        newTodos[index] = event.task;
      } else {
        newTodos.add(event.task);
      }
      emit(
        TasksSuccess(
            tasks: newTodos,
            showCompleted: (state as TasksSuccess).showCompleted),
      );
      _repo.saveTodo(event.task);
    }
  }
}
