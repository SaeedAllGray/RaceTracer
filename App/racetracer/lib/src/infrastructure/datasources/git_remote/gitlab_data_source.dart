import 'package:dio/dio.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:racetracer/src/domain/entries/oauth/oauth_attributes.dart';
import 'package:racetracer/src/presentation/constants/api_constant.dart';

class GitAuthsDataSource {
  final FlutterAppAuth appAuth = const FlutterAppAuth();
  final Dio dio = Dio();

  Future<AuthorizationResponse?> requestAuthCode() async {
    final AuthorizationRequest request = AuthorizationRequest(
      ApiConstants.CLIENT_ID,
      ApiConstants.REDIRECT_URL,
      discoveryUrl: ApiConstants.DISCOVERY_URL,
      scopes: [
        'openid',
        'profile',
        'email',
        'api',
        'read_api',
        'read_user',
        'create_runner',
        'manage_runner',
        'k8s_proxy',
        'read_repository',
        'write_repository',
        'read_registry',
        'write_registry',
        'read_observability',
        'write_observability',
        'ai_features',
        'sudo',
        'admin_mode',
        'read_service_ping'
      ],
      // allowInsecureConnections: true,
    );
    final AuthorizationResponse? result = await appAuth.authorize(request);

    return result;
  }

  Future<Response> requestToken(AuthorizationResponse authRes) async {
    dio.interceptors.add(PrettyDioLogger());
    Response response =
        await dio.post('${ApiConstants.ISSUER}/oauth/token', queryParameters: {
      'client_id': ApiConstants.CLIENT_ID,
      'code': authRes.authorizationCode,
      'grant_type': 'authorization_code',
      'client_secret': ApiConstants.CLIENT_SECTRET,
      'redirect_uri': ApiConstants.REDIRECT_URL,
      'code_verifier': authRes.codeVerifier,
    });
    return response;
  }

  Future<Response> refreshToken(AuthorizationResponse authRes,
      String refreshToken, OauthAtrributes oauth) async {
    dio.interceptors.add(PrettyDioLogger());
    Response response =
        await dio.post('${ApiConstants.ISSUER}/oauth/token', queryParameters: {
      'client_id': oauth.clientId,
      'refresh_token': refreshToken,
      'grant_type': 'refresh_token',
      'client_secret': oauth.clientSecret,
      'redirect_uri': ApiConstants.REDIRECT_URL,
      'code_verifier': authRes.codeVerifier,
    });
    return response;
  }
}
