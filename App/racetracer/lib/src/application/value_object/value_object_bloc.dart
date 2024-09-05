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
    on<FetchServerScripts>(_onFetchServerScriptsEvent);
    on<SaveScriptValueObject>(_onSaveScriptValueObjectEvent);
    on<FetchValueObjectsStream>(_onFetchValueObjectsStreamEvent);
  }
  FutureOr<void> _onFetchValueObjectsEvent(
      FetchValueObjects event, Emitter<ValueObjectState> emit) async {
    ValueObjectRepository repository = ValueObjectRepository();
    List<ValueObject> valueObjects = await repository.getRemoteEntities();

    emit(ValueObjectsFetched(valueObjects: valueObjects));
  }

  FutureOr<void> _onFetchValueObjectsStreamEvent(
      FetchValueObjectsStream event, Emitter<ValueObjectState> emit) async {
    ValueObjectRepository repository = ValueObjectRepository();
    Stream stream = repository.getEntitiesStream();

    emit(ValueObjectsStreaming(valueObjectsStream: stream));
  }

  FutureOr<void> _onFetchServerScriptsEvent(
      FetchServerScripts event, Emitter<ValueObjectState> emit) async {
    emit(ValueObjectInProgress());
    ValueObjectRepository repository = ValueObjectRepository();
    List<ValueObject> valueObjects = await repository.getScripts();
    emit(ValueObjectsFetched(valueObjects: valueObjects));
  }

  FutureOr<void> _onSaveScriptValueObjectEvent(
      SaveScriptValueObject event, Emitter<ValueObjectState> emit) async {
    ValueObjectRepository repository = ValueObjectRepository();
    await repository.saveScript(event.valueObject);
  }
}
