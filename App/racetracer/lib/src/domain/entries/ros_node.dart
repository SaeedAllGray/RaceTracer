import 'package:json_annotation/json_annotation.dart';
import 'package:racetracer/src/domain/entries/node_info.dart';

part 'ros_node.g.dart';

@JsonSerializable()
class RosNode {
  @JsonKey(name: 'node_name')
  final String name;
  @JsonKey(name: 'node_info')
  NodeInfo? nodeInfo;

  RosNode({required this.name, this.nodeInfo});
  factory RosNode.fromJson(Map<String, dynamic> json) =>
      _$RosNodeFromJson(json);

  Map<String, dynamic> toJson() => _$RosNodeToJson(this);
}
