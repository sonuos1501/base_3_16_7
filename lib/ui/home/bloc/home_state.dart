part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.loading() = HomeLoadingState;
  const factory HomeState.fail() = HomeFailState;

  const factory HomeState.menuState({ @Default(0) int currentIndexMenu }) = HomeMenuState;
  const factory HomeState.categories({ CategoriesData? categoriesData }) = HomeCategoriesState;
  const factory HomeState.allListVideos({
    AllListVideosData? categoriesData,
    @Default(1) int page,
    @Default(true) bool isLoading,
  }) = HomeAllListVideosState;
  const factory HomeState.homeVideos({
    HomeVideosData? homeVideosData,
    @Default(true) bool isLoading,
    @Default(false) bool haveClearData,
  }) = HomeGetHomeVideosState;
}
