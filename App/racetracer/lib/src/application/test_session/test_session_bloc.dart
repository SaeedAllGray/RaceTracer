import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:racetracer/src/domain/entries/test_session.dart';
import 'package:racetracer/src/infrastructure/repositories/test_session_repository.dart';

part 'test_session_event.dart';
part 'test_session_state.dart';

class TestSessionBloc extends Bloc<TestSessionEvent, TestSessionState> {
  TestSessionBloc() : super(TestSessionInitial()) {
    on<GetTestSessions>(_onGetTestSessionEvent);
  }
  FutureOr<void> _onGetTestSessionEvent(
      GetTestSessions event, Emitter<TestSessionState> emit) async {
    emit(TestSessionInProgress());
    TestSessionRepository repository = TestSessionRepository();
    List<TestSession> testSessions = await repository.fetchEntities();
    emit(TestSessionsFetched(testSessions: testSessions));
  }
}
