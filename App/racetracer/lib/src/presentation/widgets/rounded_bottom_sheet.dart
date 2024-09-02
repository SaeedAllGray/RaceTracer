import 'package:flutter/material.dart';

import 'package:racetracer/src/presentation/constants/colors.dart';

class RoundedBottomSheet extends StatelessWidget {
  final Widget child;
  const RoundedBottomSheet({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.70,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        // height: 800,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.maximize_rounded,
                    color: AppColors.bubble,
                    size: 40,
                  ),
                ),
              ),
              Expanded(child: child)
            ],
          ),
        ),
      ),
    );
  }
}
