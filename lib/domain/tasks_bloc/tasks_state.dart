part of 'tasks_bloc.dart';

sealed class AllTasksState extends Equatable {
  const AllTasksState();
}

final class TasksInitial extends AllTasksState {
  @override
  List<Object?> get props => [];
}

final class TasksInProgress extends AllTasksState {
  @override
  List<Object?> get props => [];
}

final class TasksSuccess extends AllTasksState {
  const TasksSuccess({required this.tasks, required this.showCompleted});

  final List<TaskEntity> tasks;
  final bool showCompleted;

  @override
  List<Object?> get props => [tasks, showCompleted];
}
