part of 'embed_bloc.dart';

sealed class EmbedState extends Equatable {
  const EmbedState();

  @override
  List<Object> get props => [];
}

final class EmbedInitial extends EmbedState {}

final class UpdatedState extends EmbedState {
  final WebViewController controller;

  const UpdatedState({required this.controller});

  @override
  List<Object> get props => [controller.currentUrl()];
}
