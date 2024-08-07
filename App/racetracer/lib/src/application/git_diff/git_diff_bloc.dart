import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:racetracer/src/infrastructure/repositories/attribute_diff_repository.dart';
import 'package:racetracer/src/domain/entries/attribute_diff.dart';

part 'git_diff_event.dart';
part 'git_diff_state.dart';

class GitDiffBloc extends Bloc<GitDiffEvent, GitDiffState> {
  GitDiffBloc() : super(GitDiffInitial()) {
    on<GetGitDiffs>(_onGetGetGitDiffsEvent);
  }
  FutureOr<void> _onGetGetGitDiffsEvent(
      GetGitDiffs event, Emitter<GitDiffState> emit) async {
    emit(GitDiffInProgress());
    GitDiffRepository repository = GitDiffRepository();
    String diff = await repository.fetchEntities();
    emit(GitDiffsFetched(diff: diff));
  }
}
