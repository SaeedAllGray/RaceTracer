import 'dart:convert';

import 'package:deep_pick/deep_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_view/json_view.dart';
import 'package:racetracer/src/application/ros_topic/ros_topic_bloc.dart';
import 'package:racetracer/src/domain/entries/ros_topic.dart';
import 'package:racetracer/src/domain/entries/value_object.dart';
import 'package:racetracer/src/infrastructure/datasources/local/value_object_local_data_source.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/constants/fonts.dart';
import 'package:racetracer/src/presentation/helpers/value_object_helper.dart';
import 'package:racetracer/src/presentation/widgets/loading_widget.dart';
import 'package:racetracer/src/presentation/widgets/rounded_bottom_sheet.dart';
import 'package:racetracer/src/presentation/widgets/stretched_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopicMessageBottomSheet extends StatefulWidget {
  final RosTopic rosTopic;
  const TopicMessageBottomSheet({super.key, required this.rosTopic});

  @override
  State<TopicMessageBottomSheet> createState() =>
      _TopicMessageBottomSheetState();
}

class _TopicMessageBottomSheetState extends State<TopicMessageBottomSheet> {
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, top: 60),
      child: BlocProvider(
        create: (context) =>
            RosTopicBloc()..add(GetRosTopicMessage(topic: widget.rosTopic)),
        child: RoundedBottomSheet(
          child: Scaffold(
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.rosTopic.name,
                  style: FontStyles.BLACK_BOLD_18,
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: BlocBuilder<RosTopicBloc, RosTopicState>(
                    builder: (context, state) {
                      if (state is RosTopicMessageFetched) {
                        return Column(
                          children: [
                            Expanded(
                              child: JsonConfig(
                                data: JsonConfigData(
                                    style: const JsonStyleScheme(
                                      keysStyle: FontStyles.CODE_REGULAR_16,
                                      valuesStyle: FontStyles.CODE_REGULAR_16,
                                      // openAtStart: true,
                                    ),
                                    color: const JsonColorScheme(
                                        normalColor: AppColors.BLACK)),
                                child: JsonView(
                                  json: state.message,
                                ),
                              ),
                            ),
                            TextField(
                              onChanged: (value) => setState(() {}),
                              controller: codeController,
                              style: FontStyles.CODE_REGULAR_16,
                              decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.lightGrey,
                                  border: InputBorder.none,
                                  hintText: "Enter the address of the value"),
                            ),
                            StretchedButton(
                              onPressed: ValueObjectHelper.isValid(
                                      codeController.text, state.message)
                                  ? () {
                                      try {
                                        ValueObjectLocalDataSource()
                                            .writeEntity(
                                          ValueObject(
                                            topic: widget.rosTopic.name,
                                            valueKey: codeController.text,
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content:
                                              Text("Watch List is updated."),
                                        ));
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text("Error!"),
                                        ));
                                      }
                                    }
                                  : null,
                              child:
                                  Text(AppLocalizations.of(context)!.observe),
                            )
                          ],
                        );
                      }
                      return const LoadingWidget();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
