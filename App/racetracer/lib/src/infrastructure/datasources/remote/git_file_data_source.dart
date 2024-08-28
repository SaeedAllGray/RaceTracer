import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:racetracer/src/presentation/constants/api_constant.dart';
import 'package:racetracer/src/presentation/helpers/token_helper.dart';
import 'package:path/path.dart' as path;

class GitFileDataSource {
  Dio dio = Dio();

  FutureOr<dynamic> writeFile(String gitPath, String content) async {
    dio.interceptors.add(PrettyDioLogger());

    Response response = await dio.post(
      '${ApiConstants.gitUrl}/${ApiConstants.PROJECTS}/3261/${ApiConstants.REPOSITORY}/${ApiConstants.FILES}/${Uri.encodeComponent(gitPath)}',
      options: Options(headers: TokenHelper.getHeaderToken),
      data: {
        "branch": "racetracer",
        "commit_message": "Updated $gitPath",
        "content": content,
      },
    );
    return response.data;
  }

  FutureOr<dynamic> uploadFile(String gitPath, File content) async {
    dio.interceptors.add(PrettyDioLogger());

    // Read the file as bytes

    List<int> fileBytes = await content.readAsBytes();

    // Encode the file content as base64
    String base64Content = base64Encode(fileBytes);

    Response response = await dio.post(
      '${ApiConstants.gitUrl}/${ApiConstants.PROJECTS}/3261/${ApiConstants.REPOSITORY}/${ApiConstants.FILES}/${Uri.encodeComponent(gitPath + path.basename(content.path))}',
      options: Options(headers: TokenHelper.getHeaderToken),
      data: {
        "branch": "racetracer",
        "commit_message": "Updated $gitPath${path.basename(content.path)}",
        "content": base64Content,
        "encoding": "base64", // Specify the encoding as base64
      },
    );

    return response.data;
  }

  FutureOr<dynamic> updateFile(String path, String content) async {
    dio.interceptors.add(PrettyDioLogger());

    Response response = await dio.put(
      '${ApiConstants.gitUrl}/${ApiConstants.PROJECTS}/3261/${ApiConstants.REPOSITORY}/${ApiConstants.FILES}/${Uri.encodeComponent(path)}',
      options: Options(headers: TokenHelper.getHeaderToken),
      data: {
        "branch": "racetracer",
        "commit_message": "Updated $path.md",
        "content": content,
      },
    );
    return response.data;
  }

  FutureOr<dynamic> getFile(String path) async {
    dio.interceptors.add(PrettyDioLogger());

    Response response = await dio.get(
      '${ApiConstants.gitUrl}/${ApiConstants.PROJECTS}/3261/${ApiConstants.REPOSITORY}/${ApiConstants.FILES}/${Uri.encodeComponent(path)}',
      options: Options(headers: TokenHelper.getHeaderToken),
      queryParameters: {
        'ref': 'racetracer',
      },
    );
    return response.data;
  }

  FutureOr<dynamic> getRawFile(String path) async {
    dio.interceptors.add(PrettyDioLogger());

    Response response = await dio.get(
      '${ApiConstants.gitUrl}/${ApiConstants.PROJECTS}/3261/${ApiConstants.REPOSITORY}/${ApiConstants.FILES}/${Uri.encodeComponent(path)}/${ApiConstants.RAW}',
      options: Options(headers: TokenHelper.getHeaderToken),
      queryParameters: {
        'ref': 'racetracer',
        'lfs': true,
      },
    );
    return response.data;
  }

  FutureOr<dynamic> deleteFile(String path) async {
    dio.interceptors.add(PrettyDioLogger());

    Response response = await dio.delete(
      '${ApiConstants.gitUrl}/${ApiConstants.PROJECTS}/3261/${ApiConstants.REPOSITORY}/${ApiConstants.FILES}/${Uri.encodeComponent(path)}/',
      options: Options(headers: TokenHelper.getHeaderToken),
      queryParameters: {
        "branch": "racetracer",
        "commit_message": "Deleted $path",
        'ref': 'racetracer',
      },
    );
    return response.data;
  }
}
