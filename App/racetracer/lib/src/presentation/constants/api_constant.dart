// ignore_for_file: constant_identifier_names

class ApiConstants {
  // static const String baseUrl = 'http://192.168.178.48:8888';

  static const String baseUrl = 'http://10.208.1.77:8000';
  // static const String baseUrl = 'http://10.208.6.128:8888';
  // https://gitlab.fachschaften.org/api/v4/projects/448/repository/commits/5ddd9b2560d050b419b90388a2b84614949eb515/
  static const String gitUrl = 'https://gitlab.fachschaften.org/api/v4/';
  static const String projectUrl =
      'https://gitlab.fachschaften.org/-/project/448';
  static const String COMMITS = 'commits';
  static const String COMMENTS = 'comments';
  static const String PUSH = 'push';
  static const String FILES = 'files';
  static const String REPOSITORY = 'repository';
  static const String PROJECTS = 'projects';
  static const String UPLOADS = 'uploads';
  static const String TOKEN = 'token';
  static const String ROS = 'ros';
  static const String MESSAGE = 'message';
  static const String TESTSESSIONS = 'testsessions';
  static const String GIT = 'git';

  static const String CLIENT_ID =
      'eeb2fc864632a0d97159329e35207be737efc6df3c9f0ccc2dcb1a92197ca8dc';
  static const String CLIENT_SECTRET =
      'gloas-544cca91b6282ab73ceaf6ad6d597d31d54787085d95ac9b9fdda63d2cd24193';
  static const String REDIRECT_URL = 'racetracerapp://oauth/callback';
  static const String ISSUER = 'https://gitlab.fachschaften.org';
  static const String DISCOVERY_URL =
      'https://gitlab.fachschaften.org/.well-known/openid-configuration';
  static bool isTheFirstTimeAppLaunch = false;
}
