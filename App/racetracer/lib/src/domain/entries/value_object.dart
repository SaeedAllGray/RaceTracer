import 'package:json_annotation/json_annotation.dart';

part 'value_object.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ValueObject {
  final String value;
  final String label;

  ValueObject({
    required this.value,
    required this.label,
  });

  factory ValueObject.fromJson(Map<String, dynamic> json) =>
      _$ValueObjectFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ValueObjectToJson(this);
}
