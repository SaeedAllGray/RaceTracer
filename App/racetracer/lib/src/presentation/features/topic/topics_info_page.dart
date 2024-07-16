import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racetracer/src/application/ros_topic/ros_topic_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:racetracer/src/domain/entries/ros_topic.dart';
import 'package:racetracer/src/presentation/constants/fonts.dart';

class TopicsInfoPage extends StatelessWidget {
  static const routeName = '/topics_Info';

  final RosTopic rosTopic;

  const TopicsInfoPage({super.key, required this.rosTopic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(rosTopic.name),
        ),
        body: BlocProvider(
            create: (context) =>
                RosTopicBloc()..add(GetTopicInfo(topic: rosTopic.name)),
            child: BlocBuilder<RosTopicBloc, RosTopicState>(
              builder: (context, state) {
                if (state is RosTopicInfoFetched) {
                  return ListView(
                    padding: const EdgeInsets.all(10),
                    children: [
                      Text(
                        AppLocalizations.of(context)!.type,
                        style: FontStyles.BLACK_BOLD_24,
                      ),
                      Text(
                        state.topicInfo.type,
                        style: FontStyles.BLACK_REGULAR_18,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        AppLocalizations.of(context)!.publishers,
                        style: FontStyles.BLACK_BOLD_24,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: state.topicInfo.publishers
                            .map(
                              (e) => Text(
                                "• " + e,
                                style: FontStyles.BLACK_REGULAR_18,
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        AppLocalizations.of(context)!.subscribers,
                        style: FontStyles.BLACK_BOLD_24,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: state.topicInfo.subscribers
                            .map(
                              (e) => Text(
                                "• " + e,
                                style: FontStyles.BLACK_REGULAR_18,
                              ),
                            )
                            .toList(),
                      )
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )));
  }
}
