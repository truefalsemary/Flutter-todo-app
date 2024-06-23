
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/data/todo_entity.dart';
import 'package:flutter_todo_app/data/todo_repo.dart';

part 'one_todo_event.dart';

part 'one_todo_state.dart';

class OneTodoBloc extends Cubit<Todo> {
  OneTodoBloc(TodosRepo repo, Todo todo)
      : _repo = repo,
        super(todo);

  final TodosRepo _repo;

  void changeTodo(OneTodoSaved event, Emitter<OneTodoState> emit) {
    emit(OneTodoInProgress());
    _repo.saveTodo(event.todo);
    emit(OneTodoSuccess(event.todo));
  }

  // /// Подгружает уже существующую заметку в состояние.
  // void loadExistingTodo(
  //     OneTodoLoaded event, Emitter<OneTodoState> emit) {
  //   emit(OneTodoInProgress());
  //   emit(OneTodoSuccess(event.todo));
  // }
  //
  // /// Добавляет состояние пустой заметки.
  // /// Вызывается при создании новой заметки.
  // void emptyTodo(
  //     OneTodoEmptyLoaded event, Emitter<OneTodoState> emit) {
  //   emit(OneTodoEmpty());
  // }
}
