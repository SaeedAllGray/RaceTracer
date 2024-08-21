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
      '${ApiConstants.getBaseUrl}$url/$id/',
      options: Options(headers: {
        'Authorization': 'Token 42fa248a75e37b116d220db21b8afebbe64d0e2a'
      }),
    );

    return response.data;
  }

  @override
  Future fetchEntities() async {
    dio.interceptors.add(PrettyDioLogger());
    Response response = await dio.get(
      '${ApiConstants.getBaseUrl}/$url/',
      options: Options(
        headers: {
          'Authorization': 'Token 42fa248a75e37b116d220db21b8afebbe64d0e2a'
        },
      ),
    );

    return response.data;
  }
}
