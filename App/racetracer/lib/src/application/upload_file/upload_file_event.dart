part of 'upload_file_bloc.dart';

sealed class UploadFileEvent extends Equatable {
  const UploadFileEvent();

  @override
  List<Object> get props => [];
}

class UploadMedia extends UploadFileEvent {}

class UploadImageFromLibrary extends UploadMedia {}

class UploadImageFromCamera extends UploadMedia {}

class RemoveImage extends UploadFileEvent {
  final UploadedFile uploadedFile;

  const RemoveImage({required this.uploadedFile});
}

class ClearFiles extends UploadFileEvent {}
