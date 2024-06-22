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

/// Переходит из состояния OneTodoInProgress для создания новой заметки
final class OneTodoEmpty extends OneTodoState {
  @override
  List<Object?> get props => [];
}

/// Переходит из состояния OneTodoInProgress
/// для редактирования уже существующей заметки
final class OneTodoSuccess extends OneTodoState {
  OneTodoSuccess(this.todo);

  final Todo todo;

  @override
  List<Object?> get props => [todo];
}
