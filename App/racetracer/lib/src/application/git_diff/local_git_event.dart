part of 'local_git_bloc.dart';

sealed class LocalGitEvent extends Equatable {
  const LocalGitEvent();

  @override
  List<Object> get props => [];
}

class GetGitDiffs extends LocalGitEvent {}

class CommitAndPush extends LocalGitEvent {
  final String message;

  const CommitAndPush(this.message);
}
