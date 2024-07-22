// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NodeInfo _$NodeInfoFromJson(Map<String, dynamic> json) => NodeInfo(
      subscribing: (json['subscribing'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      publishing: (json['publishing'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      services:
          (json['services'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$NodeInfoToJson(NodeInfo instance) => <String, dynamic>{
      'subscribing': instance.subscribing,
      'publishing': instance.publishing,
      'services': instance.services,
    };
