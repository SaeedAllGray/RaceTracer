import 'package:racetracer/src/infrastructure/datasources/local/local_data_source.dart';

class TokenHelper {
  static String userToken = '';

  static String get getToken {
    return userToken;
  }

  static Map<String, String> get getHeaderToken {
    return {'PRIVATE-TOKEN': 'gePyX2VcuPx1aZLSk8_K'};
  }

  static Future<void> setToken() async {
    userToken = await LocalDataSource().getToken() ?? '';
  }
}
