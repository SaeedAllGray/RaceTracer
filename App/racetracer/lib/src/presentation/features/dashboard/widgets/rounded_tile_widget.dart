import 'package:flutter/material.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/constants/fonts.dart';

class RoundedTileWidget extends StatelessWidget {
  final String title;
  final Widget child;
  const RoundedTileWidget(
      {super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: FontStyles.BLACK_MEDIUM_16,
          ),
          child
        ],
      ),
    );
  }
}
