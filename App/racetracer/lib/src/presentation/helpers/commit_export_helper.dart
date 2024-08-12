import 'dart:io';

import 'package:intl/intl.dart';
import 'package:racetracer/src/domain/entries/git_comment.dart';
import 'package:racetracer/src/domain/entries/git_commit.dart';
import 'package:path_provider/path_provider.dart';

class CommitExportHelper {
  static String generateMarkdown({
    required GitCommit gitCommit,
    required List<GitComment> comments,
  }) {
    StringBuffer markdownContent = StringBuffer();

    markdownContent.writeln("# Comments\n");

    for (var comment in comments) {
      markdownContent.writeln(
          "## @${comment.author.username}, ${DateFormat('HH:mm:ss').format(comment.createdAt)}");
      markdownContent.writeln("<sub>${comment.author.name}</sub>");
      markdownContent.writeln("> ${comment.note}");
      markdownContent.writeln("\n---\n");
    }

    return markdownContent.toString();
  }

  static Future<void> exportToMarkdown({
    required GitCommit gitCommit,
    required List<GitComment> comments,
  }) async {
    String markdownContent =
        generateMarkdown(comments: comments, gitCommit: gitCommit);

    // Get the directory to save the file
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/commits.md';

    // Write the content to the file
    File file = File(filePath);
    await file.writeAsString(markdownContent);

    print('Markdown file saved to $filePath');
  }
}
