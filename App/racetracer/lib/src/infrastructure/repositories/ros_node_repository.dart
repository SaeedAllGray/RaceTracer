import 'dart:developer';

import 'package:racetracer/src/infrastructure/datasources/remote/ros_node_data_source.dart';
import 'package:racetracer/src/domain/entries/ros_node.dart';

class RosNodeRepository {
  RosNodeDataSource rosDataSource = RosNodeDataSource();

  Future<List<RosNode>> fetchEntities() async {
    List<dynamic> response = await rosDataSource.getNodes();
    return response.map((e) => RosNode(name: e)).toList();
  }

  Future<List<RosNode>> fetchNodesInfo() async {
    List<dynamic> response = await rosDataSource.getNodesInfo();
    log(response.toString());
    return response.map((e) => RosNode.fromJson(e)).toList();
  }
}
