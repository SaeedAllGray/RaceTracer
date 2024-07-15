import 'dart:async';

import 'package:dio/dio.dart';
import 'package:racetracer/src/presentation/constants/api_constant.dart';

class RosDataSource {
  Dio dio = Dio();

  FutureOr<List<dynamic>> getTopics() async {
    Response response = await dio.get(
      '${ApiConstants.baseUrl}',
    );
    return response.data;
  }
}
