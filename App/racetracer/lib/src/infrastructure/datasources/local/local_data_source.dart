import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalDataSource {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  Future<void> saveToken(AuthorizationTokenResponse authToken) async {
    await secureStorage.write(
        key: 'access_token', value: authToken.accessToken);
    await secureStorage.write(
        key: 'refresh_token', value: authToken.refreshToken);
  }

  Future<String?> getToken() async {
    final String? key = await secureStorage.read(key: 'access_token');
    return key;
  }

  Future<void> signOut() async {
    await secureStorage.delete(key: 'access_token');
    await secureStorage.delete(key: 'refresh_token');
  }
}
