part of 'value_object_bloc.dart';

sealed class ValueObjectState extends Equatable {
  const ValueObjectState();

  @override
  List<Object> get props => [];
}

final class ValueObjectInitial extends ValueObjectState {}

final class ValueObjectsFetched extends ValueObjectState {
  final List<ValueObject> valueObjects;

  const ValueObjectsFetched({required this.valueObjects});
  @override
  List<Object> get props => valueObjects;
}

final class ValueObjectsStreaming extends ValueObjectState {
  final Stream valueObjectsStream;

  const ValueObjectsStreaming({required this.valueObjectsStream});
}

final class ValueObjectsFailed extends ValueObjectState {}
