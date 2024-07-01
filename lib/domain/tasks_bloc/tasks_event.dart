part of 'tasks_bloc.dart';

sealed class ManyTasksEvent extends Equatable {
  const ManyTasksEvent();
}

final class AllTasksLoaded extends ManyTasksEvent {
  const AllTasksLoaded();

  @override
  List<Object?> get props => [];
}

final class SwitchTaskCompletition extends ManyTasksEvent {
  const SwitchTaskCompletition(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

final class OneTaskDeleted extends ManyTasksEvent {
  const OneTaskDeleted(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

final class AllTasksFilter extends ManyTasksEvent {
  const AllTasksFilter();

  @override
  List<Object?> get props => [];
}

final class OneTaskSaved extends ManyTasksEvent {
  const OneTaskSaved(this.task);

  final Task task;

  @override
  List<Object?> get props => [task];
}
