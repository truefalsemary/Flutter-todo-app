import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

import '../data/importance_enum.dart';

class EpochDateTimeConverter implements JsonConverter<DateTime, int> {
  const EpochDateTimeConverter();

  @override
  DateTime fromJson(int json) => DateTime.fromMillisecondsSinceEpoch(json);

  @override
  int toJson(DateTime object) => object.millisecondsSinceEpoch;
}

class EpochDateTimeNullConverter implements JsonConverter<DateTime?, int?> {
  const EpochDateTimeNullConverter();

  @override
  DateTime? fromJson(int? json) =>
      json == null ? null : DateTime.fromMillisecondsSinceEpoch(json);

  @override
  int? toJson(DateTime? object) => object?.millisecondsSinceEpoch;
}

class ImportanceConverter implements JsonConverter<Importance, String> {
  const ImportanceConverter();

  @override
  Importance fromJson(String json) => Importance.fromString(json);

  @override
  String toJson(Importance object) => object.parseToString();
}

class ColorJsonConverter implements JsonConverter<Color?, String?> {
  const ColorJsonConverter();

  @override
  Color? fromJson(String? json) {
    return json == null ? null : hexToColor(json);
  }

  @override
  String? toJson(Color? color) {
    return color == null ? null : '#${color.value.toRadixString(16)}';
  }

  Color? hexToColor(String code) {
    return code == ''
        ? null
        : Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
