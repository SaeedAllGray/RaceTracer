import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racetracer/src/application/auth/auth_bloc.dart';
import 'package:racetracer/src/infrastructure/datasources/git_remote/gitlab_data_source.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/constants/fonts.dart';
import 'package:racetracer/src/presentation/features/config/config_page.dart';
import 'package:racetracer/src/presentation/home/home_page.dart';
import 'package:racetracer/src/presentation/widgets/stretched_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthPage extends StatefulWidget {
  static const routeName = '/auth';
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/car.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: /* add child content here */

            BlocProvider(
          create: (context) => AuthBloc()..add(RetrieveDataEvent()),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuceedState) {
                Navigator.pushReplacementNamed(context, HomePage.routeName);
              }
            },
            builder: (context, state) {
              return state is! AuthInProgress
                  ? Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: StretchedButton(
                        onPressed: () async {
                          BlocProvider.of<AuthBloc>(context).add(LoginEvent());
                        },
                        child: Text(
                          AppLocalizations.of(context)!.signIn,
                        ),
                      ),
                    )
                  : Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: BlinkText(
                        endColor: AppColors.white,
                        beginColor: AppColors.primary,
                        duration: const Duration(seconds: 2),
                        AppLocalizations.of(context)!.loading,
                        style: FontStyles.WHITE_BOLD_24,
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
