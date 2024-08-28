import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';

class EditValueBottomSheet extends StatelessWidget {
  const EditValueBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.70,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        // height: 800,
        decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: SafeArea(
          child: Hero(
            tag: 'test',
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(2),
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
