import 'dart:io';

import 'package:racetracer/src/domain/entries/git_file.dart';
import 'package:racetracer/src/infrastructure/datasources/remote/git_file_data_source.dart';

class GitFileRepository {
  GitFileDataSource dataSource = GitFileDataSource();

  Future<GitFile> uploadFile(String path, File image) async {
    dynamic response = await dataSource.uploadFile(path, image);
    response = await dataSource.getFile(response['file_path']);
    return response.data;
  }

  Future<void> deleteFile(String path) async {
    await dataSource.deleteFile(path);
  }
  // Future<String> getFile(String gitPath) async {
  //   dynamic response = await dataSource.uploadFile(path, image);
  //   return response['file_path'];
  // }
}
