import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:racetracer/src/application/git_diff/git_diff_bloc.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/constants/fonts.dart';
import 'package:racetracer/src/presentation/features/test_session/widgets/diff_viewer_widget.dart';
import 'package:racetracer/src/presentation/widgets/loading_widget.dart';
import 'package:racetracer/src/presentation/widgets/stretched_button.dart';

class NewTestSessionPage extends StatefulWidget {
  static const routeName = '/new_test_session_page';

  const NewTestSessionPage({super.key});

  @override
  State<NewTestSessionPage> createState() => _NewTestSessionPageState();
}

class _NewTestSessionPageState extends State<NewTestSessionPage> {
  TextEditingController commitMessageTextEditingController =
      TextEditingController();
  bool isCodeExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.new_session),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(context)!
                              .review_changes
                              .toUpperCase()),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isCodeExpanded = !isCodeExpanded;
                              });
                            },
                            child: Text(
                              isCodeExpanded
                                  ? AppLocalizations.of(context)!.collapse
                                  : AppLocalizations.of(context)!.expand,
                            ),
                          )
                        ],
                      ),
                    ),
                    // if (isCodeExpanded)
                    BlocProvider(
                      create: (context) => GitDiffBloc()..add(GetGitDiffs()),
                      child: BlocBuilder<GitDiffBloc, GitDiffState>(
                        builder: (context, state) {
                          if (state is GitDiffsFetched) {
                            return AnimatedContainer(
                              height: isCodeExpanded ? null : 300,
                              duration: const Duration(milliseconds: 500),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.white),
                              child: DiffViewerWidget(state.diff),
                            );
                          }
                          return const LoadingWidget();
                        },
                      ),
                    ),

                    // TODO: finalize this texts after proper RE
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context)!.commit_message),
                          TextField(
                            onChanged: (value) => setState(() {}),
                            controller: commitMessageTextEditingController,
                            minLines: 3,
                            maxLines: 5,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(6),
                              isDense: true,
                              hintText:
                                  AppLocalizations.of(context)!.commit_message,
                              hintStyle: FontStyles.LIGHTGREY_REGULAR_16,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: AppColors.lightGrey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: AppColors.blueGrey,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: AppColors.lightGrey,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Following actions will be performed:",
                            style: FontStyles.GREY_LIGHT_14,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "• Changes are commited and pushed into the branch \"Branch_name\".",
                          ),
                          const Text(
                            "• A new test session is created and associated with this commit.",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            StretchedButton(
              child: Text(
                  '${AppLocalizations.of(context)!.confirm} ${AppLocalizations.of(context)!.and_sign} ${AppLocalizations.of(context)!.continue_text}'),
            )
          ],
        ),
      ),
    );
  }
}
