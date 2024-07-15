part of 'ros_bloc.dart';

sealed class RosState extends Equatable {
  const RosState();

  @override
  List<Object> get props => [];
}

final class RosInitial extends RosState {}

class RosInProgress extends RosState {}

class RosInfoInProgress extends RosState {}

class TopicInfoFetched extends RosState {
  final TopicInfo topicInfo;

  const TopicInfoFetched({required this.topicInfo});
}

class TopicsFetched extends RosState {
  final List<String> topics;

  const TopicsFetched({required this.topics});
}
