// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ros_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RosNode _$RosNodeFromJson(Map<String, dynamic> json) => RosNode(
      name: json['node_name'] as String,
      nodeInfo: json['node_info'] == null
          ? null
          : NodeInfo.fromJson(json['node_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RosNodeToJson(RosNode instance) => <String, dynamic>{
      'node_name': instance.name,
      'node_info': instance.nodeInfo,
    };
