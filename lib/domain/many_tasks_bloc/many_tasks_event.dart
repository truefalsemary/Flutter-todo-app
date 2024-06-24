part of 'many_tasks_bloc.dart';

sealed class ManyTasksEvent extends Equatable {
  const ManyTasksEvent();
}

final class ManyTasksLoaded extends ManyTasksEvent {
  const ManyTasksLoaded();

  @override
  List<Object?> get props => [];
}

final class ManyTasksCompleted extends ManyTasksEvent {
  const ManyTasksCompleted(this.todo);

  final TodoEntity todo;

  @override
  List<Object?> get props => [todo];
}

final class ManyTasksDeleted extends ManyTasksEvent {
  const ManyTasksDeleted(this.todo);

  final TodoEntity todo;

  @override
  List<Object?> get props => [todo];
}

final class ManyTasksFilter extends ManyTasksEvent {
  const ManyTasksFilter(this.showCompleted);

  final bool showCompleted;

  @override
  List<Object?> get props => [showCompleted];
}

final class ManyTasksSaved extends ManyTasksEvent {
  const ManyTasksSaved(this.todo);

  final TodoEntity todo;

  @override
  List<Object?> get props => [todo];
}
