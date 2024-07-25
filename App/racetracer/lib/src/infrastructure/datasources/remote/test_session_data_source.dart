import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:racetracer/src/domain/data_source_models/remote_data_source.dart';
import 'package:racetracer/src/presentation/constants/api_constant.dart';

class TestSessionDataSource implements RemoteDataSource {
  @override
  String url = "${ApiConstants.MESSAGE}/${ApiConstants.TESTSESSIONS}";
  Dio dio = Dio();

  @override
  Future fetchAnEntity(int id) async {
    dio.interceptors.add(PrettyDioLogger());
    Response response = await dio.get(
      '${ApiConstants.baseUrl}$url/$id/',
      // options:
      //     Options(headers: {'Authorization': 'Token ${ApiConstants.getToken}'}),
    );
    log(response.data);

    return response.data;
  }

  @override
  Future fetchEntities() async {
    dio.interceptors.add(PrettyDioLogger());
    Response response = await dio.get(
      '${ApiConstants.baseUrl}/$url/',
      // options:
      //     Options(headers: {'Authorization': 'Token ${ApiConstants.getToken}'}),
    );
    log(response.data);

    return response.data;
  }
}
