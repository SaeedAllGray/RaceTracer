// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ros_topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RosTopic _$RosTopicFromJson(Map<String, dynamic> json) => RosTopic(
      topicInfo: json['topicInfo'] == null
          ? null
          : TopicInfo.fromJson(json['topicInfo'] as Map<String, dynamic>),
      name: json['name'] as String,
    );

Map<String, dynamic> _$RosTopicToJson(RosTopic instance) => <String, dynamic>{
      'name': instance.name,
      'topicInfo': instance.topicInfo,
    };
