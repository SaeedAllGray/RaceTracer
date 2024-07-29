import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:racetracer/src/presentation/constants/api_constant.dart';

class GitLabDataSource {
  final FlutterAppAuth appAuth = const FlutterAppAuth();

  Future<AuthorizationTokenResponse?> signInWithGitLab() async {
    try {
      print(1);
      final AuthorizationTokenResponse? result =
          await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          ApiConstants.CLIENT_ID, ApiConstants.REDIRECT_URL,
          clientSecret: ApiConstants.CLIENT_SECTRET,
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
          // issuer: ApiConstants.ISSUER,

          allowInsecureConnections: true,
        ),
      );

      return result;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
