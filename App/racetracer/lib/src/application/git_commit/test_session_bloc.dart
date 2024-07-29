import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:racetracer/src/domain/entries/git_comment.dart';
import 'package:racetracer/src/domain/entries/git_commit.dart';
import 'package:racetracer/src/infrastructure/datasources/remote/upload_data_source.dart';
import 'package:racetracer/src/infrastructure/repositories/git_commit_repository.dart';
import 'package:racetracer/src/presentation/helpers/image_picker_helper.dart';

part 'test_session_event.dart';
part 'test_session_state.dart';

class GitCommitBloc extends Bloc<GitCommitEvent, GitCommitState> {
  GitCommitBloc() : super(GitCommitInitial()) {
    on<GetGitCommits>(_onGetGitCommitEvent);
    on<GetGitCommitComments>(_onGetGitCommitCommentsEvent);
    on<UploadImage>(_onUploadImageEvent);
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

  FutureOr<void> _onUploadImageEvent(
      UploadImage event, Emitter<GitCommitState> emit) async {
    // emit(GitCommitInProgress());
    XFile? image = await ImagePickerHelper().pickImage();
    if (image != null) {
      await UploadDataSource.uploadImage(image.path);
    }
    // emit();
  }
}
