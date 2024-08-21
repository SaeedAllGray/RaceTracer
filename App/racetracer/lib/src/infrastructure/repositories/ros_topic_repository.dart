import 'package:racetracer/src/infrastructure/datasources/remote/ros_topic_data_source.dart';
import 'package:racetracer/src/domain/entries/ros_topic.dart';
import 'package:racetracer/src/domain/entries/topic_info.dart';

class RosTopicRepository {
  RosTopicDataSource rosDataSource = RosTopicDataSource();

  Future<List<RosTopic>> fetchTopics() async {
    List<dynamic> response = await rosDataSource.getTopics();
    return response.map((e) => RosTopic(name: e)).toList();
  }

  Future<TopicInfo> fetchTopicInfo(String topic) async {
    dynamic response = await rosDataSource.getTopicInfo(topic);
    return TopicInfo.fromJson(response);
  }

  Future<dynamic> fetchTopicMessage(String topic) async {
    dynamic response = await rosDataSource.getTopicMessage(topic);
    return response;
  }
}
