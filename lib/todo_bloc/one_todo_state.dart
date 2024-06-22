part of 'one_todo_bloc.dart';

sealed class OneTodoState extends Equatable {}

final class OneTodoInitial extends OneTodoState {
  @override
  List<Object?> get props => [];
}

final class OneTodoInProgress extends OneTodoState {
  @override
  List<Object?> get props => [];
}

final class OneTodoSuccess extends OneTodoState {
  OneTodoSuccess(this.todo);

  final Todo todo;

  @override
  List<Object?> get props => [todo];
}
