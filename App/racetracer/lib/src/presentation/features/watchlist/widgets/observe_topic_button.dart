import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/constants/fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ObserveTopicButton extends StatelessWidget {
  const ObserveTopicButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bubble.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.add_rounded,
            color: AppColors.primary,
            size: 40,
          ),
          // const Spacer(),
          Text(
            AppLocalizations.of(context)!.observe_topic,
            style: FontStyles.GRAY_MEDIUM_16,
          ),
          // SizedBox(
          //   height: 50,
          //   child: StretchedButton(
          //     onPressed: () => showModalBottomSheet<void>(
          //         isScrollControlled: true,
          //         context: context,
          //         builder: (BuildContext context) {
          //           return const EditValueBottomSheet();
          //         }),
          //     child: Text(AppLocalizations.of(context)!.edit),
          //   ),
          // ),
        ],
      ),
    );
  }
}
