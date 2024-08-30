part of 'config_bloc.dart';

sealed class ConfigEvent extends Equatable {
  const ConfigEvent();

  @override
  List<Object> get props => [];
}

final class SaveEvent extends ConfigEvent {
  final String hostIP;

  const SaveEvent({required this.hostIP});

  @override
  List<Object> get props => [hostIP];
}

final class FetchDataEvent extends ConfigEvent {}

final class DownloadDataEvent extends ConfigEvent {
  final String hostIP;

  const DownloadDataEvent({required this.hostIP});

  @override
  List<Object> get props => [hostIP];
}

final class SignoutEvent extends ConfigEvent {}
