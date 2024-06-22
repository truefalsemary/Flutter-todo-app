part of 'many_todos_bloc.dart';

sealed class ManyTodosState extends Equatable {
  const ManyTodosState();
}

final class ManyTodosInitial extends ManyTodosState {
  @override
  List<Object?> get props => [];
}

final class ManyTodosInProgress extends ManyTodosState {
  @override
  List<Object?> get props => [];
}

final class ManyTodosSuccess extends ManyTodosState {
  const ManyTodosSuccess({required this.todos, required this.showCompleted});

  final List<Todo> todos;
  final bool showCompleted;

  @override
  List<Object?> get props => [todos, showCompleted];
}
