part of 'short_tab_bloc.dart';

@freezed
class ShortTabState with _$ShortTabState {
  const factory ShortTabState.initial({
    List<ShortData>? listShort,
  }) = ShortTabInitialState;
  const factory ShortTabState.loading() = ShortTabLoadingState;
}
