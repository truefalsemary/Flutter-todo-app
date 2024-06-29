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
  const SwitchTaskCompletition(this.task);

  final TaskEntity task;

  @override
  List<Object?> get props => [task];
}

final class OneTaskDeleted extends ManyTasksEvent {
  const OneTaskDeleted(this.task);

  final TaskEntity task;

  @override
  List<Object?> get props => [task];
}

final class AllTasksFilter extends ManyTasksEvent {
  const AllTasksFilter(this.showCompleted);

  final bool showCompleted;

  @override
  List<Object?> get props => [showCompleted];
}

final class OneTaskSaved extends ManyTasksEvent {
  const OneTaskSaved(this.task);

  final TaskEntity task;

  @override
  List<Object?> get props => [task];
}
