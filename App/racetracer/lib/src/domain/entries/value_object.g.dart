// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'value_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValueObject _$ValueObjectFromJson(Map<String, dynamic> json) => ValueObject(
      value: json['value'],
      label: json['label'] as String?,
      topic: json['topic'] as String,
      valueKey: json['value_key'] as String?,
    );

Map<String, dynamic> _$ValueObjectToJson(ValueObject instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('value', instance.value);
  writeNotNull('label', instance.label);
  val['topic'] = instance.topic;
  writeNotNull('value_key', instance.valueKey);
  return val;
}
