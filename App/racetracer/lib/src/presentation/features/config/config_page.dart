import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racetracer/src/application/config/config_bloc.dart';
import 'package:racetracer/src/application/core/validators.dart';
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

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
            child: BlocProvider(
              create: (context) => ConfigBloc()..add(FetchDataEvent()),
              child: BlocListener<ConfigBloc, ConfigState>(
                listener: (context, state) {
                  if (state is FetchSucceedState) {
                    _numberController.text = state.projectID;
                    _urlController.text = state.hostIP;
                  }
                },
                child: BlocBuilder<ConfigBloc, ConfigState>(
                  builder: (context, state) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ListTile(
                            title: TextFormField(
                              onChanged: (value) => setState(() {}),
                              validator: (input) =>
                                  Validators.validateNumber(context, input),
                              controller: _numberController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(6),
                                isDense: true,
                                hintText:
                                    AppLocalizations.of(context)!.projectID,
                                hintStyle: FontStyles.LIGHTGREY_REGULAR_16,
                              ),
                            ),
                          ),
                          ListTile(
                            title: TextFormField(
                              onChanged: (value) => setState(() {}),
                              validator: (input) =>
                                  Validators.urlValidator(context, input),
                              controller: _urlController,
                              keyboardType: TextInputType.url,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(6),
                                isDense: true,
                                hintText: AppLocalizations.of(context)!.hostIP,
                                hintStyle: FontStyles.LIGHTGREY_REGULAR_16,
                              ),
                            ),
                          ),
                          StretchedButton(
                            onPressed: _isFormValid()
                                ? () {
                                    BlocProvider.of<ConfigBloc>(context).add(
                                        SaveEvent(
                                            projectID: _numberController.text,
                                            hostIP: _urlController.text));
                                  }
                                : null,
                            child: Text(AppLocalizations.of(context)!.save),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isFormValid() {
    return _formKey.currentState?.validate() ?? false;
  }
}
