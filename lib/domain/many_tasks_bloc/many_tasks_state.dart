part of 'many_tasks_bloc.dart';

sealed class ManyTasksState extends Equatable {
  const ManyTasksState();
}

final class ManyTasksInitial extends ManyTasksState {
  @override
  List<Object?> get props => [];
}

final class ManyTasksInProgress extends ManyTasksState {
  @override
  List<Object?> get props => [];
}

final class ManyTasksSuccess extends ManyTasksState {
  const ManyTasksSuccess({required this.todos, required this.showCompleted});

  final List<TodoEntity> todos;
  final bool showCompleted;

  @override
  List<Object?> get props => [todos, showCompleted];
}
