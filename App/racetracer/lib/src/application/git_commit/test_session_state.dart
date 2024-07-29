part of 'test_session_bloc.dart';

sealed class GitCommitState extends Equatable {
  const GitCommitState();

  @override
  List<Object> get props => [];
}

final class GitCommitInitial extends GitCommitState {}

class GitCommitInProgress extends GitCommitState {}

class GitCommitsFetched extends GitCommitState {
  final List<GitCommit> gitCommits;

  const GitCommitsFetched({required this.gitCommits});
}

class GitCommitCommentsFetched extends GitCommitState {
  final List<GitComment> gitComments;

  const GitCommitCommentsFetched({required this.gitComments});
}
