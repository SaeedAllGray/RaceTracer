import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Validators {
  static String? validateNumber(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.shouldNotBeEmpty;
    }
    final regex = RegExp(r'^\d{1,5}$');
    if (!regex.hasMatch(value)) {
      return AppLocalizations.of(context)!.upTo5Digits;
    }
    return null;
  }

  static String? urlValidator(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.shouldNotBeEmpty;
    }

    // Regular expression to validate a URL or IP address with optional port
    final regex = RegExp(
      r'^(https?:\/\/)?' // Optional http or https
      r'((([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,})|' // Domain name
      r'((\d{1,3}\.){3}\d{1,3}))' // OR IPv4 address
      r'(:\d{1,5})?$', // Optional port
      caseSensitive: false,
    );

    if (!regex.hasMatch(value)) {
      return AppLocalizations.of(context)!.validIP;
    }

    return null; // Input is valid
  }
}
