part of 'embed_bloc.dart';

sealed class EmbedState extends Equatable {
  const EmbedState();

  @override
  List<Object> get props => [];
}

final class EmbedInitial extends EmbedState {}

final class UpdatedState extends EmbedState {
  final List<WebViewController> controllerList;

  const UpdatedState({required this.controllerList});

  @override
  List<Object> get props => [controllerList.length];
}
