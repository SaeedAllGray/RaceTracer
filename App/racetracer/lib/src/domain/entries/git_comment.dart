import 'package:json_annotation/json_annotation.dart';
import 'package:racetracer/src/domain/entries/git_author.dart';

part 'git_comment.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GitComment {
  final String note;
  final String? path;
  final int? line;
  final GitAuthor author;
  @JsonKey(toJson: _dateTimeToJson, fromJson: _dateTimeFromJson)
  final DateTime createdAt;

  GitComment({
    required this.author,
    required this.note,
    required this.path,
    required this.line,
    required this.createdAt,
  });

  static DateTime _dateTimeFromJson(String date) =>
      DateTime.parse(date).toLocal();

  // Custom toJson for DateTime
  static String _dateTimeToJson(DateTime date) => date.toIso8601String();

  factory GitComment.fromJson(Map<String, dynamic> json) =>
      _$GitCommentFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GitCommentToJson(this);
}
