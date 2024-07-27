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
  static const String DOCTOR = 'doctors';
  static const String PATIENT = 'patient';
  static const String PATIENT_ID = 'patient_id';
  static const String DOCTOR_ID = 'doctor_id';

  static bool isTheFirstTimeAppLaunch = false;
}
