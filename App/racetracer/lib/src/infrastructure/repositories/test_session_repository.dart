import 'dart:developer';

import 'package:racetracer/src/domain/data_source_models/entity_repository.dart';
import 'package:racetracer/src/domain/entries/test_session.dart';
import 'package:racetracer/src/infrastructure/datasources/remote/test_session_data_source.dart';

class TestSessionRepository
    implements EntityRepository<TestSession, TestSessionDataSource> {
  @override
  TestSessionDataSource api = TestSessionDataSource();

  @override
  Future<List<TestSession>> fetchEntities() async {
    // TODO: fix this in the API
    dynamic response = await api.fetchEntities();

    return (response as List)
        .map((data) => TestSession.fromJson(data))
        .toList();
  }

  @override
  Future<TestSession> fetchEntity(int id) async {
    dynamic response = await api.fetchAnEntity(id);
    return TestSession.fromJson(response);
  }
}
