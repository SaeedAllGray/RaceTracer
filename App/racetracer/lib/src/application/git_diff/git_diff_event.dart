part of 'git_diff_bloc.dart';

sealed class GitDiffEvent extends Equatable {
  const GitDiffEvent();

  @override
  List<Object> get props => [];
}

class GetGitDiffs extends GitDiffEvent {}
