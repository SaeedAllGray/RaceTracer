import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:racetracer/src/presentation/constants/api_constant.dart';

class ConfigDataSource {
  Dio dio = Dio();
  Future<dynamic> getConfigurations(String hostIP) async {
    dio.interceptors.add(PrettyDioLogger());

    Response response = await dio
        .get(
          'http://$hostIP/${ApiConstants.GIT}/setup',
        )
        .timeout(const Duration(seconds: 5));

    print(response.data['message']['oauth']);
    return response.data['message'];
  }
}
