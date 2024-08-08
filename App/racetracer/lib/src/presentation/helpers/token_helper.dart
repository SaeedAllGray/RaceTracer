import 'package:racetracer/src/domain/entries/token/git_token.dart';
import 'package:racetracer/src/infrastructure/datasources/local/local_data_source.dart';

class TokenHelper {
  static String userToken = '';
  static GitToken? gitToken;

  static String get getToken {
    return userToken;
  }

  static Map<String, String> get getHeaderToken {
    return {'Authorization': 'Bearer $userToken'};
  }

  static Map<String, String> get getHeaderCookies {
    print(gitToken?.idToken);
    return {'Cookie': 'event_filter=all; _gitlab_session=${gitToken?.idToken}'};
  }

  static Future<void> setToken() async {
    gitToken = await LocalDataSource().getGitToken();

    userToken = gitToken?.accessToken ?? '';
  }
}
