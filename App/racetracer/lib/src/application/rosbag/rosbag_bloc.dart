import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:racetracer/src/%20infrastructure/repositories/rosbag_repository.dart';
import 'package:racetracer/src/domain/entries/ros_topic.dart';

part 'rosbag_event.dart';
part 'rosbag_state.dart';

class RosbagBloc extends Bloc<RosbagEvent, RosbagState> {
  List<RosTopic> rosTopics = [];
  RosbagBloc() : super(const RosbagInitial(rosTopics: [])) {
    on<StartRosBagRecording>(_onStartRosBagRecordingEvent);
    on<ToggleRosTopic>(_onToggleRosTopicEvent);
  }
  FutureOr<void> _onToggleRosTopicEvent(
      ToggleRosTopic event, Emitter<RosbagState> emit) {
    // final updatedRosTopics = List<RosTopic>.from(rosTopics);
    if (!rosTopics.contains(event.rosTopic)) {
      rosTopics.add(event.rosTopic);
    } else {
      rosTopics.remove(event.rosTopic);
    }
    final updatedRosTopics = List<RosTopic>.from(rosTopics);

    emit(RosbagInitial(rosTopics: updatedRosTopics));
  }

  FutureOr<void> _onStartRosBagRecordingEvent(
      StartRosBagRecording event, Emitter<RosbagState> emit) async {
    RosBagRepository repository = RosBagRepository();
    repository.startRecording(event.name, rosTopics);
  }
}
