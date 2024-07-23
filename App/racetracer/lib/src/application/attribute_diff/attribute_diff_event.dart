part of 'attribute_diff_bloc.dart';

sealed class AttributeDiffEvent extends Equatable {
  const AttributeDiffEvent();

  @override
  List<Object> get props => [];
}

class GetAttributeDiffs extends AttributeDiffEvent {}
