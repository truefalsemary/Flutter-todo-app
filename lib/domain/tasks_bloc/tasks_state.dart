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

final class AllTasksState {
  const AllTasksState({
    this.cachedTasks,
    this.showCompleted = true,
    this.revision = 0,
  });

  final List<TaskEntity>? cachedTasks;
  final bool showCompleted;
  final int revision;

  AllTasksState copyWith({
    List<TaskEntity>? cachedTasks,
    bool? showCompleted,
    int? revision,
  }) {
    return AllTasksState(
      cachedTasks: cachedTasks ?? this.cachedTasks,
      showCompleted: showCompleted ?? this.showCompleted,
      revision: revision ?? this.revision,
    );
  }

  List<Object?> get props => [cachedTasks, showCompleted, revision];
}
