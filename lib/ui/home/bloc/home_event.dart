part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.started() = _Started;

  const factory HomeEvent.selectedMenu({ @Default(0) int currentIndexMenu }) = HomeSelectedMenuEvent;
  const factory HomeEvent.loadedCategories() = LoadedCategories;
  const factory HomeEvent.loadedAllListVideos({ required ArgumentsAllListVideosData argumentsAllListVideosData }) = LoadedAllListVideos;
  const factory HomeEvent.loadedHomeVideos({ required ArgumentsHomeVideosData argumentsHomeVideosData }) = LoadedHomeVideos;
}
