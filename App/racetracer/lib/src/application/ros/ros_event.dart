part of 'ros_bloc.dart';

sealed class RosEvent extends Equatable {
  const RosEvent();

  @override
  List<Object> get props => [];
}

class GetTopicInfo extends RosEvent {
  final String topic;

  const GetTopicInfo({required this.topic});
}

class GetTopics extends RosEvent {}
