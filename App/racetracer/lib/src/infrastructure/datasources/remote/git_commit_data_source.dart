import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:racetracer/src/domain/data_source_models/remote_data_source.dart';
import 'package:racetracer/src/presentation/constants/api_constant.dart';
import 'package:racetracer/src/presentation/helpers/token_helper.dart';

class GitCommitDataSource implements RemoteDataSource {
  @override
  String url =
      "https://gitlab.fachschaften.org/api/v4/projects/448/repository/commits/";
  Dio dio = Dio();

  @override
  Future fetchAnEntity(int id) async {
    dio.interceptors.add(PrettyDioLogger());
    // TODO: project_id is hard-coded for now
    Response response = await dio.get(
      '${ApiConstants.gitUrl}projects/448/${ApiConstants.REPOSITORY}/${ApiConstants.COMMITS}/$id',
      options: Options(headers: TokenHelper.getHeaderToken),
    );

    return response.data;
  }

  @override
  Future fetchEntities() async {
    dio.interceptors.add(PrettyDioLogger());
    Response response = await dio.get(
      '${ApiConstants.gitUrl}projects/448/${ApiConstants.REPOSITORY}/${ApiConstants.COMMITS}?ref_name=racetracer', //TODO: change this
      options: Options(headers: TokenHelper.getHeaderToken),
    );

    return response.data;
  }

  Future fetchComments(String id, {int? page}) async {
    dio.interceptors.add(PrettyDioLogger());
    List<dynamic> listy = [];
    int pageNumber = 0;
    Response? response;
    do {
      pageNumber++;
      response = await dio.get(
        '${ApiConstants.gitUrl}/projects/448/${ApiConstants.REPOSITORY}/${ApiConstants.COMMITS}/$id/${ApiConstants.COMMENTS}',
        queryParameters: {
          "order_by": "created_at",
          "sort": "asc",
          "page": pageNumber,
          "per_page": 20
        },
        options: Options(headers: TokenHelper.getHeaderToken),
      );

      log(response.headers['x-total']![0]);
      listy.addAll(response.data);
    } while (int.parse(response.headers['x-total']![0]) > pageNumber * 20);

    // log("list" + listy.length.toString());
    // print(listy[0]);
    return listy;
  }

  Future createComment(String id, String note) async {
    dio.interceptors.add(PrettyDioLogger());
    Response response = await dio.post(
      '${ApiConstants.gitUrl}/projects/448/${ApiConstants.REPOSITORY}/${ApiConstants.COMMITS}/$id/${ApiConstants.COMMENTS}',
      queryParameters: {'note': note},
      options: Options(headers: TokenHelper.getHeaderToken),
    );

    return response.data;
  }
}
