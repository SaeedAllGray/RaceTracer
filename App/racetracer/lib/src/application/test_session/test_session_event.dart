part of 'test_session_bloc.dart';

sealed class TestSessionEvent extends Equatable {
  const TestSessionEvent();

  @override
  List<Object> get props => [];
}

class GetTestSessions extends TestSessionEvent {}
