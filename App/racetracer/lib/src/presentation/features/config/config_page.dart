import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racetracer/src/application/config/config_bloc.dart';
import 'package:racetracer/src/application/core/validators.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:racetracer/src/presentation/constants/fonts.dart';
import 'package:racetracer/src/presentation/features/auth/auth_page.dart';
import 'package:racetracer/src/presentation/home/home_page.dart';
import 'package:racetracer/src/presentation/widgets/outlined_text_field.dart';
import 'package:racetracer/src/presentation/widgets/stretched_button.dart';

class ConfigPage extends StatefulWidget {
  final bool? firstPage;
  static const routeName = '/';

  const ConfigPage({super.key, this.firstPage = true});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConfigBloc()
        ..add(FetchDataEvent())
        ..add(DownloadDataEvent(hostIP: _urlController.text)),
      child: BlocListener<ConfigBloc, ConfigState>(
        listener: (context, state) {
          if (state is DataDeletedState) {
            Navigator.pushReplacementNamed(context, ConfigPage.routeName);
          } else if (state is DownloadSucceedState && widget.firstPage!) {
            Navigator.pushReplacementNamed(context, AuthPage.routeName);
          } else if (state is SavedSucceedState) {
            _urlController.text = state.hostIP;
          } else if (state is FetchSucceedState) {
            print(state.hostIP);
            _urlController.text = state.hostIP;
            if (widget.firstPage!) {
              Navigator.pushReplacementNamed(context, HomePage.routeName);
            }
          }
        },
        child: BlocBuilder<ConfigBloc, ConfigState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  AppLocalizations.of(context)!.configuration,
                ),
                actions: [
                  !(widget.firstPage!)
                      ? IconButton(
                          onPressed: _isFormValid()
                              ? () {
                                  BlocProvider.of<ConfigBloc>(context).add(
                                      SaveEvent(hostIP: _urlController.text));
                                  BlocProvider.of<ConfigBloc>(context).add(
                                      DownloadDataEvent(
                                          hostIP: _urlController.text));
                                }
                              : null,
                          icon: const Icon(
                            Icons.refresh,
                          ),
                        )
                      : const SizedBox.shrink()
                ],
              ),
              body: SafeArea(
                child: state is! ConfigInProgressState
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              OutlinedTextField(
                                onChanged: (value) => setState(() {}),
                                hintText: AppLocalizations.of(context)!.hostIP,
                                validator: (input) =>
                                    Validators.urlValidator(context, input),
                                controller: _urlController,
                                keyboardType: TextInputType.url,
                              ),
                              const SizedBox(height: 10),
                              Visibility(
                                visible: state is DownloadSucceedState ||
                                    state is FetchSucceedState,
                                child: Text(
                                  AppLocalizations.of(context)!.connected,
                                  style: FontStyles.GREEN_LIGHT_14,
                                ),
                              ),
                              Visibility(
                                  visible: state is DownloadFailedState,
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .serverConnectionFailed,
                                    style: FontStyles.RED_LIGHT_14,
                                  )),
                              const SizedBox(height: 10),
                              Text(
                                AppLocalizations.of(context)!.configDescription,
                                style: FontStyles.GREY_LIGHT_14,
                              ),
                              Visibility(
                                visible: state is! ConfigInProgressState,
                                child: Expanded(
                                  child: Align(
                                    alignment: FractionalOffset.bottomCenter,
                                    child: widget.firstPage!
                                        ? StretchedButton(
                                            onPressed: _isFormValid()
                                                ? () {
                                                    BlocProvider.of<ConfigBloc>(
                                                            context)
                                                        .add(DownloadDataEvent(
                                                            hostIP:
                                                                _urlController
                                                                    .text));
                                                  }
                                                : null,
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .download,
                                            ),
                                          )
                                        : StretchedButton(
                                            onPressed: () {
                                              BlocProvider.of<ConfigBloc>(
                                                      context)
                                                  .add(SignoutEvent());
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .signout,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Center(
                        child: BlinkText(
                          endColor: AppColors.white,
                          beginColor: AppColors.primary,
                          duration: const Duration(seconds: 2),
                          AppLocalizations.of(context)!.loading,
                          style: FontStyles.WHITE_BOLD_24,
                        ),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }

  bool _isFormValid() {
    return _formKey.currentState?.validate() ?? false;
  }
}
