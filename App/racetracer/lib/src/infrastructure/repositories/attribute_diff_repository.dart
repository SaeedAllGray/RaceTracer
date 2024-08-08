import 'package:racetracer/src/infrastructure/datasources/remote/git_diff_data_source.dart';
import 'package:racetracer/src/domain/entries/attribute_diff.dart';

class GitDiffRepository {
  GitDiffDataSource dataSource = GitDiffDataSource();

  Future<String> fetchEntities() async {
    dynamic response = await dataSource.getAttributeDiffs();
    return response.toString();
  }
}
