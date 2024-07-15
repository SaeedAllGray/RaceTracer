import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racetracer/src/application/ros/ros_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:racetracer/src/presentation/constants/fonts.dart';

class TopicInfoWidget extends StatelessWidget {
  final String topic;

  const TopicInfoWidget({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(topic),
        ),
        body: BlocProvider(
            create: (context) => RosBloc()..add(GetTopicInfo(topic: topic)),
            child: BlocBuilder<RosBloc, RosState>(
              builder: (context, state) {
                if (state is TopicInfoFetched) {
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
