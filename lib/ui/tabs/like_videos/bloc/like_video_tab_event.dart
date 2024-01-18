part of 'like_video_tab_bloc.dart';

@freezed
class LikeVideoTabEvent with _$LikeVideoTabEvent {
  const factory LikeVideoTabEvent.loadedLikeVideos({ required ArgumentsLikeVideosByChannelData argumentsLikeVideosByChannelData }) = LoadedLikeVideos;
}
