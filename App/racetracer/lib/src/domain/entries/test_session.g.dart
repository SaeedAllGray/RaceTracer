// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestSession _$TestSessionFromJson(Map<String, dynamic> json) => TestSession(
      id: (json['id'] as num).toInt(),
      timestamp: TestSession._dateTimeFromJson(json['timestamp'] as String),
    );

Map<String, dynamic> _$TestSessionToJson(TestSession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timestamp': TestSession._dateTimeToJson(instance.timestamp),
    };
