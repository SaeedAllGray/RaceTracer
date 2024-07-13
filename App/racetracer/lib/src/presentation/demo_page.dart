import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  Dio dio = Dio();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Start Turtle"),
              onPressed: () async {
                try {
                  var res = await dio.post(
                    'http://192.168.64.3:8000/ros/start_ros_node/',
                    data: FormData.fromMap({
                      "package_name": "turtlesim",
                      "node_name": "turtlesim_node"
                    }),
                    options: Options(
                      headers: {
                        HttpHeaders.contentTypeHeader: 'application/json',
                      },
                    ),
                  );
                  print(res);
                } catch (e) {
                  print(e);
                }
              },
            ),
            ElevatedButton(
              child: Text("Stop Turtle"),
              onPressed: () async {
                try {
                  var res = await dio.post(
                    'http://192.168.64.3:8000/ros/stop_ros_node/',
                    data: FormData.fromMap({"node_name": "turtlesim"}),
                    options: Options(
                      headers: {
                        HttpHeaders.contentTypeHeader: 'application/json',
                      },
                    ),
                  );
                  print(res);
                } catch (e) {
                  print(e);
                }
              },
            ),
            ElevatedButton(
              child: Text("Start Recording"),
              onPressed: () async {
                try {
                  var res = await dio.post(
                    'http://192.168.64.3:8000/ros/start_rosbag_recording/',
                    data: FormData.fromMap(
                        {"topic": "cmd_vel", "bag_name": "test"}),
                    options: Options(
                      headers: {
                        HttpHeaders.contentTypeHeader: 'application/json',
                      },
                    ),
                  );
                  print(res);
                } catch (e) {
                  print(e);
                }
              },
            ),
            ElevatedButton(
              child: Text("Stop Recording"),
              onPressed: () async {
                try {
                  var res = await dio.post(
                    'http://192.168.64.3:8000/ros/stop_rosbag_recording/',
                    data: FormData.fromMap(
                        {"topic": "cmd_vel", "bag_name": "test"}),
                    options: Options(
                      headers: {
                        HttpHeaders.contentTypeHeader: 'application/json',
                      },
                    ),
                  );
                  print(res);
                } catch (e) {
                  print(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
