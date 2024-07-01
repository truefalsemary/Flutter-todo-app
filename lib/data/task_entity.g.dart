// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskEntity _$TaskEntityFromJson(Map<String, dynamic> json) => TaskEntity(
      id: json['id'] as String,
      text: json['text'] as String,
      importance:
          const ImportanceConverter().fromJson(json['importance'] as String),
      deadline: const EpochDateTimeNullConverter()
          .fromJson((json['deadline'] as num?)?.toInt()),
      done: json['done'] as bool? ?? false,
      color: const ColorJsonConverter().fromJson(json['color'] as String?),
      createdAt: const EpochDateTimeConverter()
          .fromJson((json['created_at'] as num).toInt()),
      changedAt: const EpochDateTimeConverter()
          .fromJson((json['changed_at'] as num).toInt()),
      lastUpdatedBy: json['last_updated_by'] as String,
    );

Map<String, dynamic> _$TaskEntityToJson(TaskEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'importance': const ImportanceConverter().toJson(instance.importance),
      'color': const ColorJsonConverter().toJson(instance.color),
      'created_at': const EpochDateTimeConverter().toJson(instance.createdAt),
      'changed_at': const EpochDateTimeConverter().toJson(instance.changedAt),
      'deadline': const EpochDateTimeNullConverter().toJson(instance.deadline),
      'done': instance.done,
      'last_updated_by': instance.lastUpdatedBy,
    };
