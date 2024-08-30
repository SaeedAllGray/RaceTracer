import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racetracer/src/application/ros_topic/ros_topic_bloc.dart';
import 'package:racetracer/src/domain/entries/ros_topic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/features/topic/widgets/topic_message_bottom_sheet.dart';
import 'package:racetracer/src/presentation/widgets/loading_widget.dart';
import 'package:racetracer/src/presentation/widgets/outlined_text_field.dart';

class TopicsPage extends StatelessWidget {
  static const routeName = '/topics_page';
  final TextEditingController searchController = TextEditingController();
  TopicsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RosTopicBloc()..add(GetRosTopics()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.topics,
          ),
          bottom: PreferredSize(
            preferredSize: const Size(50, 50),
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: BlocBuilder<RosTopicBloc, RosTopicState>(
                builder: (context, state) {
                  return OutlinedTextField(
                    hintText: AppLocalizations.of(context)!.search,
                    controller: searchController,
                    onChanged: (v) =>
                        BlocProvider.of<RosTopicBloc>(context).add(
                      FilterTopics(searchTerm: searchController.text),
                    ),
                    onClearPressed: () =>
                        BlocProvider.of<RosTopicBloc>(context).add(
                      const FilterTopics(
                        searchTerm: '',
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        body: BlocBuilder<RosTopicBloc, RosTopicState>(
          builder: (context, state) {
            if (state is RosTopicsFetched) {
              return ListView.builder(
                itemCount: state.rosTopics.length,
                itemBuilder: (context, index) => ListTile(
                  leading: const Icon(Icons.adjust),
                  title: Text(state.rosTopics[index].name),
                  onTap: () {
                    showModalBottomSheet<void>(
                        isScrollControlled: true,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return TopicMessageBottomSheet(
                            rosTopic: state.rosTopics[index],
                          );
                        });
                  },
                ),
              );
            }
            return const LoadingWidget();
          },
        ),
      ),
    );
  }
}
