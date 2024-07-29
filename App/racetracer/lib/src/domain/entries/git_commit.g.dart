// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'git_commit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitCommit _$GitCommitFromJson(Map<String, dynamic> json) => GitCommit(
      id: json['id'] as String,
      shortId: json['short_id'] as String,
      createdAt: GitCommit._dateTimeFromJson(json['created_at'] as String),
      title: json['title'] as String,
      message: json['message'] as String,
      authorName: json['author_name'] as String,
      authorEmail: json['author_email'] as String,
      authoredDate:
          GitCommit._dateTimeFromJson(json['authored_date'] as String),
      committerName: json['committer_name'] as String,
      committerEmail: json['committer_email'] as String,
      committedDate:
          GitCommit._dateTimeFromJson(json['committed_date'] as String),
      webUrl: json['web_url'] as String,
      projectId: (json['project_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GitCommitToJson(GitCommit instance) => <String, dynamic>{
      'id': instance.id,
      'short_id': instance.shortId,
      'created_at': GitCommit._dateTimeToJson(instance.createdAt),
      'title': instance.title,
      'message': instance.message,
      'author_name': instance.authorName,
      'author_email': instance.authorEmail,
      'authored_date': GitCommit._dateTimeToJson(instance.authoredDate),
      'committer_name': instance.committerName,
      'committer_email': instance.committerEmail,
      'committed_date': GitCommit._dateTimeToJson(instance.committedDate),
      'web_url': instance.webUrl,
      'project_id': instance.projectId,
    };
