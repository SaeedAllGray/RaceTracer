import 'dart:developer';

import 'package:racetracer/src/domain/data_source_models/entity_repository.dart';
import 'package:racetracer/src/domain/entries/test_session.dart';
import 'package:racetracer/src/infrastructure/datasources/remote/test_session_data_source.dart';

class DoctorRepository
    implements EntityRepository<TestSession, TestSessionDataSource> {
  @override
  TestSessionDataSource api = TestSessionDataSource();

  @override
  Future<List<TestSession>> fetchEntities() async {
    List<dynamic> response = await api.fetchEntities();
    log(response.toString());
    return response.map((data) => TestSession.fromJson(data)).toList();
  }

  @override
  Future<TestSession> fetchEntity(int id) async {
    dynamic response = await api.fetchAnEntity(id);
    return TestSession.fromJson(response);
  }
}
