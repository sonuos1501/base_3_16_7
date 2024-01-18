part of 'live_bloc.dart';

@freezed
class LiveEvent with _$LiveEvent {
  const factory LiveEvent.started() = _Started;

  const factory LiveEvent.selectMenu({@Default(0) int index}) = LiveSelectMenuEvent;
}
