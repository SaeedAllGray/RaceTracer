import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:racetracer/src/presentation/constants/api_constant.dart';
import 'package:racetracer/src/presentation/helpers/token_helper.dart';

class UploadDataSource {
  static Dio dio = Dio();

  static Future<void> uploadImage(String filePath) async {
    dio.interceptors.add(PrettyDioLogger());
    String fileName = filePath.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(filePath,
          filename: fileName, contentType: DioMediaType('image', 'jpeg')),
    });

    Response response = await dio.post(
      '${ApiConstants.gitUrl}/${ApiConstants.PROJECTS}/3564/${ApiConstants.UPLOADS}',
      options: Options(headers: TokenHelper.getHeaderToken),
      data: formData,
    );
  }
}
