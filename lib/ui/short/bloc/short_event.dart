part of 'short_bloc.dart';

@freezed
class ShortEvent with _$ShortEvent {
  const factory ShortEvent.loadedShortVideos({ required ArgumentsAllListVideosData argumentsAllListVideosData }) = LoadedShortVideos;
  const factory ShortEvent.likedOrDislikedVideo({ required ArgumentsLikeDislike argumentsLikeDislike }) = LikedOrDislikedVideo;
}
