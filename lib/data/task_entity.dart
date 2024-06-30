import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/data/importance_enum.dart';
import 'package:flutter_todo_app/data/task.dart';
import 'package:json_annotation/json_annotation.dart';

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
  final String importance;

  @ColorJsonConverter()
  final Color? color;

  @EpochDateTimeConverter()
  final DateTime? deadline;

  final bool done;

  @EpochDateTimeConverter()
  final DateTime createdAt;

  @EpochDateTimeConverter()
  final DateTime changedAt;

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
        importance: task.importance.parseToString(),
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
        importance: Importance.fromString(importance),
        deadline: deadline,
        done: done,
      );

  TaskEntity copyWith({
    String? description,
    String? priority,
    DateTime? deadline,
    bool? isCompleted,
    bool? forceNullDeadline,
    DateTime? createdAt,
    DateTime? changedAt,
    String? lastUpdatedBy,
  }) {
    return TaskEntity(
      id: id,
      text: description ?? text,
      importance: priority ?? importance,
      deadline: (forceNullDeadline ?? false) ? null : deadline ?? deadline,
      done: isCompleted ?? done,
      createdAt: createdAt ?? this.createdAt,
      changedAt: changedAt ?? this.changedAt,
      lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
    );
  }

  @override
  String toString() {
    return 'Todo{id: $id, description: $text, priority: $importance, deadline: $deadline, isCompleted: $done}';
  }
}

class ColorJsonConverter implements JsonConverter<Color?, String> {
  const ColorJsonConverter();

  @override
  Color? fromJson(String json) {
    return hexToColor(json);
  }

  @override
  String toJson(Color? color) {
    return color == null ? '' : '#${color.value.toRadixString(16)}';
  }

  Color? hexToColor(String code) {
    return code == ''
        ? null
        : Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}

class EpochDateTimeConverter implements JsonConverter<DateTime?, int?> {
  const EpochDateTimeConverter();

  @override
  DateTime? fromJson(int? json) =>
      json == null ? null : DateTime.fromMillisecondsSinceEpoch(json);

  @override
  int? toJson(DateTime? object) => object?.millisecondsSinceEpoch;
}
