import 'package:flutter/material.dart';

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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: onPressed,
          child: child,
        ),
      ),
    );
  }
}
