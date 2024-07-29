import 'package:flutter/material.dart';
import 'package:racetracer/src/application/ros_topic/ros_topic_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racetracer/src/presentation/features/dashboard/widgets/rounded_tile_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:racetracer/src/presentation/widgets/loading_widget.dart';

class RosTopicsWidget extends StatelessWidget {
  const RosTopicsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedTileWidget(
      title: AppLocalizations.of(context)!.topics,
      child: BlocProvider(
        create: (context) => RosTopicBloc()..add(GetRosTopics()),
        child: BlocBuilder<RosTopicBloc, RosTopicState>(
          builder: (context, state) {
            if (state is RosTopicsFetched) {
              return Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: state.rosTopics
                        .map((e) => Row(
                              children: [
                                const Icon(
                                  Icons.adjust,
                                  size: 10,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(e.name)
                              ],
                            ))
                        .toList(),
                  ),
                ],
              );
            }
            return const LoadingWidget();
          },
        ),
      ),
    );
  }
}
