// import 'package:freezed_annotation/freezed_annotation.dart';
//
// import '../../data/task_entity.dart';

// part 'tasks_state.freezed.dart';

// @freezed
// class TasksState with _$TasksState {
//   factory TasksState({
//     List<TaskEntity>? backendTasks,
//     List<TaskEntity>? cachedTasks,
//     required int revision,
//   }) = _$TasksState;
// }

part of 'tasks_bloc.dart';

sealed class AllTasksState extends Equatable {
  const AllTasksState();
}

final class TasksInitial extends AllTasksState {
  const TasksInitial();

  @override
  List<Object?> get props => [];
}

final class TasksInProgress extends AllTasksState {
  @override
  List<Object?> get props => [];
}

final class TasksSuccess extends AllTasksState {
  const TasksSuccess({
    required this.cachedTasks,
    required this.showCompleted,
     this.revision,
  });

  final List<TaskEntity> cachedTasks;
  final bool showCompleted;
  final int? revision;

  @override
  List<Object?> get props => [cachedTasks, showCompleted, revision];
}
