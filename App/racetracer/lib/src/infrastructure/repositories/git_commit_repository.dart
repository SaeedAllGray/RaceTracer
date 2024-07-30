import 'package:racetracer/src/domain/data_source_models/entity_repository.dart';
import 'package:racetracer/src/domain/entries/git_comment.dart';
import 'package:racetracer/src/domain/entries/git_commit.dart';
import 'package:racetracer/src/infrastructure/datasources/remote/git_commit_data_source.dart';

class GitCommitRepository
    implements EntityRepository<GitCommit, GitCommitDataSource> {
  @override
  GitCommitDataSource api = GitCommitDataSource();

  @override
  Future<List<GitCommit>> fetchEntities() async {
    // TODO: fix this in the API
    dynamic response = await api.fetchEntities();

    return (response as List).map((data) => GitCommit.fromJson(data)).toList();
  }

  @override
  Future<GitCommit> fetchEntity(int id) async {
    dynamic response = await api.fetchAnEntity(id);
    return GitCommit.fromJson(response);
  }

  Future<List<GitComment>> fetchCommentsEntities(String id) async {
    dynamic response = await api.fetchComments(id);

    return (response as List).map((data) => GitComment.fromJson(data)).toList()
      ..sort(
        (a, b) => b.createdAt.compareTo(a.createdAt),
      );
  }

  @override
  Future<GitComment> createComment(GitCommit gitCommit, String note) async {
    dynamic response = await api.createComment(gitCommit.id, note);
    return GitComment.fromJson(response);
  }
}
