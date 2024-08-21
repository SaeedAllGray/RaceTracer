import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:racetracer/src/presentation/constants/api_constant.dart';

class RosNodeDataSource {
  Dio dio = Dio();

  FutureOr<List<dynamic>> getNodes() async {
    dio.interceptors.add(PrettyDioLogger());

    Response response = await dio.get(
      '${ApiConstants.getBaseUrl}/${ApiConstants.ROS}/nodes',
    );
    return response.data['nodes'];
  }

  FutureOr<List<dynamic>> getNodesInfo() async {
    dio.interceptors.add(PrettyDioLogger());

    Response response = await dio.get(
      '${ApiConstants.getBaseUrl}/${ApiConstants.ROS}/nodes/info',
    );
    return response.data['nodes_info'];
  }

  // FutureOr<dynamic> getTopicInfo(String topic) async {
  //   dio.interceptors.add(PrettyDioLogger());

  //   Response response = await dio.get(
  //     '${ApiConstants.baseUrl}/${ApiConstants.ROS}/topic/$topic/info',
  //   );
  //   return response.data;
  // }
}
