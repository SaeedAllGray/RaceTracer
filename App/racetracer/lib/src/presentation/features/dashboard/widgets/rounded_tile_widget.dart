import 'package:flutter/material.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/constants/fonts.dart';

class RoundedTileWidget extends StatelessWidget {
  final String title;
  final Widget child;
  final void Function()? onTap;
  const RoundedTileWidget(
      {super.key, required this.child, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onTap: onTap,
            trailing:
                onTap != null ? const Icon(Icons.chevron_right_rounded) : null,
            title: Text(
              title,
              style: FontStyles.BLACK_MEDIUM_16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: child,
          )
        ],
      ),
    );
  }
}
