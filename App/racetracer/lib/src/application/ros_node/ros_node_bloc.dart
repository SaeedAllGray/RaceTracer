import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:racetracer/src/%20infrastructure/repositories/ros_node_repository.dart';
import 'package:racetracer/src/domain/entries/ros_node.dart';

part 'ros_node_event.dart';
part 'ros_node_state.dart';

class RosNodeBloc extends Bloc<RosNodeEvent, RosNodeState> {
  RosNodeBloc() : super(RosNodeInitial()) {
    on<GetRosNodes>(_onGetRosNodesEvent);
    on<GetRosNodesInfo>(_onGetRosNodesInfoEvent);
  }

  FutureOr<void> _onGetRosNodesEvent(
      GetRosNodes event, Emitter<RosNodeState> emit) async {
    emit(RosNodeInProgress());
    RosNodeRepository repository = RosNodeRepository();
    List<RosNode> rosNodes = await repository.fetchEntities();
    emit(RosNodesFetched(rosNodes: rosNodes));
  }

  FutureOr<void> _onGetRosNodesInfoEvent(
      GetRosNodesInfo event, Emitter<RosNodeState> emit) async {
    emit(RosNodeInProgress());
    RosNodeRepository repository = RosNodeRepository();
    List<RosNode> rosNodes = await repository.fetchNodesInfo();
    emit(RosNodesFetched(rosNodes: rosNodes));
  }
}
