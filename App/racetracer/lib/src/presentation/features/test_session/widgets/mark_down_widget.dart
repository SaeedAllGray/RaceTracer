import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownWidget extends StatelessWidget {
  final String markdownData;

  MarkdownWidget({required this.markdownData});

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      selectable: true,
      data: markdownData,
      imageBuilder: (Uri uri, String? title, String? alt) {
        return CachedNetworkImage(
          // TODO: fix this hardcoded url

          imageUrl:
              "https://gitlab.fachschaften.org/-/project/3564" + uri.toString(),
          placeholder: (context, url) =>
              const CircularProgressIndicator.adaptive(),
          // TODO: Remove the hard-coded token
          httpHeaders: {'PRIVATE-TOKEN': 'gePyX2VcuPx1aZLSk8_K'},
          // errorWidget: (context, url, error) => const Icon(Icons.error),
        );
      },
    );
  }
}
