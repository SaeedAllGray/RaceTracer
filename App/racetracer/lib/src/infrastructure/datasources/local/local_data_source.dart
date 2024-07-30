import 'dart:convert';

import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:racetracer/src/domain/entries/token/git_token.dart';

class LocalDataSource {
  //TODO: rename this later
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  Future<void> saveToken(AuthorizationTokenResponse authToken) async {
    await secureStorage.write(
        key: 'access_token', value: authToken.accessToken);
    await secureStorage.write(
        key: 'refresh_token', value: authToken.refreshToken);
    await secureStorage.write(
        key: 'expiration_date', value: authToken.toString());
  }

  Future<GitToken?> getGitToken() async {
    GitToken? gitToken;
    String? tokenString = await secureStorage.read(key: 'git_token');
    if (tokenString != null) {
      print(tokenString);
      Map<String, dynamic> tokenJson = json.decode(tokenString);
      print('af sus');
      gitToken = GitToken.fromJson(tokenJson);
      return gitToken;
    }
    return gitToken;
  }

  Future<void> saveGitToken(GitToken gitToken) async {
    await secureStorage.write(
        key: 'git_token', value: json.encode(gitToken.toJson()));
  }

  // Future<String?> getToken() async {
  //   final String? key = await secureStorage.read(key: 'access_token');
  //   return key;
  // }

  // Future<String?> getRefreshToken() async {
  //   final String? key = await secureStorage.read(key: 'refresh_token');

  //   return key;
  // }

  // Future<String?> getExpirationDate() async {
  //   final String? key = await secureStorage.read(key: 'expiration_date');
  //   return key;
  // }

  Future<void> signOut() async {
    await secureStorage.delete(key: 'git_token');
    await secureStorage.deleteAll();
  }
}
