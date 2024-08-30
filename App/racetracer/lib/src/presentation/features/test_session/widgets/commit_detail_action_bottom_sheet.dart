import 'package:flutter/material.dart';
import 'package:racetracer/src/domain/entries/git_comment.dart';
import 'package:racetracer/src/domain/entries/git_commit.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/constants/fonts.dart';
import 'package:racetracer/src/presentation/helpers/commit_export_helper.dart';
import 'package:racetracer/src/presentation/helpers/token_helper.dart';
import 'package:racetracer/src/presentation/widgets/rounded_bottom_sheet.dart';
import 'package:racetracer/src/presentation/widgets/stretched_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommitDetailActionBottomSheet extends StatelessWidget {
  final GitCommit gitCommit;
  final List<GitComment> gitComments;
  const CommitDetailActionBottomSheet(
      {super.key, required this.gitCommit, required this.gitComments});

  @override
  Widget build(BuildContext context) {
    return RoundedBottomSheet(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.commit),
            title: Text(
              gitCommit.title,
              style: FontStyles.BLACK_BOLD_18,
            ),
            subtitle: Text(
              gitCommit.message,
            ),
          ),
          StretchedButton(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(AppLocalizations.of(context)!.view_changes_on_gitlab),
            onPressed: () async {
              await launchUrl(Uri.parse(
                gitCommit.webUrl,
                // ,webViewConfiguration: WebViewConfiguration(
                //     headers: TokenHelper.getHeaderToken
              ));
            },
          ),
          StretchedButton(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Text(AppLocalizations.of(context)!.update_documentation),
            onPressed: () async {
              CommitExportHelper.updateDocumentation(
                  gitCommit: gitCommit, comments: gitComments);
            },
          ),
        ],
      ),
    );
  }
}
