import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racetracer/src/application/ros_topic/ros_topic_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:racetracer/src/domain/entries/ros_topic.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/constants/fonts.dart';
import 'package:racetracer/src/presentation/features/rosbag/rosbag_record_page.dart';
import 'package:racetracer/src/presentation/features/topic/widgets/in_out_widget.dart';
import 'package:racetracer/src/presentation/widgets/loading_widget.dart';

class TopicsInfoPage extends StatelessWidget {
  static const routeName = '/topics_Info';

  final List<RosTopic> rosTopics;

  const TopicsInfoPage({super.key, required this.rosTopics});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.topics),
        ),
        body: SafeArea(
          child: BlocProvider(
              create: (context) =>
                  RosTopicBloc()..add(GetTopicsInfo(topics: rosTopics)),
              child: BlocBuilder<RosTopicBloc, RosTopicState>(
                builder: (context, state) {
                  if (state is RosTopicsFetched) {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: state.rosTopics.length,
                            itemBuilder: (context, index) => ListTile(
                              title: Text(
                                state.rosTopics[index].name,
                                style: FontStyles.BLACK_MEDIUM_18,
                              ),
                              leading: const Icon(Icons.adjust),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.rosTopics[index].topicInfo?.type ??
                                      '-'),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InOutWidget(
                                          title: Row(
                                            children: [
                                              const Icon(
                                                Icons.north_east,
                                                color: AppColors.green,
                                                size: 10,
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .publishers
                                                    .toUpperCase(),
                                                style: FontStyles.TEAL_BOLD_10,
                                              )
                                            ],
                                          ),
                                          list: state.rosTopics[index].topicInfo
                                                  ?.publishers ??
                                              ['-']),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      InOutWidget(
                                          title: Row(
                                            children: [
                                              const Icon(
                                                Icons.south_east,
                                                color: AppColors.subscribers,
                                                size: 10,
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .subscribers
                                                    .toUpperCase(),
                                                style: FontStyles.RED_BOLD_10,
                                              )
                                            ],
                                          ),
                                          list: state.rosTopics[index].topicInfo
                                                  ?.subscribers ??
                                              ['-'])
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RosbagRecordPage.routeName,
                                  arguments: state.rosTopics);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.record,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return const LoadingWidget();
                },
              )),
        ));
  }
}
