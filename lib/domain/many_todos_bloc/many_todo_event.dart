part of 'many_todos_bloc.dart';

sealed class ManyTodosEvent extends Equatable {
  const ManyTodosEvent();
}

final class ManyTodosLoaded extends ManyTodosEvent {
  const ManyTodosLoaded();

  @override
  List<Object?> get props => [];
}

final class ManyTodosCompleted extends ManyTodosEvent {
  const ManyTodosCompleted(this.todo);

  final TodoEntity todo;

  @override
  List<Object?> get props => [todo];
}

final class ManyTodosDeleted extends ManyTodosEvent {
  const ManyTodosDeleted(this.todo);

  final TodoEntity todo;

  @override
  List<Object?> get props => [todo];
}

final class ManyTodosFilter extends ManyTodosEvent {
  const ManyTodosFilter(this.showCompleted);

  final bool showCompleted;

  @override
  List<Object?> get props => [showCompleted];
}

final class ManyTodosSaved extends ManyTodosEvent {
  const ManyTodosSaved(this.todo);

  final TodoEntity todo;

  @override
  List<Object?> get props => [todo];
}
