import 'package:dio/dio.dart';
import 'package:racetracer/src/presentation/constants/api_constant.dart';

class UploadDataSource {
  final Dio _dio = Dio();

  Future<void> uploadImage(String filePath) async {
    String fileName = filePath.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(filePath,
          filename: fileName, contentType: DioMediaType('image', 'jpeg')),
    });

    Response response = await _dio.post(
      '${ApiConstants.gitUrl}/${ApiConstants.PROJECTS}/3564/${ApiConstants.UPLOADS}',
      data: formData,
    );
    if (response.statusCode == 200) {
      print("Image uploaded successfully!");
    } else {
      print("Image upload failed!");
    }
  }
}
