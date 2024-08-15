import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:racetracer/src/presentation/constants/api_constant.dart';
import 'package:racetracer/src/presentation/helpers/token_helper.dart';

class GitFileDataSource {
  Dio dio = Dio();

  FutureOr<dynamic> pushFile(String fileName, String content) async {
    dio.interceptors.add(PrettyDioLogger());

    Response response = await dio.post(
      '${ApiConstants.gitUrl}/${ApiConstants.PROJECTS}/3261/${ApiConstants.REPOSITORY}/${ApiConstants.FILES}/${Uri.encodeComponent("src/documentation/racetracer/$fileName.md")}',
      options: Options(headers: TokenHelper.getHeaderToken),
      data: {
        "branch": "racetracer",
        "commit_message": "Updated $fileName",
        "content": content,
      },
    );
    return response.data;
  }

  FutureOr<dynamic> updateFile(String fileName, String content) async {
    dio.interceptors.add(PrettyDioLogger());

    Response response = await dio.put(
      '${ApiConstants.gitUrl}/${ApiConstants.PROJECTS}/3261/${ApiConstants.REPOSITORY}/${ApiConstants.FILES}/${Uri.encodeComponent("src/documentation/racetracer/$fileName.md")}',
      options: Options(headers: TokenHelper.getHeaderToken),
      data: {
        "branch": "racetracer",
        "commit_message": "Updated $fileName.md",
        "content": content,
      },
    );
    return response.data;
  }
}
