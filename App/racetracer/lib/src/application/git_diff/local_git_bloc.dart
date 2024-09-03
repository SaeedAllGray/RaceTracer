import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:racetracer/src/domain/entries/git_commit.dart';
import 'package:racetracer/src/infrastructure/repositories/git_commit_repository.dart';
import 'package:racetracer/src/infrastructure/repositories/local_git_repository.dart';

part 'local_git_event.dart';
part 'local_git_state.dart';

class LocalGitBloc extends Bloc<LocalGitEvent, LocalGitState> {
  LocalGitBloc() : super(GitDiffInitial()) {
    on<GetGitDiffs>(_onGetGetGitDiffsEvent);
    on<CommitAndPush>(_onCommitAndPushEvent);
  }
  FutureOr<void> _onGetGetGitDiffsEvent(
      GetGitDiffs event, Emitter<LocalGitState> emit) async {
    emit(GitDiffInProgress());
    LocalGitRepository repository = LocalGitRepository();
    String diff = await repository.fetchEntities();
    emit(GitDiffsFetched(diff: diff));
  }

  FutureOr<void> _onCommitAndPushEvent(
      CommitAndPush event, Emitter<LocalGitState> emit) async {
    emit(GitPushInProgress());
    LocalGitRepository localGitRepository = LocalGitRepository();
    try {
      String commitSha = await localGitRepository.commitAndPush(event.message);
      GitCommit gitCommit =
          await GitCommitRepository().fetchEntityWithSha(commitSha);
      emit(GitPushSucceed(gitCommit: gitCommit));
    } catch (e) {
      log(e.toString());
      emit(GitPushFailed());
    }
  }
}
