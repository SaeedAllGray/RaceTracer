import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:racetracer/src/application/git_commit/git_commit_bloc.dart';
import 'package:racetracer/src/application/upload_file/upload_file_bloc.dart';
import 'package:racetracer/src/domain/entries/git_commit.dart';
import 'package:racetracer/src/domain/entries/uploaded_file.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/constants/fonts.dart';
import 'package:racetracer/src/presentation/features/test_session/widgets/chat_bubble.dart';
import 'package:racetracer/src/presentation/helpers/token_helper.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GitCommitBloc()
            ..add(GetGitCommitComments(gitCommit: widget.gitCommit)),
        ),
        BlocProvider(
          create: (context) => UploadFileBloc(),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.documentation),
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Scaffold();
                      });
                },
                icon: Icon(Icons.info_outline_rounded))
          ],
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
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        reverse: true,
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
                child: Column(
                  children: [
                    BlocBuilder<UploadFileBloc, UploadFileState>(
                      builder: (context, state) {
                        if (state is UploadFileCompleted &&
                            state.uploadedFiles.isNotEmpty) {
                          return SizedBox(
                            height: 80,
                            child: ListView.separated(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                width: 5,
                              ),
                              itemCount: state.uploadedFiles.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: CachedNetworkImage(
                                          httpHeaders:
                                              TokenHelper.getHeaderToken,
                                          imageUrl:
                                              "https://gitlab.fachschaften.org/" +
                                                  state.uploadedFiles[index]
                                                      .fullPath),
                                    ),
                                    Positioned(
                                      top: 2,
                                      left: 2,
                                      child: SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              backgroundColor: AppColors.white
                                                  .withOpacity(0.9),
                                              iconColor: AppColors.BLACK,
                                              shape: const CircleBorder()),
                                          child:
                                              const Icon(Icons.close_rounded),
                                          onPressed: () {
                                            BlocProvider.of<UploadFileBloc>(
                                                    context)
                                                .add(
                                              RemoveImage(
                                                uploadedFile:
                                                    state.uploadedFiles[index],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 60,
                          child: BlocBuilder<UploadFileBloc, UploadFileState>(
                            builder: (context, state) {
                              if (state is UploadFileInProgress) {
                                return const LoadingWidget();
                              }
                              return TextButton(
                                style: TextButton.styleFrom(
                                  shape: const CircleBorder(),
                                ),
                                onPressed: () {},
                                child: PopupMenuButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  icon: const Icon(Icons.attach_file_rounded),
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuEntry>[
                                    PopupMenuItem(
                                      child: Text(
                                          AppLocalizations.of(context)!.camera),
                                      onTap: () {
                                        BlocProvider.of<UploadFileBloc>(context)
                                            .add(UploadImageFroomCamera());
                                      },
                                    ),
                                    PopupMenuItem(
                                      child: Text(AppLocalizations.of(context)!
                                          .library),
                                      onTap: () {
                                        BlocProvider.of<UploadFileBloc>(context)
                                            .add(UploadImageFromLibrary());
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            onChanged: (value) => setState(() {}),
                            controller: messageTextEditingController,
                            minLines: 1,
                            maxLines: 5,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(6),
                              isDense: true,
                              hintText:
                                  AppLocalizations.of(context)!.log_a_message,
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
                        BlocBuilder<UploadFileBloc, UploadFileState>(
                          builder: (context, uploadFileState) {
                            return BlocBuilder<GitCommitBloc, GitCommitState>(
                              builder: (context, gitCommitState) {
                                return OutlinedButton(
                                  style: TextButton.styleFrom(
                                      shape: const CircleBorder()),
                                  onPressed: uploadFileState
                                              is UploadFileInProgress ||
                                          (uploadFileState
                                                      is UploadFileCompleted &&
                                                  uploadFileState
                                                      .uploadedFiles.isEmpty) &&
                                              messageTextEditingController
                                                  .text.isEmpty
                                      ? null
                                      : () {
                                          List<UploadedFile> uploadedFiles = [];
                                          if (uploadFileState
                                              is UploadFileCompleted) {
                                            uploadedFiles =
                                                uploadFileState.uploadedFiles;
                                          }
                                          BlocProvider.of<GitCommitBloc>(
                                                  context)
                                              .add(
                                            PostGitCommitComment(
                                              gitCommit: widget.gitCommit,
                                              note: messageTextEditingController
                                                  .text,
                                              uploadedFiles: uploadedFiles,
                                            ),
                                          );
                                          messageTextEditingController.clear();
                                          BlocProvider.of<UploadFileBloc>(
                                                  context)
                                              .add(ClearFiles());
                                        },
                                  child: const Icon(Icons.arrow_upward_rounded),
                                );
                              },
                            );
                          },
                        ),
                      ],
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
