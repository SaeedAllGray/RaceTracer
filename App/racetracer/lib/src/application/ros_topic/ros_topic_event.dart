part of 'ros_topic_bloc.dart';

sealed class RosTopicEvent extends Equatable {
  const RosTopicEvent();

  @override
  List<Object> get props => [];
}

class GetTopicInfo extends RosTopicEvent {
  final String topic;

  const GetTopicInfo({required this.topic});
}

class GetRosTopics extends RosTopicEvent {}

class GetTopicsInfo extends RosTopicEvent {
  final List<RosTopic> topics;

  const GetTopicsInfo({required this.topics});
}

class FilterTopics extends RosTopicEvent {
  final String searchTerm;

  const FilterTopics({required this.searchTerm});
}

class GetRosTopicMessage extends RosTopicEvent {
  final RosTopic topic;

  const GetRosTopicMessage({required this.topic});
}
