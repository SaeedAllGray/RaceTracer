part of 'attribute_diff_bloc.dart';

sealed class AttributeDiffState extends Equatable {
  const AttributeDiffState();

  @override
  List<Object> get props => [];
}

final class AttributeDiffInitial extends AttributeDiffState {}

class AttributeDiffInProgress extends AttributeDiffState {}

class AttributeDiffsFetched extends AttributeDiffState {
  final List<AttributeDiff> attributeDiffs;

  const AttributeDiffsFetched({required this.attributeDiffs});
}
