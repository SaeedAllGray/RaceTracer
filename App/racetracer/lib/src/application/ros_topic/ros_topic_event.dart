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
