import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racetracer/src/application/ros_topic/ros_topic_bloc.dart';
import 'package:racetracer/src/domain/entries/ros_topic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/features/topic/widgets/topic_message_bottom_sheet.dart';
import 'package:racetracer/src/presentation/widgets/loading_widget.dart';

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
                  return TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.search,
                        fillColor: AppColors.primary.withOpacity(0.15),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppColors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppColors.white,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            BlocProvider.of<RosTopicBloc>(context)
                                .add(const FilterTopics(searchTerm: ''));
                            searchController.clear();
                          },
                          icon: const Icon(Icons.clear),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10)),
                    onChanged: (v) => BlocProvider.of<RosTopicBloc>(context)
                        .add(FilterTopics(searchTerm: searchController.text)),
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
