import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:racetracer/src/presentation/constants/api_constant.dart';

class GitDiffDataSource {
  Dio dio = Dio();

  FutureOr<dynamic> getAttributeDiffs() async {
    dio.interceptors.add(PrettyDioLogger());

    Response response = await dio.get(
      '${ApiConstants.baseUrl}/${ApiConstants.GIT}/diff',
    );
    return response.data['diff'];
  }
}
