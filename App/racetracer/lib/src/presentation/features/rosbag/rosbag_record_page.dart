import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racetracer/src/application/rosbag/rosbag_bloc.dart';
import 'package:racetracer/src/domain/entries/ros_topic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/features/rosbag/widgets/blinking_icon.dart';
import 'package:racetracer/src/presentation/widgets/loading_widget.dart';

class RosbagRecordPage extends StatefulWidget {
  static const routeName = '/rosbag';
  final List<RosTopic> rosTopics;
  const RosbagRecordPage({super.key, required this.rosTopics});

  @override
  State<RosbagRecordPage> createState() => _RosbagRecordPageState();
}

class _RosbagRecordPageState extends State<RosbagRecordPage> {
  final TextEditingController rosbagNameTextEditingController =
      TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    rosbagNameTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RosbagBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.rosbag),
        ),
        body: SafeArea(
          child: BlocBuilder<RosbagBloc, RosbagState>(
            builder: (context, state) {
              if (state is RosbagInitial) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        onChanged: (value) => setState(() {}),
                        controller: rosbagNameTextEditingController,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.name,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: AppColors.primaryPale,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: AppColors.primaryPale,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: widget.rosTopics.length,
                        itemBuilder: (context, index) =>
                            CheckboxListTile.adaptive(
                          value:
                              state.rosTopics.contains(widget.rosTopics[index]),
                          onChanged: (value) {
                            BlocProvider.of<RosbagBloc>(context).add(
                                ToggleRosTopic(
                                    rosTopic: widget.rosTopics[index]));
                          },
                          title: Text(widget.rosTopics[index].name),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: rosbagNameTextEditingController
                                .text.isNotEmpty
                            ? () {
                                BlocProvider.of<RosbagBloc>(context).add(
                                    StartRosBagRecording(
                                        name: rosbagNameTextEditingController
                                            .text));
                              }
                            : null,
                        child: Text(
                          AppLocalizations.of(context)!.record,
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is RosbagRecordingStarted) {
                return Column(
                  children: [
                    ListTile(
                      leading: const BlinkingIcon(
                        icon: Icons.radio_button_checked,
                        size: 20,
                        color: Colors.red,
                      ),
                      title: Text(AppLocalizations.of(context)!.recording),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.rosTopics.length,
                        itemBuilder: (context, index) => ListTile(
                          leading: const Icon(Icons.adjust),
                          title: Text(state.rosTopics[index].name),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ActionSlider.standard(
                        width: 280,
                        sliderBehavior: SliderBehavior.stretch,
                        toggleColor: AppColors.subscribers,
                        icon: const Icon(Icons.pause_circle),
                        child:
                            Text(AppLocalizations.of(context)!.stop_recording),
                        action: (controller) async {
                          BlocProvider.of<RosbagBloc>(context)
                              .add(StopRosBagRecording());
                          controller.loading();
                          await Future.delayed(const Duration(seconds: 1));
                          controller.success();
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Recording has been saved."),
                          ));
                        },
                      ),
                    )
                  ],
                );
              }
              return const LoadingWidget();
            },
          ),
        ),
      ),
    );
  }
}
