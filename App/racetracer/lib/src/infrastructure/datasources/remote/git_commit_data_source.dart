import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:racetracer/src/domain/data_source_models/remote_data_source.dart';
import 'package:racetracer/src/presentation/constants/api_constant.dart';
import 'package:racetracer/src/presentation/helpers/token_helper.dart';

class GitCommitDataSource implements RemoteDataSource {
  @override
  String url =
      "https://gitlab.fachschaften.org/api/v4/projects/3564/repository/commits/";
  Dio dio = Dio();

  @override
  Future fetchAnEntity(int id) async {
    dio.interceptors.add(PrettyDioLogger());
    // TODO: project_id is hard-coded for now
    Response response = await dio.get(
      '${ApiConstants.gitUrl}/projects/3564/${ApiConstants.REPOSITORY}/${ApiConstants.COMMITS}/$id',
      options: Options(headers: TokenHelper.getHeaderToken),
    );

    return response.data;
  }

  @override
  Future fetchEntities() async {
    dio.interceptors.add(PrettyDioLogger());
    Response response = await dio.get(
      '${ApiConstants.gitUrl}/projects/3564/${ApiConstants.REPOSITORY}/${ApiConstants.COMMITS}',
      options: Options(headers: TokenHelper.getHeaderToken),
    );

    return response.data;
  }

  Future fetchComments(String id) async {
    dio.interceptors.add(PrettyDioLogger());
    Response response = await dio.get(
      '${ApiConstants.gitUrl}/projects/3564/${ApiConstants.REPOSITORY}/${ApiConstants.COMMITS}/$id/${ApiConstants.COMMENTS}',
      options: Options(headers: TokenHelper.getHeaderToken),
    );

    return response.data;
  }

  Future createComment(String id, String note) async {
    dio.interceptors.add(PrettyDioLogger());
    Response response = await dio.post(
      '${ApiConstants.gitUrl}/projects/3564/${ApiConstants.REPOSITORY}/${ApiConstants.COMMITS}/$id/${ApiConstants.COMMENTS}',
      queryParameters: {'note': note},
      options: Options(headers: TokenHelper.getHeaderToken),
    );

    return response.data;
  }
}
