part of 'watch_bloc.dart';

@freezed
class WatchState with _$WatchState {
  const factory WatchState.initial() = _Initial;
  const factory WatchState.autoPlay({@Default(false) autoPlay}) = AutoPlayWatchState;
  const factory WatchState.video({VideoDetailModel? video}) = WatchStateVideo;
}
