part of 'premium_bloc.dart';

@freezed
class PremiumEvent with _$PremiumEvent {
  const factory PremiumEvent.loadedMostBuyVideos({ required ArgumentsMostBuyVideosData argumentsMostBuyVideosData }) = LoadedMostBuyVideos;
  const factory PremiumEvent.loadedChannelYouMightLike({ required ArgumentsAllListVideosData argumentsAllListVideosData }) = LoadedChannelYouMightLike;
}
