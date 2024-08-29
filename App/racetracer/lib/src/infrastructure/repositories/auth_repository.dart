import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:racetracer/src/domain/entries/oauth/oauth_attributes.dart';
import 'package:racetracer/src/domain/entries/token/git_token.dart';
import 'package:racetracer/src/infrastructure/datasources/git_remote/gitlab_data_source.dart';
import 'package:racetracer/src/infrastructure/datasources/local/local_data_source.dart';
import 'package:racetracer/src/presentation/constants/api_constant.dart';

class AuthRepository {
  final FlutterAppAuth appAuth = const FlutterAppAuth();
  final GitAuthsDataSource datasource = GitAuthsDataSource();
  final LocalDataSource localDataSource = LocalDataSource();

  Future<AuthorizationTokenResponse?> signInWithGitLab(
      OauthAtrributes oauth) async {
    final AuthorizationTokenResponse? result =
        await appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        oauth.clientId,
        ApiConstants.REDIRECT_URL,
        clientSecret: oauth.clientSecret,
        discoveryUrl: oauth.discoveryUrl,
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
    return result;
  }

  Future<GitToken?> refreshToken(OauthAtrributes oauth) async {
    final AuthorizationResponse? authRes = await datasource.requestAuthCode();
    final GitToken? gitToken = await localDataSource.getGitToken();
    if (authRes != null && gitToken != null) {
      final Response response =
          await datasource.refreshToken(authRes, gitToken.refreshToken, oauth);
      if (response.statusCode! < 400) {
        final GitToken gitToken = GitToken.fromJson(response.data);
        await localDataSource.saveGitToken(gitToken);
        return gitToken;
      }
    }
    return null;
  }

  // Future<GitToken?> loginWithGitlab() async {
  //   final AuthorizationResponse? authRes = await signInWithGitLab();
  //   print(authRes?.authorizationCode);
  //   print('9----------w-----------w');
  //   if (authRes != null) {
  //     Response response = await datasource.requestToken(authRes);
  //     if (response.statusCode! < 400) {
  //       final GitToken gitToken = GitToken.fromJson(response.data);
  //       print(response.data);
  //       return gitToken;
  //     }
  //   }
  // }
}
