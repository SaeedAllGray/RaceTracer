// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'git_author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitAuthor _$GitAuthorFromJson(Map<String, dynamic> json) => GitAuthor(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      name: json['name'] as String,
      state: json['state'] as String,
      avatarUrl: json['avatar_url'] as String,
      webUrl: json['web_url'] as String,
    );

Map<String, dynamic> _$GitAuthorToJson(GitAuthor instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'state': instance.state,
      'avatar_url': instance.avatarUrl,
      'web_url': instance.webUrl,
    };
