import 'package:flutter/material.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/constants/fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InOutWidget extends StatelessWidget {
  final Widget title;
  final List<String> list;
  const InOutWidget({super.key, required this.title, required this.list});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: list.isEmpty
                ? const [Text('-')]
                : list
                    .map(
                      (e) => Text(
                        e,
                        style: FontStyles.GREY_LIGHT_14,
                      ),
                    )
                    .toList(),
          )
        ],
      ),
    );
  }
}
