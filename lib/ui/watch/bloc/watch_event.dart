part of 'watch_bloc.dart';

@freezed
class WatchEvent with _$WatchEvent {
  const factory WatchEvent.started() = _Started;
  const factory WatchEvent.autoPlay({@Default(false) autoPlay}) = AutoPlayWatchEvent;
}
