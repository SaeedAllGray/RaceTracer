import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racetracer/src/application/auth/auth_bloc.dart';
import 'package:racetracer/src/infrastructure/datasources/git_remote/gitlab_data_source.dart';
import 'package:racetracer/src/presentation/features/config/config_page.dart';
import 'package:racetracer/src/presentation/home/home_page.dart';
import 'package:racetracer/src/presentation/widgets/stretched_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthPage extends StatefulWidget {
  static const routeName = '/';
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final GitAuthLabDataSource gitLabOAuth = GitAuthLabDataSource();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(RetrieveDataEvent()),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuceedState) {
            Navigator.pushReplacementNamed(context, HomePage.routeName);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
                title: Text(
              AppLocalizations.of(context)!.appTitle,
            )),
            body: Center(
              child: StretchedButton(
                onPressed: () async {
                  BlocProvider.of<AuthBloc>(context).add(LoginEvent());
                },
                child: Text(
                  AppLocalizations.of(context)!.signIn,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
