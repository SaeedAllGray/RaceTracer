import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'git_file.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GitFile {
  final String fileName;
  final String filePath;
  final int size;
  final String encoding;
  final String ref;
  final String blobId;
  final String commitId;
  final String lastCommitId;
  final String content;

  GitFile({
    required this.fileName,
    required this.filePath,
    required this.size,
    required this.encoding,
    required this.ref,
    required this.blobId,
    required this.commitId,
    required this.lastCommitId,
    required this.content,
  });

  factory GitFile.fromJson(Map<String, dynamic> json) =>
      _$GitFileFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GitFileToJson(this);
}
