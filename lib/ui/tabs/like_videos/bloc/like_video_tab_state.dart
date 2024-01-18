part of 'like_video_tab_bloc.dart';

@freezed
class LikeVideoTabState with _$LikeVideoTabState {
  const factory LikeVideoTabState.loading() = LikeVideoTabLoadingState;
  const factory LikeVideoTabState.fail() = LikeVideoTabFailState;

  const factory LikeVideoTabState.listLikeVideosByChannelData({
    @Default([]) List<VideoDetailModel> listVideosByChannelData,
  }) = LikeVideoTablistLikeVideosByChannelDataState;
}
