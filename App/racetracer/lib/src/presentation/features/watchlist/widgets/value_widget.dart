import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/constants/fonts.dart';
import 'package:racetracer/src/presentation/features/watchlist/widgets/edit_value_bottom_sheet.dart';
import 'package:racetracer/src/presentation/widgets/stretched_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ValueWidget extends StatelessWidget {
  const ValueWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'test',
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.bubble,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(2),
        child: Column(
          children: [
            const Text(
              'Title',
              style: FontStyles.BLACK_REGULAR_18,
            ),
            const Text(
              '43',
              style: FontStyles.BLACK_BOLD_24,
            ),
            const Spacer(),
            SizedBox(
              height: 50,
              child: StretchedButton(
                onPressed: () => showModalBottomSheet<void>(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return const EditValueBottomSheet();
                    }),
                child: Text(AppLocalizations.of(context)!.edit),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
