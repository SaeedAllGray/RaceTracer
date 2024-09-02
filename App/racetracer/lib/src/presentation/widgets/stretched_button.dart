import 'package:flutter/material.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/constants/fonts.dart';

class StretchedButton extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final void Function()? onPressed;
  final Widget? child;
  const StretchedButton({super.key, this.onPressed, this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: onPressed,
          child: child,
        ),
      ),
    );
  }
}
