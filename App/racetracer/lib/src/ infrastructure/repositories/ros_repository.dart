import 'dart:developer';

import 'package:racetracer/src/%20infrastructure/datasources/remote/ros_data_source.dart';

class RosRepository {
  RosDataSource rosDataSource = RosDataSource();
  @override
  Future<List<String>> fetchTopics() async {
    List<dynamic> response = await rosDataSource.getTopics();
    log(response.toString());
    return [];
  }
}
