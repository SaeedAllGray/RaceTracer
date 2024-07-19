import 'dart:developer';

import 'package:racetracer/src/%20infrastructure/datasources/remote/ros_node_data_source.dart';
import 'package:racetracer/src/%20infrastructure/datasources/remote/rosbag_data_source.dart';
import 'package:racetracer/src/domain/entries/ros_node.dart';
import 'package:racetracer/src/domain/entries/ros_topic.dart';

class RosBagRepository {
  RosBagDataSource rosDataSource = RosBagDataSource();

  Future<void> startRecording(String name, List<RosTopic> topics) async {
    List<dynamic> response = await rosDataSource.startRecordingTopics(
        name: name,
        topics: topics
            .map(
              (e) => e.name,
            )
            .toList());
    // return response.map((e) => RosNode(name: e)).toList();
  }

  Future<List<RosNode>> stopRecording() async {
    List<dynamic> response = await rosDataSource.stopRecording();
    log(response.toString());
    return response.map((e) => RosNode.fromJson(e)).toList();
  }
}
