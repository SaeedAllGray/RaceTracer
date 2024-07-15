import 'dart:developer';

import 'package:racetracer/src/%20infrastructure/datasources/remote/ros_data_source.dart';
import 'package:racetracer/src/domain/entries/topic_info.dart';

class RosRepository {
  RosDataSource rosDataSource = RosDataSource();

  Future<List<String>> fetchTopics() async {
    List<dynamic> response = await rosDataSource.getTopics();
    log(response.toString());
    return response.map((e) => e.toString()).toList();
  }

  Future<TopicInfo> fetchTopicInfo(String topic) async {
    dynamic response = await rosDataSource.getTopicInfo(topic);
    log(response.toString());
    return TopicInfo.fromJson(response);
  }
}
