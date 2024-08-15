part of 'ros_node_bloc.dart';

sealed class RosNodeState extends Equatable {
  const RosNodeState();

  @override
  List<Object> get props => [];
}

final class RosNodeInitial extends RosNodeState {}

class RosNodeInProgress extends RosNodeState {}

class RosNodeFailed extends RosNodeState {}

class RosNodesFetched extends RosNodeState {
  final List<RosNode> rosNodes;

  const RosNodesFetched({required this.rosNodes});
}
