import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:racetracer/src/domain/entries/git_comment.dart';
import 'package:racetracer/src/domain/entries/git_commit.dart';
import 'package:racetracer/src/domain/entries/uploaded_file.dart';
import 'package:racetracer/src/infrastructure/repositories/git_commit_repository.dart';

part 'git_commit_event.dart';
part 'git_commit_state.dart';

class GitCommitBloc extends Bloc<GitCommitEvent, GitCommitState> {
  GitCommitBloc() : super(GitCommitInitial()) {
    on<GetGitCommits>(_onGetGitCommitEvent);
    on<GetGitCommitComments>(_onGetGitCommitCommentsEvent);
    on<PostGitCommitComment>(_onPostGitCommitCommentEvent);
  }
  FutureOr<void> _onGetGitCommitEvent(
      GetGitCommits event, Emitter<GitCommitState> emit) async {
    emit(GitCommitInProgress());
    GitCommitRepository repository = GitCommitRepository();
    List<GitCommit> gitCommits = await repository.fetchEntities();
    emit(GitCommitsFetched(gitCommits: gitCommits));
  }

  FutureOr<void> _onGetGitCommitCommentsEvent(
      GetGitCommitComments event, Emitter<GitCommitState> emit) async {
    emit(GitCommitInProgress());
    GitCommitRepository repository = GitCommitRepository();
    List<GitComment> gitComments =
        await repository.fetchCommentsEntities(event.gitCommit.id);
    emit(GitCommitCommentsFetched(gitComments: gitComments));
  }

  FutureOr<void> _onPostGitCommitCommentEvent(
      PostGitCommitComment event, Emitter<GitCommitState> emit) async {
    GitCommitRepository repository = GitCommitRepository();
    String note = event.note +
        event.uploadedFiles
            .map(
              (e) => e.markdown,
            )
            .join();

    await repository.createComment(event.gitCommit, note);
    List<GitComment> gitComments =
        await repository.fetchCommentsEntities(event.gitCommit.id);
    emit(GitCommitCommentsFetched(gitComments: gitComments));
  }
}
