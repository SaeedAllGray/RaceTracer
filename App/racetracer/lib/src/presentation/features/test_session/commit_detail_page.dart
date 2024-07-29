import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:racetracer/src/application/git_commit/test_session_bloc.dart';
import 'package:racetracer/src/domain/entries/git_commit.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/constants/fonts.dart';
import 'package:racetracer/src/presentation/features/test_session/widgets/chat_bubble.dart';
import 'package:racetracer/src/presentation/widgets/loading_widget.dart';

class CommitDetailPage extends StatefulWidget {
  final GitCommit gitCommit;
  static const routeName = '/commit_detail_page';

  const CommitDetailPage({super.key, required this.gitCommit});

  @override
  State<CommitDetailPage> createState() => _CommitDetailPageState();
}

class _CommitDetailPageState extends State<CommitDetailPage> {
  final TextEditingController messageTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GitCommitBloc()
        ..add(GetGitCommitComments(gitCommit: widget.gitCommit)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.documentation),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<GitCommitBloc, GitCommitState>(
                  builder: (context, state) {
                    if (state is GitCommitCommentsFetched) {
                      return ListView.builder(
                        itemCount: state.gitComments.length,
                        padding: const EdgeInsets.all(10),
                        itemBuilder: (context, index) => ChatBubble(
                          gitComment: state.gitComments[index],
                        ),
                      );
                    }
                    return const LoadingWidget();
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        shape: const CircleBorder(),
                      ),
                      onPressed: () {},
                      child: const Icon(Icons.photo_camera_rounded),
                    ),
                    Expanded(
                      child: TextField(
                        controller: messageTextEditingController,
                        minLines: 1,
                        maxLines: 5,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(6),
                          isDense: true,
                          hintText: AppLocalizations.of(context)!.log_a_message,
                          hintStyle: FontStyles.LIGHTGREY_REGULAR_16,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: AppColors.lightGrey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: AppColors.blueGrey,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: AppColors.lightGrey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(shape: const CircleBorder()),
                      onPressed: () {},
                      child: const Icon(Icons.send),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
