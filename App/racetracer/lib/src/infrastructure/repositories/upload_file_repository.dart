import 'package:racetracer/src/domain/entries/uploaded_file.dart';
import 'package:racetracer/src/infrastructure/datasources/remote/upload_data_source.dart';

class UploadFileRepository {
  UploadDataSource api = UploadDataSource();

  Future<UploadedFile> uploadImage(String filePath) async {
    // TODO: fix this in the API
    dynamic response = await api.uploadImage(filePath);

    return UploadedFile.fromJson(response);
  }
}
