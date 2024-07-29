part of 'test_session_bloc.dart';

sealed class TestSessionState extends Equatable {
  const TestSessionState();

  @override
  List<Object> get props => [];
}

final class TestSessionInitial extends TestSessionState {}

class TestSessionInProgress extends TestSessionState {}

class TestSessionsFetched extends TestSessionState {
  final List<TestSession> testSessions;

  const TestSessionsFetched({required this.testSessions});
}
