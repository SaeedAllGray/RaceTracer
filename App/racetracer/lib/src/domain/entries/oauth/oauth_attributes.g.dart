// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oauth_attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OauthAtrributes _$OauthAtrributesFromJson(Map<String, dynamic> json) =>
    OauthAtrributes(
      clientId: json['client_id'] as String,
      clientSecret: json['client_secret'] as String,
      issuer: json['issuer'] as String,
      discoveryUrl: json['discovery_url'] as String,
    );

Map<String, dynamic> _$OauthAtrributesToJson(OauthAtrributes instance) =>
    <String, dynamic>{
      'client_id': instance.clientId,
      'client_secret': instance.clientSecret,
      'issuer': instance.issuer,
      'discovery_url': instance.discoveryUrl,
    };
