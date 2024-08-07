import 'package:flutter/material.dart';
import 'package:racetracer/src/domain/entries/git_commit.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/constants/fonts.dart';
import 'package:racetracer/src/presentation/helpers/token_helper.dart';
import 'package:racetracer/src/presentation/widgets/stretched_button.dart';
import 'package:url_launcher/url_launcher.dart';

class CommitDetailActionBottomSheet extends StatelessWidget {
  final GitCommit gitCommit;
  const CommitDetailActionBottomSheet({super.key, required this.gitCommit});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.70,
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
        // height: 800,
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: SafeArea(
            child: Column(
          children: [
            Text(
              gitCommit.title,
              style: FontStyles.BLACK_BOLD_18,
            ),
            StretchedButton(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text("View changes on GitLab"),
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
              child: Text("View changes on GitLab"),
              onPressed: () async {
                await launchUrl(Uri.parse(
                  gitCommit.webUrl,
                  // ,webViewConfiguration: WebViewConfiguration(
                  //     headers: TokenHelper.getHeaderToken
                ));
              },
            )
          ],
        )),
      ),
    );
  }
}
