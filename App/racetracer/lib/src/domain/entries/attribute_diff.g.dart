// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_diff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttributeDiff<T> _$AttributeDiffFromJson<T>(Map<String, dynamic> json) =>
    AttributeDiff<T>(
      attribute: json['attribute'] as String,
      newValue: json['new_value'],
      oldValue: json['old_value'],
    );

Map<String, dynamic> _$AttributeDiffToJson<T>(AttributeDiff<T> instance) =>
    <String, dynamic>{
      'attribute': instance.attribute,
      'new_value': instance.newValue,
      'old_value': instance.oldValue,
    };
