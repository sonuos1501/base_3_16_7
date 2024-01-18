part of 'live_bloc.dart';

@freezed
class LiveState with _$LiveState {
  const factory LiveState.initial() = _Initial;

  const factory LiveState.menuState({@Default(0) int currentIndexMenu}) = LiveMenuState;
}
