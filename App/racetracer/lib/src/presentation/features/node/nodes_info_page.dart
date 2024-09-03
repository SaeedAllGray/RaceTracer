import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racetracer/src/application/ros_node/ros_node_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/constants/fonts.dart';
import 'package:racetracer/src/presentation/features/topic/widgets/in_out_widget.dart';
import 'package:racetracer/src/presentation/widgets/loading_widget.dart';

class NodesInfoPage extends StatelessWidget {
  static const routeName = '/nodes_Info';

  const NodesInfoPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.nodes),
        ),
        body: BlocProvider(
            create: (context) => RosNodeBloc()..add(GetRosNodesInfo()),
            child: BlocBuilder<RosNodeBloc, RosNodeState>(
              builder: (context, state) {
                if (state is RosNodesFetched) {
                  return ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: state.rosNodes.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(
                        state.rosNodes[index].name,
                        style: FontStyles.BLACK_MEDIUM_18,
                      ),
                      leading: const Icon(Icons.adjust),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('-'),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                            .publishing
                                            .toUpperCase(),
                                        style: FontStyles.TEAL_BOLD_10,
                                      )
                                    ],
                                  ),
                                  list: state.rosNodes[index].nodeInfo
                                          ?.publishing ??
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
                                            .subscribing
                                            .toUpperCase(),
                                        style: FontStyles.RED_BOLD_10,
                                      )
                                    ],
                                  ),
                                  list: state.rosNodes[index].nodeInfo
                                          ?.subscribing ??
                                      ['-'])
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }
                return LoadingWidget();
              },
            )));
  }
}
