part of 'config_bloc.dart';

sealed class ConfigState extends Equatable {
  const ConfigState();

  @override
  List<Object> get props => [];
}

final class ConfigInitial extends ConfigState {}

final class ConfigInProgressState extends ConfigState {}

final class FetchSucceedState extends ConfigState {
  final String projectID;
  final String hostIP;

  const FetchSucceedState({required this.projectID, required this.hostIP});

  @override
  List<Object> get props => [projectID, hostIP];
}

final class WaitingForNewValuesState extends ConfigState {}

final class DataDeletedState extends ConfigState {}
