part of 'interaction_cubit.dart';

@freezed
class InteractionState with _$InteractionState {
  const factory InteractionState.initial() = _Initial;
  const factory InteractionState.noInteraction() = _NonInteraction;
}
