import 'dart:developer';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:racetracer/src/domain/entries/git_comment.dart';
import 'package:racetracer/src/domain/entries/git_commit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:racetracer/src/infrastructure/datasources/remote/git_file_data_source.dart';
import 'package:racetracer/src/presentation/constants/api_constant.dart';

class CommitExportHelper {
  static String replaceLocalImagePaths(String text) {
    final RegExp imageRegExp = RegExp(r'!\[([^\]]*)\]\((\/uploads\/[^\)]+)\)');
    return text.replaceAllMapped(imageRegExp, (match) {
      final altText = match.group(1);
      final localPath = match.group(2);
      final url = '${ApiConstants.projectUrl}$localPath';
      return '![${altText ?? ''}]($url)';
    });
  }

  static String generateMarkdown({
    required GitCommit gitCommit,
    required List<GitComment> comments,
  }) {
    StringBuffer markdownContent = StringBuffer();
    markdownContent.writeln(
        "# Commit on ${DateFormat('dd.MM.yyyy').format(gitCommit.committedDate)} at ${DateFormat('HH:mm:ss').format(gitCommit.committedDate)}.\n");
    markdownContent.writeln("### ${gitCommit.title}");
    markdownContent.writeln("${gitCommit.message}");
    markdownContent.writeln("[View changed files](${gitCommit.webUrl})\n");

    markdownContent.writeln("# Comments\n");

    for (var comment in comments) {
      String processedNote = replaceLocalImagePaths(comment.note);

      markdownContent.writeln(
          "## @${comment.author.username}, ${DateFormat('HH:mm:ss').format(comment.createdAt)}");
      markdownContent.writeln("<sub>${comment.author.name}</sub>");
      markdownContent.writeln("> $processedNote");
      markdownContent.writeln("\n---\n");
    }

    return markdownContent.toString();
  }

  static Future<void> updateDocumentation({
    required GitCommit gitCommit,
    required List<GitComment> comments,
  }) async {
    String markdownContent =
        generateMarkdown(comments: comments, gitCommit: gitCommit);

    GitFileDataSource gitFileDataSource = GitFileDataSource();
    try {
      await gitFileDataSource.updateFile(
          gitCommit.committedDate.toString(), markdownContent);
    } catch (e) {
      await gitFileDataSource.pushFile(
          gitCommit.committedDate.toString(), markdownContent);
      log(e.toString());
    }
  }
}
