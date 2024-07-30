// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'git_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitComment _$GitCommentFromJson(Map<String, dynamic> json) => GitComment(
      author: GitAuthor.fromJson(json['author'] as Map<String, dynamic>),
      note: json['note'] as String,
      path: json['path'] as String?,
      line: (json['line'] as num?)?.toInt(),
      createdAt: GitComment._dateTimeFromJson(json['created_at'] as String),
    );

Map<String, dynamic> _$GitCommentToJson(GitComment instance) =>
    <String, dynamic>{
      'note': instance.note,
      'path': instance.path,
      'line': instance.line,
      'author': instance.author,
      'created_at': GitComment._dateTimeToJson(instance.createdAt),
    };
