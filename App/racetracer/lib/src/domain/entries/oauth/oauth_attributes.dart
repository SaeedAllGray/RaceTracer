import 'package:json_annotation/json_annotation.dart';

part 'oauth_attributes.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OauthAtrributes {
  final String clientId;
  final String clientSecret;
  final String issuer;
  final String discoveryUrl;

  OauthAtrributes(
      {required this.clientId,
      required this.clientSecret,
      required this.issuer,
      required this.discoveryUrl});

  factory OauthAtrributes.fromJson(Map<String, dynamic> json) =>
      _$OauthAtrributesFromJson(json);

  Map<String, dynamic> toJson() => _$OauthAtrributesToJson(this);
}
