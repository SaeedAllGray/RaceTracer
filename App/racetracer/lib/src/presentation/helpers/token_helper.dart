import 'package:racetracer/src/domain/entries/token/git_token.dart';
import 'package:racetracer/src/infrastructure/datasources/local/local_data_source.dart';

class TokenHelper {
  static String userToken = '';

  static String get getToken {
    return userToken;
  }

  static Map<String, String> get getHeaderToken {
    print({'Authorization': 'Bearer $userToken'});
    return {'Authorization': 'Bearer $userToken'};
  }

  static Future<void> setToken() async {
    GitToken? gitToken = await LocalDataSource().getGitToken();
    print(gitToken?.accessToken);
    userToken = gitToken?.accessToken ?? '';
  }
}
