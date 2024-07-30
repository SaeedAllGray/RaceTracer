// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uploaded_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadedFile _$UploadedFileFromJson(Map<String, dynamic> json) => UploadedFile(
      alt: json['alt'] as String,
      url: json['url'] as String,
      fullPath: json['full_path'] as String,
      markdown: json['markdown'] as String,
    );

Map<String, dynamic> _$UploadedFileToJson(UploadedFile instance) =>
    <String, dynamic>{
      'alt': instance.alt,
      'url': instance.url,
      'full_path': instance.fullPath,
      'markdown': instance.markdown,
    };
