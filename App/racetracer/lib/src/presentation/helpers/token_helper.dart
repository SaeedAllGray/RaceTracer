import 'package:racetracer/src/domain/entries/token/git_token.dart';
import 'package:racetracer/src/infrastructure/datasources/local/local_storage_data_source.dart';

class TokenHelper {
  static String userToken = '';
  static GitToken? gitToken;

  static String get getToken {
    return userToken;
  }

  static Map<String, String> get getHeaderToken {
    return {'Authorization': 'Bearer $userToken'};

    // print(gitToken?.idToken);
    // return {"PRIVATE-TOKEN": "yxTqWxZF2_jWxpWQz5Va"};
    // return {'Cookie': '_gitlab_session=397a1cb4457e6bdbdbfd6f5f50890185;'};
  }

  static Future<void> setToken() async {
    gitToken = await LocalStorageDataSource().getGitToken();

    userToken = gitToken?.accessToken ?? '';
  }
}
