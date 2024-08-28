import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:racetracer/src/domain/entries/git_file.dart';
import 'package:racetracer/src/domain/entries/uploaded_file.dart';
import 'package:racetracer/src/infrastructure/repositories/git_file_repository.dart';
import 'package:racetracer/src/infrastructure/repositories/upload_file_repository.dart';
import 'package:racetracer/src/presentation/helpers/image_picker_helper.dart';

part 'upload_file_event.dart';
part 'upload_file_state.dart';

class UploadFileBloc extends Bloc<UploadFileEvent, UploadFileState> {
  final List<UploadedFile> uplooadedFiles = [];
  final List<GitFile> gitFiles = [];
  UploadFileBloc() : super(const UploadFileCompleted([])) {
    // on<UploadMedia>(_onUploadImageEvent);
    on<UploadImageFromLibrary>(_onUploadImageEvent);
    on<UploadImageFromCamera>(_onUploadImageEvent);
    on<RemoveImage>(_onRemoveImageEvent);
    on<ClearFiles>(_onClearFilesEvent);
  }
  FutureOr<void> _onUploadImageEvent(
      UploadMedia event, Emitter<UploadFileState> emit) async {
    UploadFileRepository repository = UploadFileRepository();
    XFile? image;
    if (event is UploadImageFromLibrary) {
      image = await ImagePickerHelper().pickImage();
    } else if (event is UploadImageFromCamera) {
      image = await ImagePickerHelper().takePicture();
    }
    if (image != null) {
      emit(UploadFileInProgress(uplooadedFiles));
      UploadedFile uploadedFile = await repository.uploadImage(image.path);
      uplooadedFiles.add(uploadedFile);
      List<UploadedFile> newUploadedFiles =
          List<UploadedFile>.from(uplooadedFiles);
      GitFileRepository()
          .uploadFile("src/documentation/racetracer/images/", File(image.path));
      emit(UploadFileCompleted(newUploadedFiles));
    }
  }

  FutureOr<void> _onRemoveImageEvent(
      RemoveImage event, Emitter<UploadFileState> emit) async {
    // emit(GitCommitInProgress());

    uplooadedFiles.remove(event.uploadedFile);
    List<UploadedFile> newUploadedFiles =
        List<UploadedFile>.from(uplooadedFiles);

    emit(UploadFileCompleted(newUploadedFiles));
  }

  FutureOr<void> _onClearFilesEvent(
      ClearFiles event, Emitter<UploadFileState> emit) async {
    // emit(GitCommitInProgress());

    uplooadedFiles.clear();
    List<UploadedFile> newUploadedFiles =
        List<UploadedFile>.from(uplooadedFiles);

    emit(UploadFileCompleted(newUploadedFiles));
  }
}
