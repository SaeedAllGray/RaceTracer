import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:racetracer/src/%20infrastructure/repositories/ros_repository.dart';

part 'ros_event.dart';
part 'ros_state.dart';

class RosBloc extends Bloc<RosEvent, RosState> {
  RosBloc() : super(RosInitial()) {
    on<GetRosTopics>(_onGetRosTopicsEvent);
  }
  FutureOr<void> _onGetRosTopicsEvent(
      GetRosTopics event, Emitter<RosState> emit) async {
    emit(RosInProgress());
    RosRepository repository = RosRepository();
    List<String> topics = await repository.fetchTopics();
    emit(RosFetched(topics: topics));
  }
}
