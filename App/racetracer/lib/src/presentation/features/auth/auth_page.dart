import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:racetracer/src/infrastructure/datasources/git_remote/gitlab_data_source.dart';
import 'package:racetracer/src/presentation/widgets/stretched_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final GitLabDataSource gitLabOAuth = GitLabDataSource();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GitLab OAuth2 Sign-In')),
      body: Center(
        child: StretchedButton(
          onPressed: () async {
            await gitLabOAuth.signInWithGitLab();
          },
          child: Text('Sign in with GitLab'),
        ),
      ),
    );
  }
}
