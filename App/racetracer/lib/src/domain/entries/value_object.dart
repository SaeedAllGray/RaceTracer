import 'package:json_annotation/json_annotation.dart';

part 'value_object.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ValueObject {
  @JsonKey(includeIfNull: false)
  dynamic value;
  @JsonKey(includeIfNull: false)
  final String? label;
  final String topic;
  @JsonKey(includeIfNull: false)
  final String? valueKey;
  ValueObject({
    this.value,
    this.label,
    required this.topic,
    this.valueKey,
  });

  factory ValueObject.fromJson(Map<String, dynamic> json) =>
      _$ValueObjectFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ValueObjectToJson(this);
}
