abstract class EntityRepository<T, RemoteDataSourceRepository> {
  abstract RemoteDataSourceRepository api;
  Future<List<T>> fetchEntities();
  Future<T> fetchEntity(int id);
}
