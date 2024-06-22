part of 'one_todo_bloc.dart';

sealed class OneTodoEvent extends Equatable {}

final class OneTodoSaved extends OneTodoEvent {
  OneTodoSaved(this.todo);

  final Todo todo;

  @override
  List<Object?> get props => [todo];
}
