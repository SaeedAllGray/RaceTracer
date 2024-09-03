import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:racetracer/src/presentation/constants/api_constant.dart';

class RosBagDataSource {
  Dio dio = Dio();

  FutureOr<dynamic> startRecordingTopics(
      {required List<String> topics, required String name}) async {
    dio.interceptors.add(PrettyDioLogger(requestBody: true));

    Response response = await dio.post(
        '${ApiConstants.getBaseUrl}/${ApiConstants.ROS}/bag/record/',
        data: {'topics': topics, "bag_name": name});

    return response.data["message"];
  }

  FutureOr<dynamic> stopRecording() async {
    dio.interceptors.add(PrettyDioLogger());

    Response response = await dio.post(
      '${ApiConstants.getBaseUrl}/${ApiConstants.ROS}/bag/stop/',
    );
    return response.data;
  }
}
