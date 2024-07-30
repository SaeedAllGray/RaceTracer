part of 'upload_file_bloc.dart';

sealed class UploadFileEvent extends Equatable {
  const UploadFileEvent();

  @override
  List<Object> get props => [];
}

class UploadImage extends UploadFileEvent {}

class RemoveImage extends UploadFileEvent {
  final UploadedFile uploadedFile;

  const RemoveImage({required this.uploadedFile});
}
