import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:racetracer/src/presentation/constants/api_constant.dart';

class RosTopicDataSource {
  Dio dio = Dio();

  FutureOr<List<dynamic>> getTopics() async {
    dio.interceptors.add(PrettyDioLogger());

    Response response = await dio.get(
      '${ApiConstants.getBaseUrl}/${ApiConstants.ROS}/topics',
    );
    return response.data['topics'];
  }

  FutureOr<dynamic> getTopicInfo(String topic) async {
    dio.interceptors.add(PrettyDioLogger());

    Response response = await dio.get(
      '${ApiConstants.getBaseUrl}/${ApiConstants.ROS}/topic/$topic/info',
    );
    return response.data;
  }

  FutureOr<dynamic> getTopicMessage(String topic) async {
    dio.interceptors.add(PrettyDioLogger());

    Response response = await dio.get(
        '${ApiConstants.getBaseUrl}/${ApiConstants.ROS}/topic/message',
        queryParameters: {"topic": Uri.encodeComponent(topic)});

    return response.data["message"];
  }
}
