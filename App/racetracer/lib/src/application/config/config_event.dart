part of 'config_bloc.dart';

sealed class ConfigEvent extends Equatable {
  const ConfigEvent();

  @override
  List<Object> get props => [];
}

final class SaveEvent extends ConfigEvent {
  final String projectID;
  final String hostIP;

  const SaveEvent({required this.projectID, required this.hostIP});

  @override
  List<Object> get props => [hostIP, projectID];
}

final class FetchDataEvent extends ConfigEvent {}

final class SignoutEvent extends ConfigEvent {}
