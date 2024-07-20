part of 'rosbag_bloc.dart';

sealed class RosbagState extends Equatable {
  const RosbagState();

  @override
  List<Object> get props => [];
}

final class RosbagInitial extends RosbagState {
  final List<RosTopic> rosTopics;

  const RosbagInitial({required this.rosTopics});
  @override
  List<Object> get props => [rosTopics];
}

class RosbagRecordingStarted extends RosbagState {
  final List<RosTopic> rosTopics;

  const RosbagRecordingStarted({required this.rosTopics});
}

class RosbagRecordingFinishede extends RosbagState {}
