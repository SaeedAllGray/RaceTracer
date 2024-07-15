import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:racetracer/src/%20infrastructure/repositories/ros_repository.dart';
import 'package:racetracer/src/domain/entries/topic_info.dart';

part 'ros_event.dart';
part 'ros_state.dart';

class RosBloc extends Bloc<RosEvent, RosState> {
  RosBloc() : super(RosInitial()) {
    on<GetTopicInfo>(_onGetTopicInfoEvent);
    on<GetTopics>(_onGetRosTopicsEvent);
  }
  FutureOr<void> _onGetTopicInfoEvent(
      GetTopicInfo event, Emitter<RosState> emit) async {
    emit(RosInProgress());
    RosRepository repository = RosRepository();
    TopicInfo topicInfo = await repository.fetchTopicInfo(event.topic);
    emit(TopicInfoFetched(topicInfo: topicInfo));
  }

  FutureOr<void> _onGetRosTopicsEvent(
      GetTopics event, Emitter<RosState> emit) async {
    emit(RosInProgress());
    RosRepository repository = RosRepository();
    List<String> topics = await repository.fetchTopics();
    emit(TopicsFetched(topics: topics));
  }
}
