import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/todo_entity.dart';
import 'package:flutter_todo_app/todo_repo.dart';

part 'one_todo_event.dart';

part 'one_todo_state.dart';

class OneTodoBloc extends Bloc<OneTodoEvent, OneTodoState> {
  OneTodoBloc(TodosRepo repo)
      : _repo = repo,
        super(OneTodoInitial()) {
    on<OneTodoSaved>(_onSaveTodo);
  }

  final TodosRepo _repo;

  FutureOr<void> _onSaveTodo(OneTodoSaved event, Emitter<OneTodoState> emit) {
    emit(OneTodoInProgress());

    _repo.saveTodo(event.todo);
    emit(OneTodoSuccess(event.todo));
  }
}
