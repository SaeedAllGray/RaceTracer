import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:racetracer/src/infrastructure/datasources/git_remote/gitlab_data_source.dart';
import 'package:racetracer/src/presentation/constants/api_constant.dart';

class AuthRepository {
  final FlutterAppAuth appAuth = const FlutterAppAuth();
  final GitAuthLabDataSource datasource = GitAuthLabDataSource();
  Future<AuthorizationTokenResponse?> signInWithGitLab() async {
    final AuthorizationTokenResponse? result =
        await appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        ApiConstants.CLIENT_ID,
        ApiConstants.REDIRECT_URL,
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
        allowInsecureConnections: true,
      ),
    );
    print(result?.idToken);
    return result;
  }
}
