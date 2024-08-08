import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:racetracer/src/domain/entries/token/git_token.dart';
import 'package:racetracer/src/infrastructure/datasources/local/local_data_source.dart';
import 'package:racetracer/src/infrastructure/repositories/auth_repository.dart';
import 'package:racetracer/src/presentation/helpers/token_helper.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository = AuthRepository();
  final LocalDataSource dataSource = LocalDataSource();
  AuthBloc() : super(AuthInitial()) {
    on<RetrieveDataEvent>(_onRetrieveDataEvent);
    on<LoginEvent>(_onLoginEvent);
  }

  FutureOr<void> _onRetrieveDataEvent(
      RetrieveDataEvent event, Emitter<AuthState> emit) async {
    final GitToken? savedToken = await dataSource.getGitToken();
    if (savedToken != null) {
      final GitToken? token = await repository.refreshToken();

      if (token != null) {
        TokenHelper.setToken();

        emit(AuthSuceedState());
      }
    }
  }

  FutureOr<void> _onLoginEvent(
      LoginEvent event, Emitter<AuthState> emit) async {
    // final GitToken? authToken = await repository.loginWithGitlab();
    final AuthorizationTokenResponse? authToken =
        await repository.signInWithGitLab();
    if (authToken != null) {
      final GitToken gitToken = GitToken.fromAuthResponce(authToken);
      await dataSource.saveGitToken(gitToken);
      TokenHelper.setToken();
      emit(AuthSuceedState());
    } else {
      emit(AuthFailedState());
    }
  }
}
