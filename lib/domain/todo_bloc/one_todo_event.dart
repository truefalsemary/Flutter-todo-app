part of 'one_todo_bloc.dart';

sealed class OneTodoEvent extends Equatable {}

final class OneTodoSaved extends OneTodoEvent {
  OneTodoSaved(this.todo);

  final Todo todo;

  @override
  List<Object?> get props => [todo];
}

final class OneTodoLoaded extends OneTodoEvent {
  OneTodoLoaded(this.todo);

  final Todo todo;

  @override
  List<Object?> get props => [todo];
}

final class OneTodoEmptyLoaded extends OneTodoEvent {
  OneTodoEmptyLoaded();

  @override
  List<Object?> get props => [];
}
