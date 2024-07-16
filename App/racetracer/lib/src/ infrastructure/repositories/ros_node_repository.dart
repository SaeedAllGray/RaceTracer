import 'dart:developer';

import 'package:racetracer/src/%20infrastructure/datasources/remote/ros_node_data_source.dart';
import 'package:racetracer/src/%20infrastructure/datasources/remote/ros_topic_data_source.dart';
import 'package:racetracer/src/domain/entries/ros_node.dart';
import 'package:racetracer/src/domain/entries/ros_topic.dart';
import 'package:racetracer/src/domain/entries/topic_info.dart';

class RosNodeRepository {
  RosNodeDataSource rosDataSource = RosNodeDataSource();

  Future<List<RosNode>> fetchEntities() async {
    List<dynamic> response = await rosDataSource.getNodes();
    return response.map((e) => RosNode(name: e)).toList();
  }

  // Future<TopicInfo> fetchTopicInfo(String topic) async {
  //   dynamic response = await rosDataSource.getTopicInfo(topic);
  //   log(response.toString());
  //   return TopicInfo.fromJson(response);
  // }
}
