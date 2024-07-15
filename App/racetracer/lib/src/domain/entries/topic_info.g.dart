// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicInfo _$TopicInfoFromJson(Map<String, dynamic> json) => TopicInfo(
      type: json['type'] as String,
      subscribers: (json['subscribers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      publishers: (json['publishers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$TopicInfoToJson(TopicInfo instance) => <String, dynamic>{
      'type': instance.type,
      'subscribers': instance.subscribers,
      'publishers': instance.publishers,
    };
