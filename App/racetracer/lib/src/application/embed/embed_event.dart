part of 'embed_bloc.dart';

sealed class EmbedEvent extends Equatable {
  const EmbedEvent();

  @override
  List<Object> get props => [];
}

class AddLinkEvent extends EmbedEvent {
  final String url;

  const AddLinkEvent({required this.url});

  @override
  List<Object> get props => [url];
}

class removeLinkEvent extends EmbedEvent {}
