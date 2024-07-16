import 'package:json_annotation/json_annotation.dart';

part 'ros_node.g.dart';

@JsonSerializable()
class RosNode {
  final String name;

  RosNode({required this.name});
  factory RosNode.fromJson(Map<String, dynamic> json) =>
      _$RosNodeFromJson(json);

  Map<String, dynamic> toJson() => _$RosNodeToJson(this);
}
