import 'package:flutter/material.dart';
import 'package:racetracer/src/domain/entries/value_object.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/constants/fonts.dart';

class ValueObjectWidget extends StatelessWidget {
  final bool isEditing;
  final ValueObject valueObject;
  const ValueObjectWidget(
      {super.key, required this.valueObject, required this.isEditing});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          // border: hasError() ? Border.all(color: AppColors.warning) : null,
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              spreadRadius: 1,
              color: AppColors.GREY.withOpacity(0.3),
              offset: const Offset(0, 5),
            )
          ]),
      margin: EdgeInsets.all(isEditing ? 10 : 5),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasError()) const Icon(Icons.warning_amber_rounded),
          valueTile(),
          const Spacer(),
          Text(
            valueObject.topic,
            style: FontStyles.BLACK_MEDIUM_12,
          ),
          Text(
            valueObject.label ?? '',
            style: FontStyles.BLACK_MEDIUM_18
                .copyWith(color: Theme.of(context).colorScheme.primary),
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

  Widget valueTile() {
    if (hasError()) {
      return Text(
        valueObject.value.toString(),
        style: FontStyles.BLACK_MEDIUM_12,
      );
    } else if (valueObject.value == null) {
      return const CircularProgressIndicator.adaptive();
    } else {
      return Text(
        valueObject.value.toString(),
        style: FontStyles.BLACK_BOLD_36,
      );
    }
  }

  bool hasError() {
    return valueObject.value.toString().contains('racetracer_log');
  }
}
