part of 'ros_node_bloc.dart';

sealed class RosNodeEvent extends Equatable {
  const RosNodeEvent();

  @override
  List<Object> get props => [];
}

class GetRosNodes extends RosNodeEvent {}
