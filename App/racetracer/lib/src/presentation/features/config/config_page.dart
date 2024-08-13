import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:racetracer/src/presentation/constants/fonts.dart';
import 'package:racetracer/src/presentation/widgets/stretched_button.dart';

class ConfigPage extends StatefulWidget {
  static const routeName = '/config';

  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.configuration),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ListTile(
                title: TextField(
                  onChanged: (value) => setState(() {}),
                  // controller:
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(6),
                    isDense: true,
                    hintText: AppLocalizations.of(context)!.projectID,
                    hintStyle: FontStyles.LIGHTGREY_REGULAR_16,
                  ),
                ),
              ),
              ListTile(
                title: TextField(
                  onChanged: (value) => setState(() {}),
                  // controller:
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(6),
                    isDense: true,
                    hintText: AppLocalizations.of(context)!.hostIP,
                    hintStyle: FontStyles.LIGHTGREY_REGULAR_16,
                  ),
                ),
              ),
              StretchedButton()
            ],
          ),
        ),
      )),
    );
  }
}
