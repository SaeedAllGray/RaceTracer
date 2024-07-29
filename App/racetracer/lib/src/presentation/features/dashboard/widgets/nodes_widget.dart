import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racetracer/src/application/ros_node/ros_node_bloc.dart';
import 'package:racetracer/src/presentation/features/dashboard/widgets/rounded_tile_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:racetracer/src/presentation/features/node/nodes_info_page.dart';
import 'package:racetracer/src/presentation/widgets/loading_widget.dart';

class RosNodesWidget extends StatelessWidget {
  const RosNodesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedTileWidget(
      onTap: () => Navigator.pushNamed(
        context,
        NodesInfoPage.routeName,
      ),
      title: AppLocalizations.of(context)!.nodes,
      child: BlocProvider(
        create: (context) => RosNodeBloc()..add(GetRosNodes()),
        child: BlocBuilder<RosNodeBloc, RosNodeState>(
          builder: (context, state) {
            if (state is RosNodesFetched) {
              return Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: state.rosNodes
                        .map((e) => Row(
                              children: [
                                const Icon(
                                  Icons.hub_outlined,
                                  size: 10,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: Text(
                                    e.name,
                                  ),
                                )
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
