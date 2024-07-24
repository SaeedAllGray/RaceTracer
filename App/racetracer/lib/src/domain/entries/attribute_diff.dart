import 'package:json_annotation/json_annotation.dart';

part 'attribute_diff.g.dart';

@JsonSerializable()
class AttributeDiff<T> {
  final String attribute;
  @JsonKey(name: 'new_value')
  final dynamic newValue;
  @JsonKey(name: 'old_value')
  final dynamic oldValue;

  AttributeDiff({
    required this.attribute,
    required this.newValue,
    required this.oldValue,
  });

  factory AttributeDiff.fromJson(Map<String, dynamic> json) =>
      _$AttributeDiffFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AttributeDiffToJson(this);
}
