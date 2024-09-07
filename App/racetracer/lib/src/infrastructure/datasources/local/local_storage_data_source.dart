import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:racetracer/src/domain/entries/oauth/oauth_attributes.dart';
import 'package:racetracer/src/domain/entries/token/git_token.dart';

class LocalStorageDataSource {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<void> saveOauth(OauthAtrributes oauth) async {
    await secureStorage.write(key: 'oauth', value: json.encode(oauth.toJson()));
  }

  Future<OauthAtrributes?> getOauth() async {
    OauthAtrributes? oauthAtrributes;
    String? oauthString = await secureStorage.read(key: 'oauth');
    if (oauthString != null) {
      Map<String, dynamic> tokenJson = json.decode(oauthString);
      oauthAtrributes = OauthAtrributes.fromJson(tokenJson);
      return oauthAtrributes;
    }
    return oauthAtrributes;
  }

  Future<GitToken?> getGitToken() async {
    GitToken? gitToken;
    String? tokenString = await secureStorage.read(key: 'git_token');
    if (tokenString != null) {
      Map<String, dynamic> tokenJson = json.decode(tokenString);
      gitToken = GitToken.fromJson(tokenJson);
      return gitToken;
    }
    return gitToken;
  }

  Future<void> saveGitToken(GitToken gitToken) async {
    await secureStorage.write(
        key: 'git_token', value: json.encode(gitToken.toJson()));
  }

  Future<String?> getToken() async {
    final String? key = await secureStorage.read(key: 'access_token');
    return key;
  }

  Future<String?> getHostIP() async {
    final String? key = await secureStorage.read(key: 'host_ip');

    return key;
  }

  Future<void> saveHostIP(String hostip) async {
    await secureStorage.write(key: 'host_ip', value: hostip);
  }

  Future<String?> getProjectID() async {
    final String? key = await secureStorage.read(key: 'project_id');

    return key;
  }

  Future<void> saveProjectID(String projectID) async {
    await secureStorage.write(key: 'project_id', value: projectID);
  }

  Future<String?> getLink() async {
    final String? key = await secureStorage.read(key: 'link');

    return key;
  }

  Future<void> saveLink(String link) async {
    await secureStorage.write(key: 'link', value: link);
  }

  Future<void> signOut() async {
    await secureStorage.delete(key: 'git_token');
    await secureStorage.delete(key: 'host_ip');
    await secureStorage.deleteAll();
  }
}
