abstract class RemoteDataSource {
  abstract String url;
  Future<dynamic> fetchEntities();
  Future<dynamic> fetchAnEntity(int id);
}
