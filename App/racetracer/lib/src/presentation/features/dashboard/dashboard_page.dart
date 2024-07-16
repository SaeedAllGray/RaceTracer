import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/features/dashboard/widgets/nodes_widget.dart';
import 'package:racetracer/src/presentation/features/dashboard/widgets/rounded_tile_widget.dart';
import 'package:racetracer/src/presentation/features/dashboard/widgets/topics_widget.dart';
import 'package:racetracer/src/presentation/features/topic/topics_info_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.dashboard,
        ),
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [RosNodesWidget(), RosTopicsWidget()],
          ),
        ],
      ),
    );
  }
}
