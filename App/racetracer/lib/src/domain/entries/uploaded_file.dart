import 'package:json_annotation/json_annotation.dart';

part 'uploaded_file.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UploadedFile {
  final String alt;
  final String url;
  final String fullPath;
  final String markdown;

  UploadedFile({
    required this.alt,
    required this.url,
    required this.fullPath,
    required this.markdown,
  });

  factory UploadedFile.fromJson(Map<String, dynamic> json) =>
      _$UploadedFileFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UploadedFileToJson(this);
}
