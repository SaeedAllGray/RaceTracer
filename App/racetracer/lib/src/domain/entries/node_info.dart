import 'package:json_annotation/json_annotation.dart';

part 'node_info.g.dart';

@JsonSerializable()
class NodeInfo {
  final List<String> subscribing;
  final List<String> publishing;
  final List<String> services;

  NodeInfo({
    required this.subscribing,
    required this.publishing,
    required this.services,
  });

  factory NodeInfo.fromJson(Map<String, dynamic> json) =>
      _$NodeInfoFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$NodeInfoToJson(this);
}
