part of 'git_diff_bloc.dart';

sealed class GitDiffState extends Equatable {
  const GitDiffState();

  @override
  List<Object> get props => [];
}

final class GitDiffInitial extends GitDiffState {}

class GitDiffInProgress extends GitDiffState {}

class GitDiffsFetched extends GitDiffState {
  final String diff;

  const GitDiffsFetched({required this.diff});
}
