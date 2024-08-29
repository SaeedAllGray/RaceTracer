import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_view/json_view.dart';
import 'package:racetracer/src/application/ros_topic/ros_topic_bloc.dart';
import 'package:racetracer/src/domain/entries/ros_topic.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/widgets/loading_widget.dart';

class TopicMessageBottomSheet extends StatelessWidget {
  final RosTopic rosTopic;
  const TopicMessageBottomSheet({super.key, required this.rosTopic});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RosTopicBloc()..add(GetRosTopicMessage(topic: rosTopic)),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.70,
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          // height: 800,
          decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: SafeArea(
            child: Column(
              children: [
                TextButton(
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.horizontal_rule_rounded,
                      size: 40,
                    )),
                Expanded(
                  child: BlocBuilder<RosTopicBloc, RosTopicState>(
                      builder: (context, state) {
                    if (state is RosTopicMessageFetched) {
                      log(state.message.toString());
                      log("state.message.toString()");
                      return JsonConfig(
                          data: JsonConfigData(
                              style: const JsonStyleScheme(
                                keysStyle: TextStyle(
                                  fontFamily: "Courier",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                valuesStyle: TextStyle(
                                  fontFamily: "Courier",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              color: const JsonColorScheme(
                                  normalColor: AppColors.BLACK)),
                          child: JsonView(
                            json: state.message,
                          ));
                    }
                    return const LoadingWidget();
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
