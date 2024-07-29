import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:racetracer/src/domain/entries/git_comment.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/features/test_session/widgets/mark_down_widget.dart';

class ChatBubble extends StatelessWidget {
  final GitComment gitComment;
  const ChatBubble({super.key, required this.gitComment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.bubble, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              color: AppColors.white.withOpacity(0.4),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(gitComment.author.name),
                Text(DateFormat('dd.MM.yyyy, HH:mm')
                    .format(gitComment.createdAt))
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: MarkdownWidget(
                markdownData: gitComment.note,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
