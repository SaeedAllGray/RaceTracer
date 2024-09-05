part of 'value_object_bloc.dart';

sealed class ValueObjectEvent extends Equatable {
  const ValueObjectEvent();

  @override
  List<Object> get props => [];
}

class FetchValueObjects extends ValueObjectEvent {}

class FetchValueObjectsStream extends ValueObjectEvent {}

class FetchServerScripts extends ValueObjectEvent {}

class SaveScriptValueObject extends ValueObjectEvent {
  final ValueObject valueObject;

  const SaveScriptValueObject({required this.valueObject});
}
