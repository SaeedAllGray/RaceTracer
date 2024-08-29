// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'git_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitFile _$GitFileFromJson(Map<String, dynamic> json) => GitFile(
      fileName: json['file_name'] as String,
      filePath: json['file_path'] as String,
      size: (json['size'] as num).toInt(),
      encoding: json['encoding'] as String,
      ref: json['ref'] as String,
      blobId: json['blob_id'] as String,
      commitId: json['commit_id'] as String,
      lastCommitId: json['last_commit_id'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$GitFileToJson(GitFile instance) => <String, dynamic>{
      'file_name': instance.fileName,
      'file_path': instance.filePath,
      'size': instance.size,
      'encoding': instance.encoding,
      'ref': instance.ref,
      'blob_id': instance.blobId,
      'commit_id': instance.commitId,
      'last_commit_id': instance.lastCommitId,
      'content': instance.content,
    };
