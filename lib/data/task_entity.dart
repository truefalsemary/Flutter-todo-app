import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/data/importance_enum.dart';
import 'package:flutter_todo_app/data/task.dart';
import 'package:json_annotation/json_annotation.dart';

import '../utils/json_converters.dart';

part 'task_entity.g.dart';

@JsonSerializable()
class TaskEntity extends Equatable {
  const TaskEntity({
    required this.id,
    required this.text,
    required this.importance,
    this.deadline,
    this.done = false,
    this.color,
    required this.createdAt,
    required this.changedAt,
    required this.lastUpdatedBy,
  });

  final String id;
  final String text;

  @ImportanceConverter()
  final Importance importance;

  @ColorJsonConverter()
  final Color? color;

  @EpochDateTimeConverter()
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @EpochDateTimeConverter()
  @JsonKey(name: 'changed_at')
  final DateTime changedAt;

  @EpochDateTimeNullConverter()
  final DateTime? deadline;

  final bool done;

  @JsonKey(name: 'last_updated_by')
  final String lastUpdatedBy;

  factory TaskEntity.fromTask(
    Task task, {
    required DateTime createdAt,
    required DateTime changedAt,
    required String lastUpdatedBy,
  }) =>
      TaskEntity(
        id: task.id,
        text: task.text,
        importance: task.importance,
        deadline: task.deadline,
        done: task.done,
        createdAt: createdAt,
        changedAt: changedAt,
        lastUpdatedBy: lastUpdatedBy,
      );

  factory TaskEntity.fromJson(Map<String, dynamic> json) =>
      _$TaskEntityFromJson(json);

  @override
  List<Object?> get props => [
        id,
        text,
        importance,
        deadline,
        done,
        createdAt,
        changedAt,
        lastUpdatedBy,
      ];

  Map<String, dynamic> toJson() => _$TaskEntityToJson(this);

  Task toTask() => Task(
        id: id,
        text: text,
        importance: importance,
        deadline: deadline,
        done: done,
      );

  TaskEntity copyWith({
    String? text,
    Importance? importance,
    DateTime? deadline,
    bool? done,
    bool? forceNullDeadline,
    DateTime? createdAt,
    DateTime? changedAt,
    String? lastUpdatedBy,
  }) {
    return TaskEntity(
      id: id,
      text: text ?? this.text,
      importance: importance ?? this.importance,
      deadline: (forceNullDeadline ?? false) ? null : deadline ?? this.deadline,
      done: done ?? this.done,
      createdAt: createdAt ?? this.createdAt,
      changedAt: changedAt ?? this.changedAt,
      lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
    );
  }

  @override
  String toString() {
    return 'TaskEntity{id: $id, description: $text, priority: $importance, deadline: $deadline, isCompleted: $done}';
  }
}
