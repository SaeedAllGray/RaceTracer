part of 'git_commit_bloc.dart';

sealed class GitCommitEvent extends Equatable {
  const GitCommitEvent();

  @override
  List<Object> get props => [];
}

class GetGitCommits extends GitCommitEvent {}

class GetGitCommitComments extends GitCommitEvent {
  final GitCommit gitCommit;

  const GetGitCommitComments({required this.gitCommit});
}

class PostGitCommitComment extends GitCommitEvent {
  final GitCommit gitCommit;
  final String note;
  final List<UploadedFile> uploadedFiles;

  const PostGitCommitComment({
    required this.gitCommit,
    required this.note,
    required this.uploadedFiles,
  });
}
