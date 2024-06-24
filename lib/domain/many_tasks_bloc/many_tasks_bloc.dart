import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/data/task_entity.dart';
import 'package:flutter_todo_app/data/tasks_repo.dart';

part 'many_tasks_event.dart';

part 'many_tasks_state.dart';

class ManyTasksBloc extends Bloc<ManyTasksEvent, ManyTasksState> {
  ManyTasksBloc(TasksRepo repo)
      : _repo = repo,
        super(ManyTasksInitial()) {
    on<ManyTasksLoaded>(_onLoadManyTasks);
    on<ManyTasksCompleted>(_onCompleteManyTasks);
    on<ManyTasksDeleted>(_onDeleteManyTasks);
    on<ManyTasksFilter>(_onFilterManyTasks);
    on<ManyTasksSaved>(_onSaveManyTasks);
  }

  final TasksRepo _repo;

  Future<void> _onLoadManyTasks(
      ManyTasksLoaded event, Emitter<ManyTasksState> emit) async {
    emit(ManyTasksInProgress());
    await emit.forEach(
      _repo.getAllTodos(),
      onData: (todos) => ManyTasksSuccess(todos: todos, showCompleted: true),
      // TODO(TrueFalseMary): подумать над обработкой onError
    );
  }

  Future<void> _onCompleteManyTasks(
      ManyTasksCompleted event, Emitter<ManyTasksState> emit) async {
    if (state is ManyTasksSuccess) {
      final selectedTodos = (state as ManyTasksSuccess)
          .todos
          .map((todo) => todo.id == event.todo.id
              ? todo.isCompleted
                  ? event.todo.copyWith(isCompleted: false)
                  : event.todo.copyWith(isCompleted: true)
              : todo)
          .toList();
      emit(ManyTasksSuccess(
        todos: selectedTodos,
        showCompleted: (state as ManyTasksSuccess).showCompleted,
      ));
    }
    _repo.saveTodo(event.todo.copyWith(isCompleted: true));
  }

  Future<void> _onDeleteManyTasks(
      ManyTasksDeleted event, Emitter<ManyTasksState> emit) async {
    if (state is ManyTasksSuccess) {
      final todos = (state as ManyTasksSuccess)
          .todos
          .where((todo) => !(todo.id == event.todo.id))
          .toList();
      emit(ManyTasksSuccess(
        todos: todos,
        showCompleted: (state as ManyTasksSuccess).showCompleted,
      ));
    }
    _repo.deleteTodo(event.todo.id);
  }

  Future<void> _onFilterManyTasks(
      ManyTasksFilter event, Emitter<ManyTasksState> emit) async {
    if (state is ManyTasksSuccess) {
      emit(
        ManyTasksSuccess(
          todos: (state as ManyTasksSuccess).todos,
          showCompleted: event.showCompleted,
        ),
      );
    }
  }

  FutureOr<void> _onSaveManyTasks(
      ManyTasksSaved event, Emitter<ManyTasksState> emit) async {
    if (state is ManyTasksSuccess) {
      final currentState = state as ManyTasksSuccess;

      final index = currentState.todos
          .indexWhere((element) => element.id == event.todo.id);

      final newTodos = List<TodoEntity>.from(currentState.todos);

      if (index != -1) {
        newTodos[index] = event.todo;
      } else {
        newTodos.add(event.todo);
      }
      emit(
        ManyTasksSuccess(
            todos: newTodos,
            showCompleted: (state as ManyTasksSuccess).showCompleted),
      );
      _repo.saveTodo(event.todo);
    }
  }
}
