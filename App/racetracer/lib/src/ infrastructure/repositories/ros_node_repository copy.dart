import 'package:racetracer/src/%20infrastructure/datasources/remote/attribute_diff_data_source.dart';
import 'package:racetracer/src/domain/entries/attribute_diff.dart';

class AttributeDiffRepository {
  AttributeDiffDataSource dataSource = AttributeDiffDataSource();

  Future<List<AttributeDiff>> fetchEntities() async {
    List<dynamic> response = await dataSource.getAttributeDiffs();
    return response.map((e) => AttributeDiff.fromJson(e)).toList();
  }
}
