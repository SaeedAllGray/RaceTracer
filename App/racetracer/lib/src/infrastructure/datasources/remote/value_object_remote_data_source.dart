import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:racetracer/src/domain/entries/value_object.dart';
import 'package:racetracer/src/presentation/constants/api_constant.dart';

class ValueObjectRemoteDataSource {
  Dio dio = Dio();

  FutureOr<dynamic> getEntities(
      List<ValueObject> topics, List<String> labels) async {
    // dio.interceptors.add(PrettyDioLogger(requestBody: true));

    Response response = await dio.get(
        '${ApiConstants.getBaseUrl}/${ApiConstants.ROS}/${ApiConstants.TOPIC}/${ApiConstants.VALUES}/',
        data: jsonEncode({
          "topics": topics,
          "labels": labels,
        }));

    return response.data['messages'];
  }

  FutureOr<dynamic> getScripts() async {
    dio.interceptors.add(PrettyDioLogger(requestBody: true));

    Response response = await dio.get(
      '${ApiConstants.getBaseUrl}/${ApiConstants.ROS}/${ApiConstants.SCRIPTS}/',
    );

    return response.data['message'];
  }
}
