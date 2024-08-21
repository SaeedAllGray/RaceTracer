// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'git_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitToken _$GitTokenFromJson(Map<String, dynamic> json) => GitToken(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      tokenType: json['token_type'] as String,
      idToken: json['id_token'] as String,
    );

Map<String, dynamic> _$GitTokenToJson(GitToken instance) => <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'token_type': instance.tokenType,
      'id_token': instance.idToken,
    };
