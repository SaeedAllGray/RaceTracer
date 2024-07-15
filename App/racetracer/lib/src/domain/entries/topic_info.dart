import 'package:json_annotation/json_annotation.dart';

part 'topic_info.g.dart';

@JsonSerializable()
class TopicInfo {
  final String type;
  final List<String> subscribers;
  final List<String> publishers;

  TopicInfo({
    required this.type,
    required this.subscribers,
    required this.publishers,
  });

  factory TopicInfo.fromJson(Map<String, dynamic> json) =>
      _$TopicInfoFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TopicInfoToJson(this);
}
