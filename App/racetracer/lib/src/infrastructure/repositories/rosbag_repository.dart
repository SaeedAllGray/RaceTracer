import 'package:racetracer/src/infrastructure/datasources/remote/rosbag_data_source.dart';
import 'package:racetracer/src/domain/entries/ros_topic.dart';

class RosBagRepository {
  RosBagDataSource rosDataSource = RosBagDataSource();

  Future<List<RosTopic>> startRecording(
      String name, List<RosTopic> topics) async {
    List<dynamic> response = await rosDataSource.startRecordingTopics(
        name: name,
        topics: topics
            .map(
              (e) => e.name,
            )
            .toList());
    // print(response.map((e) => RosTopic(name: e)).toList());
    return response.map((e) => RosTopic(name: e)).toList();
  }

  Future<void> stopRecording() async {
    List<dynamic> response = await rosDataSource.stopRecording();
    // return response.map((e) => RosNode.fromJson(e)).toList();
  }
}
