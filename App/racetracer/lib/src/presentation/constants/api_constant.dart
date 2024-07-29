// ignore_for_file: constant_identifier_names

class ApiConstants {
  // static const String baseUrl = 'http://192.168.178.48:8888';

  static const String baseUrl = 'http://10.208.6.128:8888';
  // https://gitlab.fachschaften.org/api/v4/projects/3564/repository/commits/5ddd9b2560d050b419b90388a2b84614949eb515/
  static const String gitUrl =
      'https://gitlab.fachschaften.org/api/v4/projects/3564/repository/';
  static const String TOKEN = 'token';
  static const String ROS = 'ros';
  static const String MESSAGE = 'message';
  static const String TESTSESSIONS = 'testsessions';
  static const String GIT = 'git';

  static const String CLIENT_ID =
      'eeb2fc864632a0d97159329e35207be737efc6df3c9f0ccc2dcb1a92197ca8dc';
  static const String CLIENT_SECTRET =
      'gloas-5cdff67246ad44d1d0ad83f53373e5f7376af46c7f05a8c40ad7bb793a9494cb';
  static const String REDIRECT_URL = 'racetracerapp://oauth/callback';
  static const String ISSUER = 'https://gitlab.fachschaften.org';
  static const String DISCOVERY_URL =
      'https://gitlab.fachschaften.org/.well-known/openid-configuration';
  static bool isTheFirstTimeAppLaunch = false;
}
