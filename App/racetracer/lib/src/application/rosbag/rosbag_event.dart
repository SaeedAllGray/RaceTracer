part of 'rosbag_bloc.dart';

sealed class RosbagEvent extends Equatable {
  const RosbagEvent();

  @override
  List<Object> get props => [];
}

class ToggleRosTopic extends RosbagEvent {
  final RosTopic rosTopic;

  const ToggleRosTopic({required this.rosTopic});
  @override
  List<Object> get props => [rosTopic];
}

class StartRosBagRecording extends RosbagEvent {
  final String name;

  const StartRosBagRecording({required this.name});
}

class StopRosBagRecording extends RosbagEvent {}
