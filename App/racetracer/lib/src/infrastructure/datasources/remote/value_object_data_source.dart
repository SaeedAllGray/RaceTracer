import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:racetracer/src/presentation/constants/api_constant.dart';

class ValueObjectDataSource {
  Dio dio = Dio();

  FutureOr<dynamic> getEntity() async {
    dio.interceptors.add(PrettyDioLogger());

    Response response = await dio.get(
        '${ApiConstants.getBaseUrl}/${ApiConstants.ROS}/${ApiConstants.MESSAGE}/');
    return response.data['diff'];
  }
}
