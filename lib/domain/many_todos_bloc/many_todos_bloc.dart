import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/data/todo_entity.dart';
import 'package:flutter_todo_app/data/todo_repo.dart';

part 'many_todo_event.dart';

part 'many_todo_state.dart';

class ManyTodosBloc extends Bloc<ManyTodosEvent, ManyTodosState> {
  ManyTodosBloc(TodosRepo repo)
      : _repo = repo,
        super(ManyTodosInitial()) {
    on<ManyTodosLoaded>(_onLoadManyTodos);
    on<ManyTodosCompleted>(_onCompleteManyTodos);
    on<ManyTodosDeleted>(_onDeleteManyTodos);
    on<ManyTodosFilter>(_onFilterManyTodos);
    on<ManyTodosSaved>(_onSaveManyTodos);
  }

  final TodosRepo _repo;

  Future<void> _onLoadManyTodos(
      ManyTodosLoaded event, Emitter<ManyTodosState> emit) async {
    emit(ManyTodosInProgress());
    await emit.forEach(
      _repo.getAllTodos(),
      onData: (todos) => ManyTodosSuccess(todos: todos, showCompleted: true),
      // TODO(TrueFalseMary): подумать над обработкой onError
    );
  }

  Future<void> _onCompleteManyTodos(
      ManyTodosCompleted event, Emitter<ManyTodosState> emit) async {
    if (state is ManyTodosSuccess) {
      final selectedTodos = (state as ManyTodosSuccess)
          .todos
          .map((todo) => todo.id == event.todo.id
              ? todo.isCompleted
                  ? event.todo.copyWith(isCompleted: false)
                  : event.todo.copyWith(isCompleted: true)
              : todo)
          .toList();
      emit(ManyTodosSuccess(
        todos: selectedTodos,
        showCompleted: (state as ManyTodosSuccess).showCompleted,
      ));
    }
    _repo.saveTodo(event.todo.copyWith(isCompleted: true));
  }

  Future<void> _onDeleteManyTodos(
      ManyTodosDeleted event, Emitter<ManyTodosState> emit) async {
    if (state is ManyTodosSuccess) {
      final todos = (state as ManyTodosSuccess)
          .todos
          .where((todo) => !(todo.id == event.todo.id))
          .toList();
      emit(ManyTodosSuccess(
        todos: todos,
        showCompleted: (state as ManyTodosSuccess).showCompleted,
      ));
    }
    _repo.deleteTodo(event.todo.id);
  }

  Future<void> _onFilterManyTodos(
      ManyTodosFilter event, Emitter<ManyTodosState> emit) async {
    if (state is ManyTodosSuccess) {
      emit(
        ManyTodosSuccess(
          todos: (state as ManyTodosSuccess).todos,
          showCompleted: event.showCompleted,
        ),
      );
    }
  }

  FutureOr<void> _onSaveManyTodos(
      ManyTodosSaved event, Emitter<ManyTodosState> emit) async {
    if (state is ManyTodosSuccess) {
      final newTodos = [...(state as ManyTodosSuccess).todos];
      newTodos.add(event.todo);
      emit(
        ManyTodosSuccess(
          todos: newTodos,
          showCompleted:  (state as ManyTodosSuccess).showCompleted
        ),
      );
      _repo.saveTodo(event.todo);
    }
  }
}
