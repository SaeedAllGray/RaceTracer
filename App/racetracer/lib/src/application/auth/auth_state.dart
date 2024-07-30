part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthInProgress extends AuthState {}

final class AuthFailedState extends AuthState {}

final class AuthSuceedState extends AuthState {}
