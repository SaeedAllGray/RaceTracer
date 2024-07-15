part of 'ros_bloc.dart';

sealed class RosEvent extends Equatable {
  const RosEvent();

  @override
  List<Object> get props => [];
}

class GetRosTopics extends RosEvent {}
