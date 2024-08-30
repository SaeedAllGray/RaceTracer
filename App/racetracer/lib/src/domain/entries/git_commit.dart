import 'package:json_annotation/json_annotation.dart';

part 'git_commit.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GitCommit {
  final String id;
  final String shortId;
  @JsonKey(toJson: _dateTimeToJson, fromJson: _dateTimeFromJson)
  final DateTime createdAt;
  final String title;
  final String message;
  final String authorName;
  final String authorEmail;
  @JsonKey(toJson: _dateTimeToJson, fromJson: _dateTimeFromJson)
  final DateTime authoredDate;
  final String committerName;
  final String committerEmail;
  @JsonKey(toJson: _dateTimeToJson, fromJson: _dateTimeFromJson)
  final DateTime committedDate;
  final String webUrl;
  final int? projectId;

  GitCommit({
    required this.id,
    required this.shortId,
    required this.createdAt,
    required this.title,
    required this.message,
    required this.authorName,
    required this.authorEmail,
    required this.authoredDate,
    required this.committerName,
    required this.committerEmail,
    required this.committedDate,
    required this.webUrl,
    this.projectId,
  });

  // Custom fromJson for DateTime
  static DateTime _dateTimeFromJson(String date) =>
      DateTime.parse(date).toLocal();

  // Custom toJson for DateTime
  static String _dateTimeToJson(DateTime date) => date.toIso8601String();

  factory GitCommit.fromJson(Map<String, dynamic> json) =>
      _$GitCommitFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GitCommitToJson(this);
}
