import 'package:flutter/material.dart';
import 'package:racetracer/src/domain/entries/git_commit.dart';
import 'package:racetracer/src/domain/entries/ros_topic.dart';
import 'package:racetracer/src/presentation/features/auth/auth_page.dart';
import 'package:racetracer/src/presentation/features/config/config_page.dart';
import 'package:racetracer/src/presentation/features/node/nodes_info_page.dart';
import 'package:racetracer/src/presentation/features/rosbag/rosbag_record_page.dart';
import 'package:racetracer/src/presentation/features/test_session/commit_detail_page.dart';
import 'package:racetracer/src/presentation/features/test_session/new_test_session_page.dart';
import 'package:racetracer/src/presentation/features/test_session/test_sessions_page.dart';
import 'package:racetracer/src/presentation/features/topic/topics_info_page.dart';
import 'package:racetracer/src/presentation/home/home_page.dart';
import 'package:racetracer/src/sample_feature/sample_item_details_view.dart';
import 'package:racetracer/src/settings/settings_controller.dart';
import 'package:racetracer/src/settings/settings_view.dart';

class AppRouter {
  final SettingsController settingsController;

  AppRouter(this.settingsController);

  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SettingsView.routeName:
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            return SettingsView(controller: settingsController);
          },
        );
      case SampleItemDetailsView.routeName:
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            return const SampleItemDetailsView();
          },
        );
      case HomePage.routeName:
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            return const HomePage();
          },
        );
      case TestSessionsPage.routeName:
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            return const TestSessionsPage();
          },
        );
      case NewTestSessionPage.routeName:
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            return const NewTestSessionPage();
          },
        );
      case CommitDetailPage.routeName:
        final GitCommit gitCommit = routeSettings.arguments as GitCommit;
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            return CommitDetailPage(
              gitCommit: gitCommit,
            );
          },
        );
      case RosbagRecordPage.routeName:
        final List<RosTopic> topics = routeSettings.arguments as List<RosTopic>;
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            return RosbagRecordPage(rosTopics: topics);
          },
        );
      case TopicsInfoPage.routeName:
        final List<RosTopic> topics = routeSettings.arguments as List<RosTopic>;
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            return TopicsInfoPage(rosTopics: topics);
          },
        );
      case NodesInfoPage.routeName:
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            return const NodesInfoPage();
          },
        );
      case AuthPage.routeName:
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            return const AuthPage();
          },
        );
      case ConfigPage.routeName:
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            return const ConfigPage();
          },
        );
      default:
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            return const AuthPage();
          },
        );
    }
  }
}
