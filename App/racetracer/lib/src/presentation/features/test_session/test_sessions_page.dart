import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:racetracer/src/application/git_commit/test_session_bloc.dart';
import 'package:racetracer/src/presentation/constants/fonts.dart';
import 'package:racetracer/src/presentation/features/test_session/commit_detail_page.dart';
import 'package:racetracer/src/presentation/features/test_session/test_session_page.dart';
import 'package:racetracer/src/presentation/widgets/loading_widget.dart';

class TestSessionsPage extends StatelessWidget {
  static const routeName = '/test_sessions';

  const TestSessionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GitCommitBloc()..add(GetGitCommits()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.test_sessions),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(
              context,
              NewTestSessionPage.routeName,
            );
          },
        ),
        body: BlocBuilder<GitCommitBloc, GitCommitState>(
          builder: (context, state) {
            if (state is GitCommitsFetched) {
              return ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                // padding: const EdgeInsets.all(10),
                itemCount: state.gitCommits.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      CommitDetailPage.routeName,
                      arguments: state.gitCommits[index],
                    );
                  },
                  leading: const Icon(Icons.commit),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  title: Text(
                    state.gitCommits[index].title.toString(),
                    style: FontStyles.BLACK_REGULAR_16,
                  ),
                  subtitle: Text(
                    DateFormat('dd.MM.yyyy, HH:mm')
                        .format(state.gitCommits[index].createdAt),
                  ),
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
