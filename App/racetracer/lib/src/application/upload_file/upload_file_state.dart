part of 'upload_file_bloc.dart';

sealed class UploadFileState extends Equatable {
  const UploadFileState();

  @override
  List<Object> get props => [];
}

final class UploadFileInitial extends UploadFileState {}

class UploadFileInProgress extends UploadFileCompleted {
  const UploadFileInProgress(super.uploadedFiles);

  @override
  List<Object> get props => uploadedFiles;
}

class UploadFileCompleted extends UploadFileState {
  final List<UploadedFile> uploadedFiles;

  const UploadFileCompleted(this.uploadedFiles);
  @override
  List<Object> get props => uploadedFiles;
}
