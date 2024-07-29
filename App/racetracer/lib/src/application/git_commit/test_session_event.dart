part of 'test_session_bloc.dart';

sealed class GitCommitEvent extends Equatable {
  const GitCommitEvent();

  @override
  List<Object> get props => [];
}

class GetGitCommits extends GitCommitEvent {}
