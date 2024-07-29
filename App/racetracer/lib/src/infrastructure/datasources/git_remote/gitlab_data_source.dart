import 'package:dio/dio.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:racetracer/src/presentation/constants/api_constant.dart';

class GitAuthLabDataSource {
  final Dio dio = Dio();

  // Future<void> refreshToken() async {
  //   await dio.post('${ApiConstants.ISSUER}/oauth/token', queryParameters: {""});
  // }
}
