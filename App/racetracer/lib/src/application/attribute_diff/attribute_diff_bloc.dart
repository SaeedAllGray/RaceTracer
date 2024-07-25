import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:racetracer/src/infrastructure/repositories/attribute_diff_repository.dart';
import 'package:racetracer/src/domain/entries/attribute_diff.dart';

part 'attribute_diff_event.dart';
part 'attribute_diff_state.dart';

class AttributeDiffBloc extends Bloc<AttributeDiffEvent, AttributeDiffState> {
  AttributeDiffBloc() : super(AttributeDiffInitial()) {
    on<GetAttributeDiffs>(_onGetGetAttributeDiffsEvent);
  }
  FutureOr<void> _onGetGetAttributeDiffsEvent(
      GetAttributeDiffs event, Emitter<AttributeDiffState> emit) async {
    emit(AttributeDiffInProgress());
    AttributeDiffRepository repository = AttributeDiffRepository();
    List<AttributeDiff> attributeDiffs = await repository.fetchEntities();
    emit(AttributeDiffsFetched(attributeDiffs: attributeDiffs));
  }
}
