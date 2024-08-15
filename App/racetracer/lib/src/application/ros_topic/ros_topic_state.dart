part of 'ros_topic_bloc.dart';

sealed class RosTopicState extends Equatable {
  const RosTopicState();

  @override
  List<Object> get props => [];
}

final class RosTopicInitial extends RosTopicState {}

class RosTopicInProgress extends RosTopicState {}

class RosTopicInfoInProgress extends RosTopicState {}

class RosTopicFailed extends RosTopicState {}

class RosTopicInfoFetched extends RosTopicState {
  final TopicInfo topicInfo;

  const RosTopicInfoFetched({required this.topicInfo});
}

class RosTopicsFetched extends RosTopicState {
  final List<RosTopic> rosTopics;

  const RosTopicsFetched({required this.rosTopics});
}
