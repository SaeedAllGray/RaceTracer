part of 'config_bloc.dart';

sealed class ConfigState extends Equatable {
  const ConfigState();

  @override
  List<Object> get props => [];
}

final class ConfigInitial extends ConfigState {}

final class ConfigInProgressState extends ConfigState {}

final class FetchSucceedState extends ConfigState {
  final String hostIP;

  const FetchSucceedState({required this.hostIP});

  @override
  List<Object> get props => [hostIP];
}

final class DownloadSucceedState extends ConfigState {}

final class DownloadFailedState extends ConfigState {}

final class SavedSucceedState extends ConfigState {
  final String hostIP;

  const SavedSucceedState({required this.hostIP});

  @override
  List<Object> get props => [hostIP];
}

final class WaitingForNewValuesState extends ConfigState {}

final class DataDeletedState extends ConfigState {}
