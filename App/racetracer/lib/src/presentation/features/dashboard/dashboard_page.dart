import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:racetracer/src/presentation/features/dashboard/widgets/nodes_widget.dart';
import 'package:racetracer/src/presentation/features/dashboard/widgets/topics_widget.dart';
import 'package:racetracer/src/presentation/features/test_session/test_sessions_page.dart';
import 'package:racetracer/src/presentation/widgets/stretched_button.dart';

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RosTopicsWidget(),
            const RosNodesWidget(),
            StretchedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                TestSessionsPage.routeName,
              ),
              child: Text(
                AppLocalizations.of(context)!.create_a_new_test_session,
              ),
            )
          ],
        ),
      ),
    );
  }
}
