import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:racetracer/src/application/attribute_diff/attribute_diff_bloc.dart';
import 'package:racetracer/src/application/ros_topic/ros_topic_bloc.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/constants/fonts.dart';
import 'package:racetracer/src/presentation/features/test_session/chat_page.dart';
import 'package:racetracer/src/presentation/widgets/stretched_button.dart';

class NewTestSessionPage extends StatelessWidget {
  static const routeName = '/new_test_session_page';

  const NewTestSessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: AttributeDiffBloc()..add(GetAttributeDiffs()),
        ),
        BlocProvider.value(
          value: RosTopicBloc()..add(GetRosTopics()),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.documentation),
        ),
        body: BlocBuilder<AttributeDiffBloc, AttributeDiffState>(
          builder: (context, state) {
            if (state is AttributeDiffsFetched) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!
                        .incoming_changes
                        .toUpperCase()),
                    Column(
                      children: state.attributeDiffs
                          .map(
                            (e) => Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.white),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.lightGrey
                                            .withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(4)),
                                    padding: const EdgeInsets.all(3),
                                    // margin: const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      e.attribute,
                                      style: FontStyles.BLACK_MEDIUM_16,
                                    ),
                                  ),
                                  const Text(
                                    ":",
                                    style: FontStyles.BLACK_MEDIUM_16,
                                  ),
                                  const Spacer(),
                                  Container(
                                    decoration: BoxDecoration(
                                        color:
                                            AppColors.warning.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(4)),
                                    padding: const EdgeInsets.all(3),
                                    // margin: const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      e.oldValue.toString(),
                                      style: FontStyles.BLACK_MEDIUM_16,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.arrow_right_alt_rounded,
                                    color: AppColors.blueGrey,
                                  ),
                                  const Spacer(),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.newChanges
                                            .withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(4)),
                                    padding: const EdgeInsets.all(3),
                                    // margin: const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      e.oldValue.toString(),
                                      style: FontStyles.BLACK_MEDIUM_16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    StretchedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          ChatPage.routeName,
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.start_test_session,
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
        ),
      ),
    );
  }
}
