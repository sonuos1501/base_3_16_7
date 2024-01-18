part of 'short_bloc.dart';

@freezed
class ShortState with _$ShortState {
  const factory ShortState.loading() = ShortLoadingState;
  const factory ShortState.fail({ String? error }) = ShortFailState;

  const factory ShortState.shortVideos({
    List<VideoDetailModel>? shorts,
    @Default(false) bool isLoading,
  }) = ShortGetShortVideosState;
  const factory ShortState.likeDislikeVideo({ String? successType }) = ShortLikeDislikeVideoState;
}
