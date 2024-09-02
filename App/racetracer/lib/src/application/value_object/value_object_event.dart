part of 'value_object_bloc.dart';

sealed class ValueObjectEvent extends Equatable {
  const ValueObjectEvent();

  @override
  List<Object> get props => [];
}

class FetchValueObjects extends ValueObjectEvent {}
