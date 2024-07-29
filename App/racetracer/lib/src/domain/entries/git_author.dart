import 'package:json_annotation/json_annotation.dart';

part 'git_author.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GitAuthor {
  final int id;
  final String username;
  final String name;
  final String state;
  final String avatarUrl;
  final String webUrl;

  GitAuthor({
    required this.id,
    required this.username,
    required this.name,
    required this.state,
    required this.avatarUrl,
    required this.webUrl,
  });
  factory GitAuthor.fromJson(Map<String, dynamic> json) =>
      _$GitAuthorFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GitAuthorToJson(this);
}
