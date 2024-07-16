import 'package:json_annotation/json_annotation.dart';
import 'package:racetracer/src/domain/entries/topic_info.dart';

part 'ros_topic.g.dart';

@JsonSerializable()
class RosTopic {
  final String name;
  TopicInfo? topicInfo;

  RosTopic({
    this.topicInfo,
    required this.name,
  });

  factory RosTopic.fromJson(Map<String, dynamic> json) =>
      _$RosTopicFromJson(json);

  Map<String, dynamic> toJson() => _$RosTopicToJson(this);
}
