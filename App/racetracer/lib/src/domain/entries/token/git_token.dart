import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'git_token.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GitToken {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final String idToken;

  GitToken({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.idToken,
  });

  factory GitToken.fromAuthResponce(AuthorizationTokenResponse authRes) =>
      GitToken(
          accessToken: authRes.accessToken!,
          refreshToken: authRes.refreshToken!,
          tokenType: authRes.tokenType!,
          idToken: authRes.idToken!);

  factory GitToken.fromJson(Map<String, dynamic> json) =>
      _$GitTokenFromJson(json);

  Map<String, dynamic> toJson() => _$GitTokenToJson(this);
}
