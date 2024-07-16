import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:racetracer/src/%20infrastructure/repositories/ros_topic_repository.dart';
import 'package:racetracer/src/domain/entries/ros_topic.dart';
import 'package:racetracer/src/domain/entries/topic_info.dart';

part 'ros_topic_event.dart';
part 'ros_topic_state.dart';

class RosTopicBloc extends Bloc<RosTopicEvent, RosTopicState> {
  RosTopicBloc() : super(RosTopicInitial()) {
    on<GetRosTopics>(_onGetRosTopicsEvent);
    on<GetTopicInfo>(_onGetTopicInfoEvent);
  }
  FutureOr<void> _onGetTopicInfoEvent(
      GetTopicInfo event, Emitter<RosTopicState> emit) async {
    emit(RosTopicInProgress());
    RosTopicRepository repository = RosTopicRepository();
    TopicInfo topicInfo = await repository.fetchTopicInfo(event.topic);
    emit(RosTopicInfoFetched(topicInfo: topicInfo));
  }

  FutureOr<void> _onGetRosTopicsEvent(
      GetRosTopics event, Emitter<RosTopicState> emit) async {
    emit(RosTopicInProgress());
    RosTopicRepository repository = RosTopicRepository();
    List<RosTopic> topics = await repository.fetchTopics();
    emit(RosTopicsFetched(rosTopics: topics));
  }
}
