import 'package:racetracer/src/infrastructure/datasources/remote/local_git_data_source.dart';
import 'package:racetracer/src/domain/entries/attribute_diff.dart';

class LocalGitRepository {
  LocalGitDataSource dataSource = LocalGitDataSource();

  Future<String> fetchEntities() async {
    dynamic response = await dataSource.getAttributeDiffs();
    return response.toString();
  }

  Future<String> commitAndPush(String message) async {
    dynamic response = await dataSource.commitAndPushActiveLocalBranch(message);
    return response['hexsha'];
  }
}
