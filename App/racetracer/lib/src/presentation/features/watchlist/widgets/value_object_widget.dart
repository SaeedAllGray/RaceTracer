import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:racetracer/src/domain/entries/value_object.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/constants/fonts.dart';
import 'package:racetracer/src/presentation/features/watchlist/widgets/add_value_object_bottom_sheet.dart';
import 'package:racetracer/src/presentation/widgets/stretched_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ValueObjectWidget extends StatelessWidget {
  final ValueObject valueObject;
  const ValueObjectWidget({super.key, required this.valueObject});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bubble,
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            valueObject.value,
            style: FontStyles.BLACK_BOLD_36,
          ),
          const Spacer(),
          Text(
            valueObject.label,
            style: FontStyles.BLACK_MEDIUM_16,
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
