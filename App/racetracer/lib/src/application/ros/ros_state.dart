part of 'ros_bloc.dart';

sealed class RosState extends Equatable {
  const RosState();

  @override
  List<Object> get props => [];
}

final class RosInitial extends RosState {}

class RosInProgress extends RosState {}

class RosFetched extends RosState {
  final List<String> topics;

  const RosFetched({required this.topics});
}
