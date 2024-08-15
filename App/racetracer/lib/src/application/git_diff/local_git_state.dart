part of 'local_git_bloc.dart';

sealed class LocalGitState extends Equatable {
  const LocalGitState();

  @override
  List<Object> get props => [];
}

final class GitDiffInitial extends LocalGitState {}

class GitDiffInProgress extends LocalGitState {}

class GitDiffsFetched extends LocalGitState {
  final String diff;

  const GitDiffsFetched({required this.diff});
}

class GitPushInProgress extends LocalGitState {}

class GitPushSucceed extends LocalGitState {}

class GitPushFailed extends LocalGitState {}
