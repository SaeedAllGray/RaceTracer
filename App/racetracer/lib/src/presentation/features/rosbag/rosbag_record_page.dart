import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racetracer/src/application/rosbag/rosbag_bloc.dart';
import 'package:racetracer/src/domain/entries/ros_topic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RosbagRecordPage extends StatelessWidget {
  static const routeName = '/rosbag';

  final List<RosTopic> rosTopics;
  const RosbagRecordPage({super.key, required this.rosTopics});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RosbagBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.rosbag),
        ),
        body: SafeArea(
          child: Column(
            children: [
              BlocBuilder<RosbagBloc, RosbagState>(
                builder: (context, state) {
                  if (state is RosbagInitial) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: rosTopics.length,
                        itemBuilder: (context, index) =>
                            CheckboxListTile.adaptive(
                          value: state.rosTopics.contains(rosTopics[index]),
                          onChanged: (value) {
                            BlocProvider.of<RosbagBloc>(context).add(
                                ToggleRosTopic(rosTopic: rosTopics[index]));
                          },
                          title: Text(rosTopics[index].name),
                        ),
                      ),
                    );
                  }
                  return const CircularProgressIndicator.adaptive();
                },
              ),
              BlocBuilder<RosbagBloc, RosbagState>(
                builder: (context, state) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<RosbagBloc>(context)
                            .add(StartRosBagRecording(name: 'his'));
                      },
                      child: Text(
                        AppLocalizations.of(context)!.record,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
