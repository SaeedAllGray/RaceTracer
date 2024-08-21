import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:racetracer/src/presentation/constants/api_constant.dart';
import 'package:racetracer/src/presentation/helpers/token_helper.dart';

class MarkdownWidget extends StatelessWidget {
  final String markdownData;

  MarkdownWidget({required this.markdownData});

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      selectable: true,
      data: markdownData,
      imageBuilder: (Uri uri, String? title, String? alt) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              // TODO: fix this hardcoded url
              // width: 250,
              imageUrl: ApiConstants.projectUrl + uri.toString(),
              placeholder: (context, url) =>
                  const CircularProgressIndicator.adaptive(),
              httpHeaders: TokenHelper.getHeaderToken,

              errorWidget: (context, url, error) =>
                  const Icon(Icons.image_not_supported_rounded),
            ),
          ),
        );
      },
    );
  }
}
