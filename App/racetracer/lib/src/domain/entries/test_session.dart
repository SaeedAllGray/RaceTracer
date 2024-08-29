import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';

part 'test_session.g.dart';

@JsonSerializable()
class TestSession {
  final int id;
  @JsonKey(toJson: _dateTimeToJson, fromJson: _dateTimeFromJson)
  final DateTime timestamp;

  TestSession({required this.id, required this.timestamp});

  static DateTime _dateTimeFromJson(String date) =>
      DateTime.parse(date).toLocal();

  // Custom toJson for DateTime
  static String _dateTimeToJson(DateTime date) => date.toIso8601String();

  factory TestSession.fromJson(Map<String, dynamic> json) =>
      _$TestSessionFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TestSessionToJson(this);
}
