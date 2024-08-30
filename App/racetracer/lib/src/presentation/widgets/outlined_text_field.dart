import 'package:flutter/material.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';

class OutlinedTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final VoidCallback? onClearPressed;
  final Function(String)? onChanged;
  const OutlinedTextField({
    super.key,
    this.controller,
    this.hintText,
    this.onClearPressed,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: hintText,
          fillColor: AppColors.primary.withOpacity(0.15),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.white,
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              if (onClearPressed != null) {
                onClearPressed!();
              }
              controller?.clear();
            },
            icon: const Icon(Icons.clear),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10)),
      onChanged: onChanged,
    );
  }
}
