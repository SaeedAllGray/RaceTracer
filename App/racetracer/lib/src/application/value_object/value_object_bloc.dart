import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:racetracer/src/domain/entries/value_object.dart';
import 'package:racetracer/src/infrastructure/repositories/value_object_repository.dart';

part 'value_object_event.dart';
part 'value_object_state.dart';

class ValueObjectBloc extends Bloc<ValueObjectEvent, ValueObjectState> {
  ValueObjectBloc() : super(ValueObjectInitial()) {
    on<FetchValueObjects>(_onFetchValueObjectsEvent);
  }
  FutureOr<void> _onFetchValueObjectsEvent(
      FetchValueObjects event, Emitter<ValueObjectState> emit) async {
    ValueObjectRepository repository = ValueObjectRepository();
    List<ValueObject> valueObjects = await repository.getRemoteEntities();
    emit(ValueObjectsFetched(valueObjects: valueObjects));
  }
}
