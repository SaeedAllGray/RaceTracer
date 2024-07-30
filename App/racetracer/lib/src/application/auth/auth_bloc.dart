import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:racetracer/src/infrastructure/datasources/local/local_data_source.dart';
import 'package:racetracer/src/infrastructure/repositories/auth_repository.dart';

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
    try {
      emit(AuthInProgress());
      final String? token = await dataSource.getToken();
      // final String? refreshtoken = await dataSource.getRefreshToken(); //TODO: referesh Token later
      // final DateTime? expirationDate = await dataSource.getExpirationDate();
      if (token != null) {
        emit(AuthSuceedState());
      }
    } catch (e) {
      emit(AuthFailedState());
    }
  }

  FutureOr<void> _onLoginEvent(
      LoginEvent event, Emitter<AuthState> emit) async {
    final AuthorizationTokenResponse? authToken =
        await repository.signInWithGitLab();

    if (authToken != null) {
      await dataSource.saveToken(authToken);
      emit(AuthSuceedState());
    } else {
      emit(AuthFailedState());
    }
  }
}
