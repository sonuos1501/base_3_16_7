part of 'video_tab_bloc.dart';

@freezed
class VideoTabState with _$VideoTabState {
  const factory VideoTabState.initial({
    List<VideoDetailModel>? listVideosByChannelData,
  }) = VideoTabInitialState;
  const factory VideoTabState.loading() = VideoTabLoadingState;
}
